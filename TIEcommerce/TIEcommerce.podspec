Pod::Spec.new do |s|
  s.name             = 'TIEcommerce'
  s.version          = '1.27'
  s.summary          = 'Cart, products, promocodes, bonuses, receipt and other related actions'
  s.homepage         = 'https://github.com/TouchInstinct/LeadKit/tree/' + s.version.to_s + '/' + s.name
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'petropavel13' => 'ivan.smolin@touchin.ru' }
  s.source           = { :git => 'https://github.com/TouchInstinct/LeadKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_versions = ['5.3']

  s.source_files = s.name + '/Sources/**/*'

  s.dependency 'TIFoundationUtils', s.version.to_s
end
