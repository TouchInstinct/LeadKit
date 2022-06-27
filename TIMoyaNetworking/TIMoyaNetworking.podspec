Pod::Spec.new do |s|
  s.name             = 'TIMoyaNetworking'
  s.version          = '1.22.0'
  s.summary          = 'Moya + Swagger network service.'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'petropavel13' => 'ivan.smolin@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/**/Sources/**/*'

  s.dependency 'TINetworking', s.version.to_s
  s.dependency 'TIFoundationUtils', s.version.to_s
  s.dependency 'Moya', "~> 15.0"

end
