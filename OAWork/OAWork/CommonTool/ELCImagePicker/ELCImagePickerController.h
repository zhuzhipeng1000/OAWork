//
//  ELCImagePickerController.h
//  ELCImagePickerDemo
//
//  Created by ELC on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCAssetSelectionDelegate.h"

@class ELCImagePickerController;
@class ELCAlbumPickerController;

@protocol ELCImagePickerControllerDelegate <UINavigationControllerDelegate>

/**
 * Called with the picker the images were selected from, as well as an array of dictionary's
 * containing keys for ALAssetPropertyLocation, ALAssetPropertyType, 
 * UIImagePickerControllerOriginalImage, and UIImagePickerControllerReferenceURL.
 * @param picker
 * @param info An NSArray containing dictionary's with the key UIImagePickerControllerOriginalImage, which is a rotated, and sized for the screen 'default representation' of the image selected. If you want to get the original image, use the UIImagePickerControllerReferenceURL key.
 */
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;

/**
 * Called when image selection was cancelled, by tapping the 'Cancel' BarButtonItem.
 */
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker;

@end

@interface ELCImagePickerController : UINavigationController <ELCAssetSelectionDelegate>

@property (nonatomic, strong) id<ELCImagePickerControllerDelegate> imagePickerDelegate;
@property (nonatomic, assign) NSInteger maximumImagesCount;
@property (nonatomic, assign) BOOL onOrder;
@property (nonatomic, assign) BOOL isEditImage;// add Suycity 2015-07-24
/**
 * An array indicating the media types to be accessed by the media picker controller.
 * Same usage as for UIImagePickerController.
 */
@property (nonatomic, strong) NSArray *mediaTypes;

/**
 * YES if the picker should return a UIImage along with other meta info (this is the default),
 * NO if the picker should return the assetURL and other meta info, but no actual UIImage.
 */
@property (nonatomic, assign) BOOL returnsImage;

/**
 * YES if the picker should return the original image,
 * or NO for an image suitable for displaying full screen on the device.
 * Does nothing if `returnsImage` is NO.
 */
@property (nonatomic, assign) BOOL returnsOriginalImage;

/**
 *  temporary  variable
 */
@property (nonatomic, copy) NSString *staging;
/**
 *  the selected image
 */
@property (nonatomic, strong) NSArray *referenceURLInfo;

//scale, isThumbSmall,isBase64Result

/**
 *  是否是需要缩略图 默认需要
 */
@property (nonatomic, assign) BOOL isThumbSmall;
/**
 *  缩略图的压缩的比例
 */
@property (nonatomic, assign) CGFloat thumScale;
/**
 *  @author Suycity, 16-02-16
 *
 *   图片的像素值，根据该值动态计算像素的缩放比例
 */
@property (nonatomic, assign) CGFloat maxPixel;
/**
 *  @author Suycity, 16-02-16
 *
 *  图片的大小KB
 */
@property (nonatomic, assign) CGFloat maxSize;
/**
 *  是否将图片内容进行Base64转换，默认不支持
 */
@property (nonatomic, assign) BOOL isBase64Result;
/**
 *  图片是否需要持久化。 若为true则将图片保存在Document和SD卡目录,否则保存到tmp
 */
@property (nonatomic, assign) BOOL isPersistence;

- (id)initImagePicker;
- (void)cancelImagePicker;

@end

