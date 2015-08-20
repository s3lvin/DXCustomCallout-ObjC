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

    DXAnnotation *ann2 = [DXAnnotation new];
    ann2.coordinate = CLLocationCoordinate2DMake(44.518640, 11.362665);
    
    DXAnnotation *ann3 = [DXAnnotation new];
    ann3.coordinate = CLLocationCoordinate2DMake(44.521318, 11.374080);
    
    DXAnnotation *ann4 = [DXAnnotation new];
    ann4.coordinate = CLLocationCoordinate2DMake(44.500746, 11.345394);
    
    DXAnnotation *ann5 = [DXAnnotation new];
    ann5.coordinate = CLLocationCoordinate2DMake(44.490537, 11.358033);
    
    DXAnnotation *ann6 = [DXAnnotation new];
    ann6.coordinate = CLLocationCoordinate2DMake(44.504082, 11.354256);
    
    [self.mapView addAnnotation:ann2];
    [self.mapView addAnnotation:ann3];
    [self.mapView addAnnotation:ann4];
    [self.mapView addAnnotation:ann5];
    [self.mapView addAnnotation:ann6];
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(ann2.coordinate, 10000, 10000)];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {

    if ([annotation isKindOfClass:[DXAnnotation class]]) {

        UIImageView *pinView = nil;

        UIView *calloutView = nil;

        DXAnnotationView *annotationView = (DXAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
        if (!annotationView) {
            pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin"]];
            calloutView = [[[NSBundle mainBundle] loadNibNamed:@"myView" owner:self options:nil] firstObject];
            
            annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:NSStringFromClass([DXAnnotationView class])
                                                                  pinView:pinView
                                                              calloutView:calloutView
                                                                 settings:[DXAnnotationSettings defaultSettings]];
        }else {
            
            //Changing PinView's image to test the recycle
            pinView = (UIImageView *)annotationView.pinView;
            pinView.image = [UIImage imageNamed:@"car-blue-icon"];
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