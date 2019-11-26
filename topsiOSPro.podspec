#
# Be sure to run `pod lib lint topsiOSPro.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'topsiOSPro'
  s.version          = '0.1.8.1'
  s.summary          = 'A short description of topsiOSPro.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "青岛鼎信通讯iOS开发平台下通用组件库 Copyright © 2019 topscomm.com. All rights reserved."

  s.homepage         = 'https://github.com/lxj-helloworld/topsiOSPro'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaojin20135@live.com' => 'lixiaojin@topscomm.com' }
  s.source           = { :git => 'https://github.com/lxj-helloworld/topsiOSPro.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

#  s.source_files = 'topsiOSPro/views/**/*'
#  s.source_files = 'topsiOSPro/viewController/**/*'
#  s.source_files = 'topsiOSPro/utils/**/*'
  s.source_files = 'topsiOSPro/**/*'
  s.resource_bundles = {
     'topsiOSPro' => ['topsiOSPro/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 4.7' #网络请求
  s.dependency 'SwiftyJSON', '~> 4.0' #Json数据处理
  s.dependency 'QorumLogs'
  s.dependency 'SnapKit', '~> 4.0.0' #自动布局'
  s.dependency 'Hero'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'AlamofireImage'
#  s.dependency 'SDWebImage'
  s.dependency 'DKCamera'
  s.dependency 'DKPhotoGallery' #照片选取(包含SDWebImage)
  s.dependency 'DKImagePickerController', '<= 4.1.4' #照片选取
  s.dependency 'DeviceKit'               #设备信息
  s.dependency 'ImageSlideshow/Alamofire'
  s.dependency 'MJRefresh' #上拉刷新 下拉加载
  s.dependency 'SwiftDate', '~> 5.1.0'  #时间工具
end

