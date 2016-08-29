Pod::Spec.new do |s|

  s.name             = 'WealthWorksKit'
  s.version          = '2.1.5'
  s.summary          = 'Wealth Works Co., Ltd.'
  s.description      = '她理财 好规划 Timi时光记账 基金豆'
  s.homepage         = 'https://github.com/wealthworks/WealthWorksKit'
  s.author           = { '郭亚伦' => 'guoyalun@talicai.com' }

  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.license        = { :type => 'MIT', :file => 'LICENSE' }

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source = { :git => 'https://github.com/wealthworks/WealthWorksKit.git' }

  s.source_files        = 'WealthWorksKit/Classes/WealthWorksKit.h'
  s.public_header_files = 'WealthWorksKit/Classes/WealthWorksKit.h'
  s.prefix_header_file  = 'WealthWorksKit/Classes/PrefixHeader.pch'

  s.frameworks = 'UIKit'

  s.dependency 'MJExtension'

  # s.resource_bundles = {
  #   'WealthWorksKit' => ['WealthWorksKit/Assets/*.png']
  # }

  s.subspec 'Utils' do |ss|
    ss.source_files        = 'WealthWorksKit/Classes/Utils/*.{h,m}'
    ss.public_header_files = 'WealthWorksKit/Classes/Utils/*.h'
    ss.frameworks          = 'AdSupport'
    ss.dependency            'OpenUDID'
  end

  s.subspec 'Network' do |ss|
    ss.source_files        = 'WealthWorksKit/Classes/Network/*.{h,m}'
    ss.public_header_files = 'WealthWorksKit/Classes/Network/*.h'
    ss.dependency            'AFNetworking', '~> 3.0'
  end

  s.subspec 'Navigator' do |ss|
    ss.source_files        = 'WealthWorksKit/Classes/Navigator/*.{h,m}'
    ss.public_header_files = 'WealthWorksKit/Classes/Navigator/*.h'
  end

  s.subspec 'NSStringCategories' do |ss|
    ss.source_files        = 'WealthWorksKit/Classes/NSStringCategories/*.{h,m}'
    ss.public_header_files = 'WealthWorksKit/Classes/NSStringCategories/*.h'
  end

  s.subspec 'UIApplicationCategories' do |ss|
    ss.source_files        = 'WealthWorksKit/Classes/UIApplicationCategories/*.{h,m}'
    ss.public_header_files = 'WealthWorksKit/Classes/UIApplicationCategories/*.h'
  end

end
