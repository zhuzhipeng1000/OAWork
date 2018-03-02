//
//  Asset.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"

@interface ELCAsset ()
@end

@implementation ELCAsset


//Using auto synthesizers
- (NSString *)description
{
    return [NSString stringWithFormat:@"ELCAsset index:%d Selected:%@",[self index],self.selected ? @"YES" : @"NO"];
}

- (id)initWithAsset:(ALAsset*)asset
{
	self = [self init];
	if (self) {
		self.asset = asset;
        _selected = NO;
    }
	return self;	
}
- (instancetype)init{
    return [super init];
}
- (void)toggleSelection
{
    self.selected = !self.selected;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        if ([_parent respondsToSelector:@selector(shouldSelectAsset:)]) {
            if (![_parent shouldSelectAsset:self]) {
                return;
            }
        }
    } else {
        if ([_parent respondsToSelector:@selector(shouldDeselectAsset:)]) {
            if (![_parent shouldDeselectAsset:self]) {
                return;
            }
        }
    }
    _selected = selected;
    if (selected) {
        if (_parent != nil && [_parent respondsToSelector:@selector(assetSelected:)]) {
            [_parent assetSelected:self];
        }
    } else {
        if (_parent != nil && [_parent respondsToSelector:@selector(assetDeselected:)]) {
            [_parent assetDeselected:self];
        }
    }
}

- (NSComparisonResult)compareWithIndex:(ELCAsset *)_ass
{
    if ([self index] > [_ass index]) {
        return NSOrderedDescending;
    }
    else if ([self index] < [_ass index])
    {
        return NSOrderedAscending;
    }
    return NSOrderedSame;
}

@end

