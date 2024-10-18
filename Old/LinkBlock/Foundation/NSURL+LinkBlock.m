//
//  NSURL+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/3.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation NSObject(NSURLLinkBlock)


- (UIImage *(^)(void))urlAssetsToUIImageByThumbnail
{
    return ^id(){
        LinkHandle_REF(NSURL)
        LinkGroupHandle_REF(urlAssetsToUIImageByThumbnail)
        __block UIImage* re = nil;
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:_self resultBlock:^(ALAsset *asset) {
            re = [UIImage imageWithCGImage:[asset thumbnail]];
        } failureBlock:nil];
        return re;
    };
}

- (UIImage *(^)(void))urlAssetsToUIImageByFullScreen
{
    return ^id(){
        LinkHandle_REF(NSURL)
        LinkGroupHandle_REF(urlAssetsToUIImageByFullScreen)
        __block UIImage* re = nil;
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:_self resultBlock:^(ALAsset *asset) {
            re = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        } failureBlock:nil];
        return re;
    };
}

- (UIImage *(^)(void))urlAssetsToUIImageByFullResolution
{
    return ^id(){
        LinkHandle_REF(NSURL)
        LinkGroupHandle_REF(urlAssetsToUIImageByFullResolution)
        __block UIImage* re = nil;
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:_self resultBlock:^(ALAsset *asset) {
            re = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
        } failureBlock:nil];
        return re;
    };
}

- (NSData *(^)(void))urlToNSDataFromContents
{
    return ^id(){
        LinkHandle_REF(NSURL)
        LinkGroupHandle_REF(urlToNSDataFromContents)
        return [NSData dataWithContentsOfURL:_self];
    };
}

@end
