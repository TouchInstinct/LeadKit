Pod::Spec.new do |s|
  s.name             = 'TICoordinatorKit'
  s.version          = '1.1.5'
  s.summary          = 'A framework for performing navigation in iOS application.'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Touch Instinct'
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/Sources/**/*'

  s.dependency 'TISwiftUtils', s.version.to_s
  s.framework = 'UIKit'
end
