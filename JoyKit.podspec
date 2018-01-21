#
# Be sure to run `pod lib lint JoyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JoyKit'
  s.version          = '0.1.03'
  s.summary          = 'test 0.1.03'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/joy-make/JoyKit'

# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'joy-make' => '315585646@qq.com' }
s.source           = { :git => 'https://github.com/joy-make/JoyKit.git', :tag => s.version.to_s }

# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '7.0'
s.source_files = 'JoyKit/**/*.{h,m}'
s.resources = 'JoyKit/Assets/*'
#s.resource_bundles = {'JoyKit' => ['JoyKit/**/*.{xib,png,jpg,jpeg,plist}']}
# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

s.dependency 'Masonry'
#s.pod_target_xcconfig = { 'USER_HEADER_SEARCH_PATHS' => '${PODS_ROOT}/**'}

end
