#
# Be sure to run `pod lib lint topsiOSPro.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'topsiOSPro'
  s.version          = '0.1.5.5'
  s.summary          = 'A short description of topsiOSPro.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxj-helloworld/topsiOSPro'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaojin20135@live.com' => 'lixiaojin@topscomm.com' }
  s.source           = { :git => 'https://github.com/lxj-helloworld/topsiOSPro.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'topsiOSPro/**/*'
  #s.source_files = 'topsiOSPro/utils/*'
  
  # s.resource_bundles = {
  #   'topsiOSPro' => ['topsiOSPro/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire' #网络请求
  s.dependency 'SwiftyJSON' #Json数据处理
  s.dependency 'QorumLogs'
  s.dependency 'SnapKit' #自动布局'
  s.dependency 'Hero'
  s.dependency 'IQKeyboardManagerSwift'
  

end
