abstract_target 'LeadKit' do
  pod "RxSwift", '~> 4.1'
  pod "RxCocoa", '~> 4.1'
  pod "RxAlamofire", '~> 4.1'
  pod "SwiftLint", '~> 0.25'
  pod "SwiftDate", '~> 4.5'

  inhibit_all_warnings!

  target 'LeadKit iOS' do
    platform :ios, '9.0'

    use_frameworks!

    pod "TableKit", '~> 2.6'
    pod "UIScrollView-InfiniteScroll", '~> 1.0.0'

    target 'LeadKit iOSTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

  target 'LeadKit iOS Extensions' do
    platform :ios, '9.0'

    use_frameworks!

    pod "TableKit", '~> 2.6'

    target 'LeadKit iOS ExtensionsTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

  target 'LeadKit watchOS' do
    platform :watchos, '2.0'

    use_frameworks!

  end

  target 'LeadKit tvOS' do
    platform :tvos, '9.0'

    use_frameworks!

    target 'LeadKit tvOSTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

end

post_install do |installer|
    # 1.5+
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end

    # 1.4+
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
        end
    end

end

# If you have slow HDD
ENV['COCOAPODS_DISABLE_STATS'] = "true"
