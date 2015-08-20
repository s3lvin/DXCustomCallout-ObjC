//
//  DXAnnotationView.h
//  CustomCallout
//
//  Created by Selvin on 05/04/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import <MapKit/MapKit.h>
@class DXAnnotationSettings;

@interface DXAnnotationView : MKAnnotationView

@property(nonatomic, strong) UIView *pinView;
@property(nonatomic, strong) UIView *calloutView;

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIView *)pinView
                       calloutView:(UIView *)calloutView
                          settings:(DXAnnotationSettings *)settings;

- (void)hideCalloutView;
- (void)showCalloutView;

@end
