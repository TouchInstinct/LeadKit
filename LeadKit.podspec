Pod::Spec.new do |s|
  s.name            = "LeadKit"
  s.version         = "0.8.2"
  s.summary         = "iOS framework with a bunch of tools for rapid development"
  s.homepage        = "https://github.com/TouchInstinct/LeadKit"
  s.license         = "Apache License, Version 2.0"
  s.author          = "Touch Instinct"
  s.source          = { :git => "https://github.com/TouchInstinct/LeadKit.git", :tag => s.version }
  s.platform        = :ios, '9.0'

  s.subspec 'UIColorHex' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.tvos.deployment_target = '9.0'
    ss.watchos.deployment_target = '2.0'

    ss.source_files = "Sources/Extensions/UIColor/UIColor+Hex.swift"
  end

  s.subspec 'Core' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.tvos.deployment_target = '9.0'
    ss.watchos.deployment_target = '2.0'

    ss.source_files = "Sources/**/*.swift"
    ss.ios.exclude_files = [
      "Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
    ]
    ss.watchos.exclude_files = [
      "Sources/Classes/Views/SeparatorRowBox/*",
      "Sources/Classes/Views/SeparatorCell/*",
      "Sources/Classes/Views/EmptyCell/*",
      "Sources/Classes/DataLoading/PaginationDataLoading/PaginationWrapper.swift",
      "Sources/Classes/Views/XibView/*",
      "Sources/Classes/Views/SpinnerView/*",
      "Sources/Classes/Views/DefaultPlaceholders/*",
      "Sources/Extensions/CABasicAnimation/*",
      "Sources/Extensions/CGFloat/CGFloat+Pixels.swift",
      "Sources/Extensions/NetworkService/NetworkService+ActivityIndicator-UIApplication.swift",
      "Sources/Extensions/NetworkService/NetworkService+RxLoadImage.swift",
      "Sources/Extensions/DataLoading/GeneralDataLoading/GeneralDataLoadingController+DefaultImplementation.swift",
      "Sources/Extensions/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/Support/UIScrollView+Support.swift",
      "Sources/Extensions/TableKit/**/*.swift",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Extensions/Drawing/UIImage/*",
      "Sources/Extensions/UIKit/**/*.swift",
      "Sources/Extensions/Views/ViewBackground+Configuration.swift",
      "Sources/Extensions/Views/SeparatorCell/*",
      "Sources/Protocols/LoadingIndicator.swift",
      "Sources/Protocols/DataLoading/PaginationDataLoading/PaginationWrappable.swift",
      "Sources/Protocols/DataLoading/GeneralDataLoading/GeneralDataLoadingController.swift",
      "Sources/Protocols/Views/SeparatorCell/*",
      "Sources/Structures/Views/AnyLoadingIndicator.swift",
      "Sources/Structures/DrawingOperations/CALayerDrawingOperation.swift",
      "Sources/Structures/DrawingOperations/RoundDrawingOperation.swift",
      "Sources/Structures/DrawingOperations/BorderDrawingOperation.swift",
      "Sources/Structures/DataLoading/PaginationDataLoading/*"
    ]
    ss.tvos.exclude_files = [
      "Sources/Classes/Views/SeparatorRowBox/*",
      "Sources/Classes/Views/SeparatorCell/*",
      "Sources/Classes/Views/EmptyCell/*",
      "Sources/Classes/DataLoading/PaginationDataLoading/PaginationWrapper.swift",
      "Sources/Structures/Drawing/CALayerDrawingOperation.swift",
      "Sources/Extensions/NetworkService/NetworkService+ActivityIndicator-UIApplication.swift",
      "Sources/Extensions/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/Support/UIScrollView+Support.swift",
      "Sources/Extensions/TableKit/**/*.swift",
      "Sources/Extensions/UIKit/UIApplication/UIApplication+OpenUrlSupport.swift",
      "Sources/Extensions/UIKit/UIApplication/UIApplication+Cellular.swift",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Extensions/Views/SeparatorCell/*",
      "Sources/Protocols/DataLoading/PaginationDataLoading/PaginationWrappable.swift",
      "Sources/Protocols/Views/SeparatorCell/*",
      "Sources/Structures/DataLoading/PaginationDataLoading/*"
    ]

    ss.dependency "RxSwift", '~> 4.1'
    ss.dependency "RxCocoa", '~> 4.1'
    ss.dependency "RxAlamofire", '~> 4.1'
    ss.dependency "SwiftDate", '~> 4.5'

    ss.ios.dependency "TableKit", '~> 2.6'
    ss.ios.dependency "UIScrollView-InfiniteScroll", '~> 1.0.0'
  end

  s.subspec 'Core-iOS-Extension' do |ss|
    ss.platform = :ios, '9.0'

    ss.source_files = "Sources/**/*.swift"

    ss.exclude_files = [
      "Sources/Classes/Views/SeparatorRowBox/*",
      "Sources/Classes/Views/SeparatorCell/*",
      "Sources/Classes/Views/EmptyCell/*",
      "Sources/Classes/DataLoading/PaginationDataLoading/PaginationWrapper.swift",
      "Sources/Extensions/NetworkService/NetworkService+ActivityIndicator-UIApplication.swift",
      "Sources/Extensions/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/TableKit/**/*.swift",
      "Sources/Extensions/UIApplication/UIApplication+OpenUrlSupport.swift",
      "Sources/Extensions/UIApplication/UIApplication+Cellular.swift",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Extensions/Views/SeparatorCell/*",
      "Sources/Protocols/Views/SeparatorCell/*"
    ]

    ss.dependency "RxSwift", '~> 4.1'
    ss.dependency "RxCocoa", '~> 4.1'
    ss.dependency "RxAlamofire", '~> 4.1'
    ss.dependency "SwiftDate", '~> 4.5'
  end

  s.default_subspec = 'Core'

end
