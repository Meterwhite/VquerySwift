//
//  NSURL+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/3.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(NSURLLinkBlock)
/** url of system photo lib to UIImage.Thumbnail/缩略图 */
@property LB_BK UIImage*         (^urlAssetsToUIImageByThumbnail)(void);
/** FullResolution/高清图 */
@property LB_BK UIImage*         (^urlAssetsToUIImageByFullResolution)(void);
/** FullScreen/全屏相片 */
@property LB_BK UIImage*         (^urlAssetsToUIImageByFullScreen)(void);
@property LB_BK NSData*          (^urlToNSDataFromContents)(void);
@end
