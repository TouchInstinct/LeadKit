abstract_target 'LeadKit' do
  pod "RxSwift", '~> 4.1'
  pod "RxCocoa", '~> 4.1'
  pod "RxAlamofire", '~> 4.1'
  pod "SwiftLint", '~> 0.25'
  pod "SwiftDate", '~> 4.5'

  inhibit_all_warnings!

  target 'LeadKit iOS' do
    platform :ios, '10.0'

    use_frameworks!

    pod "TableKit", '~> 2.6'
    pod "UIScrollView-InfiniteScroll", '~> 1.0.0'

    target 'LeadKit iOSTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

  target 'LeadKit iOS Extensions' do
    platform :ios, '10.0'

    use_frameworks!

    pod "TableKit", '~> 2.6'

    target 'LeadKit iOS ExtensionsTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

  target 'LeadKit watchOS' do
    platform :watchos, '3.0'

    use_frameworks!

  end

  target 'LeadKit tvOS' do
    platform :tvos, '10.0'

    use_frameworks!

    target 'LeadKit tvOSTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

end

# If you have slow HDD
ENV['COCOAPODS_DISABLE_STATS'] = "true"

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
