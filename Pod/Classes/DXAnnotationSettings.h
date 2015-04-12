//
//  DXAnnotationSettings.h
//  CustomCallout
//
//  Created by Selvin on 12/04/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DXCalloutAnimation) {
    DXCalloutAnimationNone,
    DXCalloutAnimationFadeIn,
    DXCalloutAnimationZoomIn
};

@interface DXAnnotationSettings : NSObject

@property(nonatomic, assign) CGFloat calloutOffset;

@property(nonatomic, assign) BOOL shouldRoundifyCallout;
@property(nonatomic, assign) CGFloat calloutCornerRadius;

@property(nonatomic, assign) BOOL shouldAddCalloutBorder;
@property(nonatomic, strong) UIColor *calloutBorderColor;
@property(nonatomic, assign) CGFloat calloutBorderWidth;

@property(nonatomic, assign) DXCalloutAnimation animationType;
@property(nonatomic, assign) NSTimeInterval animationDuration;

+ (instancetype)defaultSettings;

@end
