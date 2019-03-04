Pod::Spec.new do |s|
  s.name             = 'DevOptions'
  s.version          = '0.1.0'
  s.summary          = 'Allows you to activate developper options.'
  s.swift_version    = '4.2'

  s.description      = <<-DESC
Allows you to activate developper options such as: Changing the application language at runtime or letting you see your non localized key; Changing the server base url, allowing you to switch from the development environment to the production environment in a simple click; Showing a tag for the UIViewController you are currently looking at.
                       DESC

  s.homepage         = 'https://github.com/NomadeSolutions/DevOptions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nomade Solutions Mobiles' => 'info@nomadesolutions.com' }
  s.source           = { :git => 'https://github.com/NomadeSolutions/DevOptions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DevOptions/Classes/**/*.{h,m,swift}'
  s.pod_target_xcconfig = {'SWIFT_INCLUDE_PATHS' => '$(PODS_TARGET_SRCROOT)/DevOptions/Classes/Module'}
  
  s.resource_bundles = {
      'DevOptions' => ['DevOptions/Assets/**/*.{xcassets,strings}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'SafariServices'
  s.dependency 'TRZSlideLicenseViewController'
  s.dependency 'Toast-Swift'
  s.dependency 'SnapKit'
end
