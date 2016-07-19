Pod::Spec.new do |s|

	s.name         = "WealthWorksKit"
	s.version      = "1.0.1"
	s.summary      = "Wealth Works Co., Ltd."
	s.description  = "她理财 好规划 Timi时光记账 基金豆"
	s.homepage     = "https://github.com/wealthworks/WealthWorksKit"
	s.author       = { "郭亚伦" => "guoyalun@talicai.com" }

	# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
	# s.license      = "MIT"
	# s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

	s.platform     = :ios
	# s.platform     = :ios, "7.0"

	#  When using multiple platforms
	# s.ios.deployment_target = "5.0"
	# s.osx.deployment_target = "10.7"
	# s.watchos.deployment_target = "2.0"
	# s.tvos.deployment_target = "9.0"

	# s.source       = { :git => "git@github.com:JianLeiErRan/WealthWorksKit.git", :submodules => true }
	s.source       = { :git => "git@github.com:wealthworks/WealthWorksKit.git", :submodules => true }
	s.source_files  = "WealthWorksKit/WealthWorksKit.h"
	# s.exclude_files = "Classes/Exclude"
	s.public_header_files = "WealthWorksKit/WealthWorksKit.h"
	s.prefix_header_file = "WealthWorksKit/PrefixHeader.pch"

	# s.resource  = "icon.png"
	# s.resources = "Resources/*.png"

	# s.framework  = "SomeFramework"
	s.frameworks = "UIKit"

	# s.library   = "iconv"
	# s.libraries = "iconv", "xml2"

	s.requires_arc = true

	# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
	# s.dependency "FCUUID"

	s.subspec 'Utils' do |ss|
		ss.source_files = 'WealthWorksKit/Utils/*.{h,m}'
		ss.public_header_files = 'WealthWorksKit/Utils/*.h'
		ss.frameworks = "AdSupport"
		ss.dependency "FCUUID"
	end

	s.subspec 'Network' do |ss|
		ss.source_files = 'WealthWorksKit/Network/*.{h,m}'
		ss.public_header_files = 'WealthWorksKit/Network/*.h'
	end

end
