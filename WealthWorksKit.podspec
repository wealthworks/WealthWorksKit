Pod::Spec.new do |s|

  s.name             = 'WealthWorksKit'
  s.version          = '1.0.0'
  s.summary          = 'Wealth Works Co., Ltd.'
  s.description      = '她理财 好规划 Timi时光记账 基金豆'
  s.homepage         = 'https://github.com/wealthworks/WealthWorksKit'
  s.author           = { '郭亚伦' => 'guoyalun@talicai.com' }

  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.ios.deployment_target = '8.0'

  s.source = { :git => 'https://github.com/wealthworks/WealthWorksKit.git' }

  s.source_files = 'WealthWorksKit/Classes/**/*.{h,m}'
  s.prefix_header_file = "WealthWorksKit/Classes/PrefixHeader.pch"

  s.frameworks = 'AdSupport'

  s.dependency 'FCUUID'
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'MJExtension'

  # s.public_header_files = 'Pod/Classes/**/*.h'

  # s.resource_bundles = {
  #   'WealthWorksKit' => ['WealthWorksKit/Assets/*.png']
  # }

end
