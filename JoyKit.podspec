#
# Be sure to run `pod lib lint JoyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JoyKit'
  s.version          = '0.1.14'
  s.summary          = 'router协议扩展'

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
#s.source_files = 'JoyKit/**/*.{h,m}'
s.resources = 'JoyKit/Assets/*'
#s.resource_bundles = {'JoyKit' => ['JoyKit/**/*.{xib,png,jpg,jpeg,plist}']}
# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

# 头文件
s.subspec 'JoyHeader' do|ss|
    ss.source_files = 'JoyKit/JoyHeader/**/*.{h,m}'
    ss.dependency 'JoyKit/CellsLibruary'
    ss.dependency 'JoyKit/Category'
    ss.dependency 'JoyKit/Controllers'
    ss.dependency 'JoyKit/Utility'
    ss.dependency 'JoyKit/Views'
    ss.dependency 'JoyKit/Router'
    ss.dependency 'JoyKit/JoyCoreMotion'
    ss.dependency 'JoyKit/JoyLocation'
    ss.dependency 'JoyKit/JoyQRCode'
    ss.dependency 'JoyKit/JoyMediaRecordPlay'
    ss.dependency 'JoyKit/JoyWebView'
    ss.public_header_files = 'JoyKit/JoyHeader/**/*.h'
end

# 视图
s.subspec 'Views' do|ss|
    ss.source_files = 'JoyKit/Views/**/*.{h,m}'
    ss.dependency 'JoyKit/CellsLibruary'
    ss.dependency 'JoyKit/Category'
    ss.public_header_files = 'JoyKit/Views/**/*.h'
end

# 公共
s.subspec 'Common' do|ss|
    ss.source_files = 'JoyKit/Common/**/*.{h,m}'
    ss.dependency 'JoyKit/Category'
    ss.public_header_files = 'JoyKit/Common/**/*.h'
end

# 扩展
s.subspec 'Category' do|ss|
    ss.source_files = 'JoyKit/Category/**/*.{h,m}'
    ss.public_header_files = 'JoyKit/Category/**/*.h'
end

# 模型
s.subspec 'Models' do|ss|
    ss.source_files = 'JoyKit/Models/**/*.{h,m}'
    ss.public_header_files = 'JoyKit/Models/**/*.h'
end

# router
s.subspec 'Router' do|ss|
    ss.source_files = 'JoyKit/Router/**/*.{h,m}'
    ss.public_header_files = 'JoyKit/Router/**/*.h'
end

# 控制器
s.subspec 'Controllers' do|ss|
    ss.source_files = 'JoyKit/Controllers/**/*.{h,m}'
    ss.dependency 'JoyKit/Common'
    ss.dependency 'JoyKit/Category'
    ss.dependency 'JoyKit/JoyWebView'
    ss.public_header_files = 'JoyKit/Controllers/**/*.h'
end

# 陀螺仪
s.subspec 'JoyCoreMotion' do|ss|
    ss.source_files = 'JoyKit/JoyCoreMotion/**/*.{h,m}'
    ss.dependency 'JoyKit/Utility'
    ss.dependency 'JoyKit/Common'
    ss.frameworks = 'CoreMotion'
    ss.public_header_files = 'JoyKit/JoyCoreMotion/**/*.h'
end

# 定位
s.subspec 'JoyLocation' do|ss|
    ss.source_files = 'JoyKit/JoyLocation/**/*.{h,m}'
    ss.dependency 'JoyKit/Utility'
    ss.dependency 'JoyKit/Common'
    ss.frameworks = 'CoreLocation'
    ss.public_header_files = 'JoyKit/JoyLocation/**/*.h'
end

# 二维码扫描
s.subspec 'JoyQRCode' do|ss|
    ss.source_files = 'JoyKit/JoyQRCode/**/*.{h,m}'
    ss.dependency 'JoyKit/Utility'
    ss.dependency 'JoyKit/JoyMediaRecordPlay'
    ss.dependency 'JoyKit/JoyCoreMotion'
    ss.dependency 'JoyKit/Category'
    ss.dependency 'JoyKit/Common'
    ss.public_header_files = 'JoyKit/JoyQRCode/**/*.h'
    ss.resources = 'JoyKit/JoyQRCode/**/*.{png,jpg,jpeg}'
