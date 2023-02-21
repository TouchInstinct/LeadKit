Pod::Spec.new do |s|
  s.name             = 'TIDeveloperUtils'
  s.version          = '1.35.0'
  s.summary          = 'Universal web view API'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'petropavel13' => 'ivan.smolin@touchin.ru',
                         'castlele' => 'nikita.semenov@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/Sources/**/*'

end
