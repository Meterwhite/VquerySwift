//
//  UIImage+LinkBlock.m

//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//
#import "LinkBlock.h"
#import <Accelerate/Accelerate.h>
#import "LinkError.h"

@implementation NSObject(UIImageLinkBlockLinkBlock)

- (NSData *(^)(float))imgToData
{
    return ^id(float ratio){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgToData,ratio)
        NSData* reIsData = UIImageJPEGRepresentation(_self, ratio);
        if(!reIsData){
            reIsData= UIImagePNGRepresentation(_self);
        }
        return reIsData;
    };
}

- (UIImage *(^)(CGSize))imgResizeAspect
{
    return ^id(CGSize maxSize){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgResizeAspect,maxSize)
        CGFloat originWidth= _self.size.width;
        CGFloat originHeight= _self.size.height;
        CGFloat originRatio = originWidth / originHeight;//宽长比
        if(originWidth > maxSize.width || originHeight > maxSize.height)
        {
            CGFloat toRatio = maxSize.width / maxSize.height;//将要压缩到的宽长比
            if(originRatio > toRatio){//横向压，固定宽
                originRatio = maxSize.width / originWidth;
                originHeight = originRatio * originHeight;
                originWidth = maxSize.width;
            } else {//竖向压，固定高
                originRatio = maxSize.height / originHeight;
                originWidth = originRatio * originWidth;
                originHeight = maxSize.height;
            }
        }
        CGRect rect = CGRectMake(0.0, 0.0, originWidth, originHeight);
        UIGraphicsBeginImageContext(rect.size);
        [_self drawInRect:rect];  // scales image to rect
        UIImage* re = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return re;
    };
}

- (UIImage *(^)(CGRect))imgCut
{
    return ^id(CGRect frame){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgCut,frame)
        CGImageRef cgImgRef= CGImageCreateWithImageInRect(_self.CGImage, frame);
        UIImage* re= [UIImage imageWithCGImage:cgImgRef];
        CGImageRelease(cgImgRef);
        return re;
    };
}

//- (UIImage *(^)(float))imgBlur
//{
//    return ^id(float percent){
//        LinkHandle_REF(UIImage)
//        LinkGroupHandle_REF(imgBlur,percent)
//    };
//}

- (UIImage *(^)(UIColor *))imgBlurColor
{
    return ^id(UIColor* tintColor){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgBlurColor,tintColor)
        
        UIColor *effectColor = tintColor;
        size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
        if (componentCount == 2) {
            CGFloat b;
            if ([tintColor getWhite:&b alpha:NULL]) {
                effectColor = [UIColor colorWithWhite:b alpha:0.6];
            }
        }
        else {
            CGFloat r, g, b;
            if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
                effectColor = [UIColor colorWithRed:r green:g blue:b alpha:0.6];
            }
        }
        return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
    };
}

- (UIImage *(^)(void))imgBlurLight
{
    return ^id(){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgBlurLight)
        UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    };
}

- (UIImage *(^)(float))imgBlurLightRadius
{
    return ^id(float blurRadius){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgBlurLightRadius,blurRadius)
        UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        return [self applyBlurWithRadius:blurRadius tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    };
}

- (UIImage *(^)(void))imgBlurExtraLight
{
    return ^id(){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgBlurExtraLight)
        UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
        return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    };
}

- (UIImage *(^)(void))imgBlurDarkEffect
{
    return ^id(){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgBlurDarkEffect)
        UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
        return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    };
}