end

# 视频录制
s.subspec 'JoyMediaRecordPlay' do|ss|
    ss.source_files = 'JoyKit/JoyMediaRecordPlay/**/*.{h,m}'
    ss.dependency 'JoyKit/Utility'
    ss.dependency 'JoyKit/Common'
    ss.dependency 'JoyKit/Category'
    ss.dependency 'JoyKit/JoyCoreMotion'
    ss.frameworks = 'AssetsLibrary','AVFoundation'
    ss.public_header_files = 'JoyKit/JoyMediaRecordPlay/**/*.h'
    ss.resources = 'JoyKit/JoyMediaRecordPlay/**/*.{png,jpg,jpeg}'
end

# web
s.subspec 'JoyWebView' do|ss|
    ss.source_files = 'JoyKit/JoyWebView/**/*.{h,m}'
    ss.dependency 'JoyKit/Utility'
    ss.dependency 'JoyKit/Common'
    ss.dependency 'JoyKit/Category'
    ss.public_header_files = 'JoyKit/JoyWebView/**/*.h'
end

# 工具
s.subspec 'Utility' do|ss|
    ss.source_files = 'JoyKit/Utility/**/*.{h,m}'
    ss.public_header_files = 'JoyKit/Utility/**/*.h'
end

# cell库
s.subspec 'CellsLibruary' do|ss|
    ss.subspec 'TableImageCell' do|sss|
        sss.source_files = 'JoyKit/CellsLibruary/TableImageCell/**/*.{h,m}'
        sss.dependency 'JoyKit/CellsLibruary/CollectionImageCell'
        sss.dependency 'JoyKit/CellsLibruary/TableTextCell'
        sss.dependency 'JoyKit/CellsLibruary/TableSwitchCell'
        sss.dependency 'JoyKit/CellsLibruary/TableCollectionCell'
        sss.dependency 'JoyKit/CellsLibruary/TableLabelCell'
        sss.public_header_files = 'JoyKit/CellsLibruary/TableImageCell/**/*.h'
    end
    ss.subspec 'TableTextCell' do|sss|
        sss.source_files = 'JoyKit/CellsLibruary/TableTextCell/**/*.{h,m}'
        sss.dependency 'JoyKit/CellsLibruary/TableLabelCell'
        sss.public_header_files = 'JoyKit/CellsLibruary/TableTextCell/**/*.h'
    end
    ss.subspec 'TableSwitchCell' do|sss|
        sss.source_files = 'JoyKit/CellsLibruary/TableSwitchCell/**/*.{h,m}'
        sss.dependency 'JoyKit/CellsLibruary/TableLabelCell'
        sss.public_header_files = 'JoyKit/CellsLibruary/TableSwitchCell/**/*.h'
    end

    ss.subspec 'CollectionImageCell' do|sss|
        sss.source_files = 'JoyKit/CellsLibruary/CollectionImageCell/**/*.{h,m}'
        sss.dependency 'JoyKit/CellsLibruary/TableLabelCell'
        sss.public_header_files = 'JoyKit/CellsLibruary/CollectionImageCell/**/*.h'
    end
    ss.subspec 'TableCollectionCell' do|sss|
        sss.source_files = 'JoyKit/CellsLibruary/TableCollectionCell/**/*.{h,m}'
        sss.dependency 'JoyKit/CellsLibruary/TableLabelCell'
        sss.public_header_files = 'JoyKit/CellsLibruary/TableCollectionCell/**/*.h'
    end
    
    ss.subspec 'TableLabelCell' do|sss|
        sss.source_files = 'JoyKit/CellsLibruary/TableLabelCell/**/*.{h,m}'
        sss.public_header_files = 'JoyKit/CellsLibruary/TableLabelCell/**/*.h'
    end

    ss.dependency 'JoyKit/Models'
    ss.dependency 'JoyKit/Common'
    ss.dependency 'JoyKit/Category'
end


s.frameworks = 'UIKit', 'IMageIO', 'Photos'
s.dependency 'Masonry'
#s.pod_target_xcconfig = { 'USER_HEADER_SEARCH_PATHS' => '${PODS_ROOT}/**'}

end
