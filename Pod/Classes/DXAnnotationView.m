//
//  DXAnnotationView.m
//  CustomCallout
//
//  Created by Selvin on 05/04/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import "DXAnnotationView.h"
#import "DXAnnotationSettings.h"

@interface DXAnnotationView () {
    BOOL _hasCalloutView;
}

@property(nonatomic, strong) DXAnnotationSettings *settings;

@end

@implementation DXAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIView *)pinView
                       calloutView:(UIView *)calloutView
                          settings:(DXAnnotationSettings *)settings {

    NSAssert(pinView != nil, @"Pinview can not be nil");
    self = [super initWithAnnotation:annotation
                     reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = NO;
        [self validateSettings:settings];
        _hasCalloutView = (calloutView) ? YES : NO;
        self.canShowCallout = NO;

        self.pinView = pinView;
        self.pinView.userInteractionEnabled = YES;
        self.calloutView = calloutView;
        self.calloutView.hidden = YES;

        [self addSubview:self.pinView];
        [self addSubview:self.calloutView];
        self.frame = [self calculateFrame];
        if (_hasCalloutView) {
            if (self.settings.shouldAddCalloutBorder) {
                [self addCalloutBorder];
            }
            if (self.settings.shouldRoundifyCallout) {
                [self roundifyCallout];
            }
        }
        [self positionSubviews];
    }
    return self;
}

- (CGRect)calculateFrame {
    return self.pinView.bounds;
}

- (void)positionSubviews {
    self.pinView.center = self.center;
    if (_hasCalloutView) {
        CGRect frame = self.calloutView.frame;
        frame.origin.y = -frame.size.height - self.settings.calloutOffset;
        frame.origin.x = (self.frame.size.width - frame.size.width) / 2.0;
        self.calloutView.frame = frame;
    }
}

- (void)roundifyCallout {
    self.calloutView.layer.cornerRadius = self.settings.calloutCornerRadius;
}

- (void)addCalloutBorder {
    self.calloutView.layer.borderWidth = self.settings.calloutBorderWidth;
    self.calloutView.layer.borderColor = self.settings.calloutBorderColor.CGColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_hasCalloutView) {
        UITouch *touch = [touches anyObject];
        // toggle visibility
        if (touch.view == self.pinView) {
            if (self.calloutView.isHidden) {
                [self showCalloutView];
            } else {
                [self hideCalloutView];
            }
        } else if (touch.view == self.calloutView) {
            [self showCalloutView];
        } else {
            [self hideCalloutView];
        }
    }
}

- (void)hideCalloutView {
    if (_hasCalloutView) {
        if (!self.calloutView.isHidden) {
            switch (self.settings.animationType) {
            case DXCalloutAnimationNone: {
                self.calloutView.hidden = YES;
            } break;
            case DXCalloutAnimationZoomIn: {
                self.calloutView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                [UIView animateWithDuration:self.settings.animationDuration animations:^{
                    self.calloutView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                } completion:^(BOOL finished) {
                    self.calloutView.hidden = YES;
                }];
            } break;
            case DXCalloutAnimationFadeIn: {
                self.calloutView.alpha = 1.0;
                [UIView animateWithDuration:self.settings.animationDuration animations:^{
                    self.calloutView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.calloutView.hidden = YES;
                }];
            } break;
            default: {
                self.calloutView.hidden = YES;
            } break;
            }
        }
    }
}

- (void)showCalloutView {
    if (_hasCalloutView) {
        if (self.calloutView.isHidden) {
            switch (self.settings.animationType) {
            case DXCalloutAnimationNone: {
                self.calloutView.hidden = NO;
            } break;
            case DXCalloutAnimationZoomIn: {
                self.calloutView.transform = CGAffineTransformMakeScale(0.025, 0.25);
                self.calloutView.hidden = NO;
                [UIView animateWithDuration:self.settings.animationDuration animations:^{
                    self.calloutView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                } completion:nil];
            } break;
            case DXCalloutAnimationFadeIn: {
                self.calloutView.alpha = 0.0;
                self.calloutView.hidden = NO;
                [UIView animateWithDuration:self.settings.animationDuration animations:^{
                    self.calloutView.alpha = 1.0;
                } completion:nil];
            } break;
            default: {
                self.calloutView.hidden = NO;
            } break;
            }
        }
    }
}

#pragma mark - validate settings -

- (void)validateSettings:(DXAnnotationSettings *)settings {
    NSAssert(settings.calloutOffset >= 5.0, @"settings.calloutOffset should be atleast 5.0");
    if (settings.shouldRoundifyCallout) {
        NSAssert(settings.calloutCornerRadius >= 3.0, @"settings.calloutCornerRadius should be atleast 3.0");
    }

    if (settings.shouldAddCalloutBorder) {
        NSAssert(settings.calloutBorderColor != nil, @"settings.calloutBorderColor can not be nil");
        NSAssert(settings.calloutBorderWidth >= 1.0, @"settings.calloutBorderWidth should be atleast 1.0");
    }

    if (settings.animationType != DXCalloutAnimationNone) {
        NSAssert(settings.animationDuration > 0.0, @"settings.animationDuration should be greater than zero");
    }

    self.settings = settings;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
        return nil;
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isCallout = (CGRectContainsPoint(self.calloutView.frame, point));
    BOOL isPin = (CGRectContainsPoint(self.pinView.frame, point));
    return isCallout || isPin;
}

#pragma mark - PinView

- (void)setPinView:(UIView *)pinView {
    //Removing old pinView
    [_pinView removeFromSuperview];
    
    //Adding new pinView to the view's hierachy
    _pinView = pinView;
    [self addSubview:_pinView];
    
    //Position the new pinView
    self.frame = [self calculateFrame];
    self.pinView.center = self.center;
}

- (void)setCalloutView:(UIView *)calloutView {
    //Removing old calloutView
    [_calloutView removeFromSuperview];
    
    //Adding new calloutView to the view's hierachy
    _calloutView = calloutView;
    [self addSubview:_calloutView];
    
    self.calloutView.hidden = YES;
    
    //Adding Border
    if (_hasCalloutView) {
        if (self.settings.shouldAddCalloutBorder) {
            [self addCalloutBorder];
        }
        if (self.settings.shouldRoundifyCallout) {
            [self roundifyCallout];
        }
    }
    [self positionSubviews];
    
}

@end