/**
 Refer to：https://github.com/lukabernardi/LBBlurredImage
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    UIImage* _self = self.asUIImage;
    // Check pre-conditions.
    if (_self.size.width < 1 || _self.size.height < 1) {
        return (id)[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", _self.size.width, _self.size.height, self]];
    }
    if (!_self.CGImage) {
        return (id)[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"*** error: image must be backed by a CGImage: %@", self]];
    }
    if (maskImage && !maskImage.CGImage) {
        return (id)[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"*** error: maskImage must be backed by a CGImage: %@", maskImage]];
    }
    
    CGRect imageRect = { CGPointZero, _self.size };
    UIImage *effectImage = _self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(_self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -_self.size.height);
        CGContextDrawImage(effectInContext, imageRect, _self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(_self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(_self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -_self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, _self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *(^)(UIImageRenderingMode))imgRenderingMode
{
    return ^id(UIImageRenderingMode mode){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgRenderingMode,mode)
        return [_self imageWithRenderingMode:mode];
    };
}

- (UIImage *(^)(UIImage *, CGRect))imgAddImg
{
    return ^id(UIImage* aImg , CGRect rect){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgAddImg,aImg,rect)
        UIGraphicsBeginImageContext(_self.size);
        [_self drawInRect:CGRectMake(0, 0, _self.size.width, _self.size.height)];
        [aImg drawInRect:rect];
        UIImage* reImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reImg;
    };
}

- (UIColor *(^)(void))imgGetPatternColor
{
    return ^id(){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgGetPatternColor)
        return [UIColor colorWithPatternImage:_self];
    };
}

- (UIImage *(^)(void))imgOrientationFix
{
    return ^id(){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgOrientationFix)
        
        if (_self.imageOrientation == UIImageOrientationUp) return _self;
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        switch (_self.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, _self.size.width, _self.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, _self.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
                
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, _self.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            default:
                break;
        }
        
        switch (_self.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, _self.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
                
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, _self.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            default:
                break;
        }
        
        CGContextRef ctx = CGBitmapContextCreate(NULL, _self.size.width, _self.size.height,
                                                 CGImageGetBitsPerComponent(_self.CGImage), 0,
                                                 CGImageGetColorSpace(_self.CGImage),
                                                 CGImageGetBitmapInfo(_self.CGImage));
        CGContextConcatCTM(ctx, transform);
        switch (_self.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                CGContextDrawImage(ctx, CGRectMake(0,0,_self.size.height,_self.size.width), _self.CGImage);
                break;
                
            default:
                CGContextDrawImage(ctx, CGRectMake(0,0,_self.size.width,_self.size.height), _self.CGImage);
                break;
        }
        
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        UIImage *reImg = [UIImage imageWithCGImage:cgimg];
        CGContextRelease(ctx);
        CGImageRelease(cgimg);
        return reImg;
    };
}

- (UIImage *(^)(CGFloat,CGFloat))imgStretchableImageWithLeftCapWidthAndTopCapHeight
{
    return ^id(CGFloat lWidth , CGFloat tHeight){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgStretchableImageWithLeftCapWidthAndTopCapHeight,lWidth,tHeight)
        return [_self stretchableImageWithLeftCapWidth:lWidth topCapHeight:tHeight];
    };
}

- (UIImage *(^)(CGFloat, CGFloat, CGFloat, CGFloat))imgResizableWithCapInsets
{
    return ^id(CGFloat top,CGFloat left,CGFloat bottom, CGFloat right){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgResizableWithCapInsets,top,left,bottom,right)
        return [_self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
    };
}

- (UIImageView *(^)(void))imgToUIImageView
{
    return ^id(){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgToUIImageView)
        return [[UIImageView alloc] initWithImage:_self];
    };
}

- (UIImage *(^)(id))imgSetToControl
{
    return ^id(id container){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgSetToControl,container)
        
        if(!container) return _self;
        
        if([_self respondsToSelector:@selector(setImage:)]){
            [container setImage:_self];
        }else if([_self respondsToSelector:@selector(setImage:forState:)]){
            [container setImage:_self forState:UIControlStateNormal];
        }else if([_self respondsToSelector:@selector(setBackground:)]){
            [container setBackground:_self];
        }else if([_self respondsToSelector:@selector(setBackgroundImage:)]){
            [container setBackgroundImage:_self];
        }
        
        return _self;
    };
}

- (NSObject *(^)(id))imgSetToControlAsWhatSet
{
    return ^id(id container){
        LinkHandle_REF(UIImage)
        LinkGroupHandle_REF(imgSetToControl,container)
        
        if(!container) return _self;
        self.imgSetToControl(container);
        return container;
    };
    
}
@end
