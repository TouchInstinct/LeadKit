Pod::Spec.new do |s|
  s.name             = 'TISwiftUIElements'
  s.version          = '1.24.0'
  s.summary          = 'Bunch of useful protocols and views.'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'petropavel13' => 'ivan.smolin@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/Sources/**/*'

  s.dependency 'TIUIElements', s.version.to_s
  s.dependency 'TISwiftUtils', s.version.to_s
end
