Pod::Spec.new do |s|
  s.name             = 'TIYandexMapUtils'
  s.version          = '1.26.1'
  s.summary          = 'Set of helpers for map objects clustering and interacting using Yandex Maps SDK.'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'petropavel13' => 'ivan.smolin@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/Sources/**/*'

  s.static_framework = true
  s.user_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

  s.dependency 'TIMapUtils', s.version.to_s
  s.dependency 'YandexMapsMobile', '4.0.0-lite'
end
