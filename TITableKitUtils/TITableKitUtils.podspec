Pod::Spec.new do |s|
  s.name             = 'TITableKitUtils'
  s.version          = '1.22.0'
  s.summary          = 'Set of helpers for TableKit classes.'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'petropavel13' => 'ivan.smolin@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/Sources/**/*'

  s.dependency 'TIUIElements', s.version.to_s
  s.dependency 'TISwiftUtils', s.version.to_s
  s.dependency 'TableKit', '~> 2.11'
end
