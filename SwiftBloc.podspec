#
# Be sure to run `pod lib lint SwiftBloc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'SwiftBloc'
  s.version               = '1.0.0'
  s.summary               = 'SwiftBloc. A state management library'
  s.swift_versions        = '5.3'
  s.description           = 'Separates presentation from business logic. Ideal for testability and reusability.'
  s.homepage              = 'https://github.com/VictorKachalov/SwiftBloc'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'VictorKachalov' => 'victorkachalov@gmail.com' }
  s.source                = { :git => 'https://github.com/VictorKachalov/SwiftBloc.git', :tag => s.version.to_s }
  s.social_media_url      = 'https://www.facebook.com/profile.php?id=1700091944'
  s.platform              = :ios, '13.0'
  s.ios.deployment_target = '13.0'
  s.source_files          = 'SwiftBloc/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftBloc' => ['SwiftBloc/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
