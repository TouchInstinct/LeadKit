abstract_target 'LeadKit' do
  pod "RxSwift"
  pod "RxCocoa"
  pod "RxAlamofire"
  pod "SwiftLint"
  pod "SwiftDate"

  inhibit_all_warnings!

  target 'LeadKit iOS' do
    platform :ios, '9.0'

    use_frameworks!

    pod "TableKit"
    pod "UIScrollView-InfiniteScroll"

    target 'LeadKit iOSTests' do
      inherit! :search_paths
      # Pods for testing
    end

  end

  target 'LeadKit iOS Extensions' do
    platform :ios, '9.0'

    use_frameworks!

    pod "TableKit"

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
end

# If you have slow HDD
ENV['COCOAPODS_DISABLE_STATS'] = "true"
