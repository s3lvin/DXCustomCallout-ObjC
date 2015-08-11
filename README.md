# DXCustomCallout-ObjC

[![CI Status](http://img.shields.io/travis/s3lvin/DXCustomCallout-ObjC.svg?style=flat)](https://travis-ci.org/s3lvin/DXCustomCallout-ObjC)
[![Version](https://img.shields.io/cocoapods/v/DXCustomCallout-ObjC.svg?style=flat)](http://cocoapods.org/pods/DXCustomCallout-ObjC)
[![License](https://img.shields.io/cocoapods/l/DXCustomCallout-ObjC.svg?style=flat)](http://cocoapods.org/pods/DXCustomCallout-ObjC)
[![Platform](https://img.shields.io/cocoapods/p/DXCustomCallout-ObjC.svg?style=flat)](http://cocoapods.org/pods/DXCustomCallout-ObjC)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### Integrating `DXAnnotationView` in your project

You can return a `DXAnnotationView` from 

    - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation

 method.

First create your pinview and calloutview

    UIView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin"]];
    UIView *calloutView = [[[NSBundle mainBundle] loadNibNamed:@"myView" owner:self options:nil] firstObject];

Then you create your custom annotation view as shown below.

    DXAnnotationView *annotationView = (DXAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
        if (!annotationView) {
            annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:NSStringFromClass([DXAnnotationView class])
                                                                  pinView:pinView
                                                              calloutView:calloutView
                                                                 settings:[DXAnnotationSettings defaultSettings]];
        }
        return annotationView;

#### Configuring additional settings for your custom callout

`DXAnnotationView` has customizable look and feel. You can configure the settings by passing your own `DXAnnotationSettings` in to `DXAnnotationView` while initializing it.

    DXAnnotationSettings *newSettings = [[DXAnnotationSettings alloc] init];
    newSettings.calloutOffset = <#your calloutoffset#>;

    newSettings.shouldRoundifyCallout = <#YES to make the calloutview with corner radius#>;
    newSettings.calloutCornerRadius = <#your callout view's corner radius. applied only if shouldRoundifyCallout is YES#>;

    newSettings.shouldAddCalloutBorder = <#YES to add border for your custom callout#>;
    newSettings.calloutBorderColor = <#your callout view's border color#>;
    newSettings.calloutBorderWidth = <#your callout view's border width#>;

    newSettings.animationType = <#DXCalloutAnimation type#>;
    newSettings.animationDuration = <#DXCalloutAnimation duration#>;
    
#### Making sure the size of your custom view doesn't grow bigger

1. Disable Autolayout for your custom callout view for a moment
2. Remove the FexibleWidth and Flexible height AutoResizingMasks from your custom callout view
3. Re enable Autolayout if needed

![step1](https://cloud.githubusercontent.com/assets/6522274/9212655/824323b0-40a8-11e5-9004-a95cb0f8b6f8.jpg)
![step2](https://cloud.githubusercontent.com/assets/6522274/9212656/82434c64-40a8-11e5-9276-b63e8515bc80.jpg)


## Screenshot

![DXCustomCallout](http://s26.postimg.org/5utm5d961/Callout.gif)

## Requirements
  iOS 7 or above & ARC
  
## Installation

DXCustomCallout-ObjC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DXCustomCallout-ObjC"
```

## Author

s3lvin, mariaselvin@gmail.com

Pull requests are welcome!

## License

DXCustomCallout-ObjC is available under the MIT license. See the LICENSE file for more info.
