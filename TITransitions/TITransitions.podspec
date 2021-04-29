Pod::Spec.new do |s|
  s.name             = 'TITransitions'
  s.version          = '1.1.2'
  s.summary          = 'Set of custom transitions to present controller. '
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Loupehope' => 'vladislav.suhomlinov@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.0']

  s.source_files = s.name + '/Sources/**/*'
end
