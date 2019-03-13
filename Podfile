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

  target 'LeadKit watchOS' do
    platform :watchos, '3.0'

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

# If you have slow HDD
ENV['COCOAPODS_DISABLE_STATS'] = "true"
