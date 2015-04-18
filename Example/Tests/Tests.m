//
//  DXCustomCallout-ObjCTests.m
//  DXCustomCallout-ObjCTests
//
//  Created by s3lvin on 04/13/2015.
//  Copyright (c) 2014 s3lvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <DXAnnotationView.h>
#import <DXAnnotationSettings.h>
#import <MapKit/MapKit.h>

@interface DXAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@interface DXAnnotationViewTests : XCTestCase

@property(nonatomic, strong) DXAnnotation *annotation;

@end

@implementation DXAnnotationViewTests

- (void)setUp {
    [super setUp];
    self.annotation = [DXAnnotation new];
    self.annotation.coordinate = CLLocationCoordinate2DMake(12.9667, 77.5667);
}

- (void)tearDown {
    self.annotation = nil;
    [super tearDown];
}

- (void)testAlloc {
    // This is an example of a functional test case.
    DXAnnotationView *annotationView = [[DXAnnotationView alloc] initWithAnnotation:self.annotation reuseIdentifier:NSStringFromClass([DXAnnotationView class]) pinView:[UIView new] calloutView:[UIView new] settings:[DXAnnotationSettings defaultSettings]];
    XCTAssert(annotationView != nil, @"Allocation Pass");
}

@end