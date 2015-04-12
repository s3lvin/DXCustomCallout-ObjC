#
# Be sure to run `pod lib lint DXCustomCallout-ObjC.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DXCustomCallout-ObjC"
  s.version          = "0.1.0"
  s.summary          = "A simpler approach to CustomCallouts on MKMapview"
  s.description      = <<-DESC
DXAnnotationView takes a PinView and a CalloutView as UIViews and beautifully displays it in MKMapView. It is;
                       * Easy to use
                       * Highly configurable
                       DESC
  s.homepage         = "https://github.com/s3lvin/DXCustomCallout-ObjC"
  s.screenshots     = "http://s26.postimg.org/68lrdhei1/i_OS_Simulator_Screen_Shot_13_Apr_2015_1_02_35_am.png"
  s.license          = 'MIT'
  s.author           = { "s3lvin" => "mariaselvin@gmail.com" }
  s.source           = { :git => "https://github.com/s3lvin/DXCustomCallout-ObjC.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

#s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'

end
