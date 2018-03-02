//
//  ELCImagePickerController.m
//  ELCImagePickerDemo
//
//  Created by ELC on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetCell.h"
#import "ELCAssetTablePicker.h"
#import "ELCAlbumPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "ELCConsole.h"
//#import "NSData+Base64.h"


@interface ELCImagePickerController ()
@property (nonatomic, strong) NSArray *Photos;
@end

#define PHOTO_CACHE_LOCATION [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), @"photos"]
@implementation ELCImagePickerController

//Using auto synthesizers

- (id)initImagePicker
{
    ELCAlbumPickerController *albumPicker = [[ELCAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
    
    self = [super initWithRootViewController:albumPicker];
    if (self) {
        self.maximumImagesCount = 4;
        self.returnsImage = YES;
        self.returnsOriginalImage = YES;
        self.isThumbSmall = YES;
        [albumPicker setParent:self];
        self.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{

    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.maximumImagesCount = 4;
        self.returnsImage = YES;
        self.isThumbSmall = YES;
    }
    return self;
}

- (ELCAlbumPickerController *)albumPicker
{
    return self.viewControllers[0];
}

- (void)setMediaTypes:(NSArray *)mediaTypes
{
    self.albumPicker.mediaTypes = mediaTypes;
}

- (NSArray *)mediaTypes
{
    return self.albumPicker.mediaTypes;
}

- (void)cancelImagePicker
{
	if ([_imagePickerDelegate respondsToSelector:@selector(elcImagePickerControllerDidCancel:)]) {
		[_imagePickerDelegate performSelector:@selector(elcImagePickerControllerDidCancel:)
                                   withObject:self];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount
{
    BOOL shouldSelect = previousCount < self.maximumImagesCount;
    if (!shouldSelect) {
        NSString *title = [NSString stringWithFormat:@"温馨提示"];
        NSString *message = [NSString stringWithFormat:@"您最多选择%d张照片.", (int)self.maximumImagesCount];
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定", nil] show];
    }
    return shouldSelect;
}

- (BOOL)shouldDeselectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount;
{
    return YES;
}

- (void)selectedAssets:(NSArray *)assets
{
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    //int tmp = 0;
    NSArray *sorts = [assets sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        ELCAsset *obj1_ = obj1;
        ELCAsset *obj2_ = obj2;
//            NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        return obj1_.index > obj2_.index ? NSOrderedDescending : NSOrderedAscending;
    }];

	for(ELCAsset *elcasset in sorts) {
        ALAsset *asset = elcasset.asset;
		id obj = [asset valueForProperty:ALAssetPropertyType];
		if (!obj) {
			continue;
		}
		NSMutableDictionary *workingDictionary = [NSMutableDictionary dictionary];
		
		CLLocation* wgs84Location = [asset valueForProperty:ALAssetPropertyLocation];
		if (wgs84Location) {
			[workingDictionary setObject:wgs84Location forKey:ALAssetPropertyLocation];
		}
        
        [workingDictionary setObject:obj forKey:UIImagePickerControllerMediaType];

        //This method returns nil for assets from a shared photo stream that are not yet available locally. If the asset becomes available in the future, an ALAssetsLibraryChangedNotification notification is posted.
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        NSString *assetPath = [[asset valueForProperty:ALAssetPropertyAssetURL] description];
        if(assetRep != nil) {
            if (_returnsImage) {
                CGImageRef imgRef = nil;
                //defaultRepresentation returns image as it appears in photo picker, rotated and sized,
                //so use UIImageOrientationUp when creating our image below.
                UIImageOrientation orientation = UIImageOrientationUp;
                
                imgRef = [assetRep fullScreenImage];
                
                orientation = (UIImageOrientation)[assetRep orientation];
                UIImage *img = [UIImage imageWithCGImage:imgRef
                                                   scale:1.0f
                                             orientation:orientation];
                [workingDictionary setObject:img forKey:UIImagePickerControllerOriginalImage];
                //降image保存到本地目录
                //将图片缓存在本地
                NSData *data;
                NSString* imgName;
                data = UIImageJPEGRepresentation(img, 0.5);
                imgName = [NSString stringWithFormat:@"%@/%f.PNG",PHOTO_CACHE_LOCATION,[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000];
                [data writeToFile:imgName atomically:YES];
                
                [workingDictionary setValue:imgName forKey:@"imgName"];
            }
            else{
                CGImageRef fullResolution,thumbnail;
                NSError *error = nil;
                
                time_t t;
                time(&t);
                int index = (int)[assets indexOfObject:elcasset];
                NSString *homePath = self.isPersistence  ? [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] : NSTemporaryDirectory();
                /**
                 *  全屏图
                 */
                fullResolution = [assetRep fullScreenImage];
                UIImage *fullResolutionImage = [UIImage imageWithCGImage:fullResolution];
                if (self.maxPixel) {
                    CGFloat maxPix = MAX(fullResolutionImage.size.width, fullResolutionImage.size.height);
                    if (self.maxPixel < maxPix) {
                        CGFloat scale = self.maxPixel/maxPix;
                        fullResolutionImage = [self imageWithImageSimple:fullResolutionImage scaledToSize:(CGSize){fullResolutionImage.size.width * scale, fullResolutionImage.size.height * scale}];
                    }
                }
                
                NSData *fullResolutionData = UIImagePNGRepresentation(fullResolutionImage);
                if(!fullResolutionData)fullResolutionData = UIImageJPEGRepresentation(fullResolutionImage,1);
                if (!(self.maxPixel || self.maxPixel)) {
                    if(self.thumScale)fullResolutionData = UIImageJPEGRepresentation(fullResolutionImage,MIN(self.thumScale, 1));
                }
                if (self.maxSize) {
                    // 计算文件大小
                    float lengKB = (float)[fullResolutionData length] / 1024 * 1.f;
                    if (lengKB > self.maxSize) {
                        fullResolutionData = UIImageJPEGRepresentation(fullResolutionImage,1.f);
                        lengKB = (float)[fullResolutionData length] / 1024;
                        if (lengKB > self.maxSize) {
                            fullResolutionData = UIImageJPEGRepresentation([UIImage imageWithData:fullResolutionData],self.maxSize/lengKB * 2);
                        }
                        lengKB = (float)[fullResolutionData length] / 1024;
                    }
                }
                
                NSString *resolutionPath = nil;
//                if (self.isBase64Result) {
//                    resolutionPath = [fullResolutionData base64Encoding];
//                }
//                else {
                    resolutionPath = [NSString stringWithFormat:@"resolution%d_%lu.png",index,t];
                    resolutionPath = [homePath stringByAppendingPathComponent:resolutionPath];
                    if (![fullResolutionData writeToFile:resolutionPath options:0 error:&error]) {
                        NSLog(@"write error : %@",error);
                    }
//                }
                [workingDictionary setObject:resolutionPath forKey:@"pic"];
                
                /**
                 *  缩略图
                 */
                if (self.isThumbSmall) {
                    thumbnail = [asset thumbnail];
                    UIImage *thumbnailImage = [UIImage imageWithCGImage:thumbnail];
                    NSData *thumbnailData = UIImagePNGRepresentation(thumbnailImage);
                    if(!thumbnailData)thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 1.0f);
                    NSString *thumbPath = nil;
//                    if (self.isBase64Result) {
//                        thumbPath = [thumbnailData base64Encoding];
//                    }
//                    else{
                        thumbPath = [NSString stringWithFormat:@"thumb%d_%lu.png",index,t];
                        thumbPath = [homePath stringByAppendingPathComponent:thumbPath];
                        if (![thumbnailData writeToFile:thumbPath options:0 error:&error]) {
                            NSLog(@"write error : %@",error);
                        }
//                    }
                    [workingDictionary setObject:thumbPath forKey:@"thumb"];
                }
                
                [workingDictionary removeObjectForKey:ALAssetPropertyLocation];
                
            }
            [workingDictionary setObject:assetPath
                                  forKey:UIImagePickerControllerReferenceURL];
            
            [returnArray addObject:workingDictionary];
        }
		
	}
    //倒序
    [self setPhotos:returnArray];
    if (!self.isEditImage) [self didFinishPickingMediaWithInfo];
}
- (void)didFinishPickingMediaWithInfo{
    if (_imagePickerDelegate != nil && [_imagePickerDelegate respondsToSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:)]) {
        [_imagePickerDelegate performSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:self.Photos];
    } else {
        [self popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

- (BOOL)onOrder
{
    return [[ELCConsole mainConsole] onOrder];
}

- (void)setOnOrder:(BOOL)onOrder
{
    [[ELCConsole mainConsole] setOnOrder:onOrder];
}

- (void)setReferenceURLInfo:(NSArray *)referenceURLInfo{
    _referenceURLInfo = nil;
    _referenceURLInfo = referenceURLInfo;
    id vc = self.viewControllers[0];
    if ([vc isKindOfClass:[ELCAlbumPickerController class]]) {
        [(ELCAlbumPickerController *)vc setReferenceURLInfo:referenceURLInfo];
    }
}
- (UIImage *)imageWithImageSimple:(UIImage *)image scale:(CGFloat)scale{
    return [self imageWithImageSimple:image scaledToSize:(CGSize){image.size.width*scale,image.size.height * scale}];
}
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
@end
