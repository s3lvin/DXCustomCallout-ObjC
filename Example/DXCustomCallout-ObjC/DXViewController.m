//
//  DXViewController.m
//  DXCustomCallout-ObjC
//
//  Created by s3lvin on 04/13/2015.
//  Copyright (c) 2014 s3lvin. All rights reserved.
//

#import "DXViewController.h"

@interface DXAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@interface DXViewController () <MKMapViewDelegate>

@property(weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DXViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DXAnnotation *annotation1 = [DXAnnotation new];
    annotation1.coordinate = CLLocationCoordinate2DMake(12.9667, 77.5667);
    [self.mapView addAnnotation:annotation1];

    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation1.coordinate, 10000, 10000)];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {

    if ([annotation isKindOfClass:[DXAnnotation class]]) {

        UIView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin"]];

        UIView *calloutView = [[[NSBundle mainBundle] loadNibNamed:@"myView" owner:self options:nil] firstObject];

        DXAnnotationView *annotationView = (DXAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
        if (!annotationView) {
            annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:NSStringFromClass([DXAnnotationView class])
                                                                  pinView:pinView
                                                              calloutView:calloutView
                                                                 settings:[DXAnnotationSettings defaultSettings]];
        }
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[DXAnnotationView class]]) {
        [((DXAnnotationView *)view)hideCalloutView];
        view.layer.zPosition = -1;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[DXAnnotationView class]]) {
        [((DXAnnotationView *)view)showCalloutView];
        view.layer.zPosition = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation DXAnnotation

@end