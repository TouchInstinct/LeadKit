Pod::Spec.new do |s|
  s.name            = "LeadKit"
  s.version         = "0.7.1"
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

  s.subspec 'Drawing' do |ss|
    # ss.ios.deployment_target = '8.0' # can't get it work: DrawingOperation.swift:29:17: note: did you mean 'DrawingOperation'?
    # ss.tvos.deployment_target = '9.0' # can't get it work: DrawingOperation.swift:29:17: note: did you mean 'DrawingOperation'?
    ss.watchos.deployment_target = '2.0'

    ss.source_files = [
      "Sources/Enums/ResizeMode.swift",
      "Sources/Extensions/{CGContext,CGImage,CGSize,UIImage}/*",
      "Sources/Protocols/{DrawingOperation,SupportProtocol}.swift",
      "Sources/Structures/Drawing/*",
    ]
    ss.watchos.exclude_files = [
      "Sources/Structures/Drawing/CALayerDrawingOperation.swift",
      "Sources/Extensions/UIImage/*",
    ]
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
      "Sources/Extensions/TableDirector/*",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Extensions/UIActivityIndicatorView/*",
      "Sources/Extensions/UIAlertcontroller/*",
      "Sources/Extensions/UIApplication/*",
      "Sources/Extensions/UICollectionView/*",
      "Sources/Extensions/UIDevice/*",
      "Sources/Extensions/UIImage/*",
      "Sources/Extensions/UITableView/*",
      "Sources/Extensions/UIView/*",
      "Sources/Extensions/UIViewController/*",
      "Sources/Extensions/UIWindow/*",
      "Sources/Protocols/LoadingIndicator.swift",
      "Sources/Protocols/DataLoading/PaginationDataLoading/PaginationWrappable.swift",
      "Sources/Protocols/DataLoading/GeneralDataLoading/GeneralDataLoadingController.swift",
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
      "Sources/Extensions/TableDirector/*",
      "Sources/Extensions/UIApplication/UIApplication+OpenUrlSupport.swift",
      "Sources/Extensions/UIApplication/UIApplication+Cellular.swift",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Protocols/DataLoading/PaginationDataLoading/PaginationWrappable.swift",
      "Sources/Structures/DataLoading/PaginationDataLoading/*"
    ]

    ss.dependency "CocoaLumberjack/Swift", '~> 3.4'
    ss.dependency "RxSwift", '~> 4.1'
    ss.dependency "RxCocoa", '~> 4.1'
    ss.dependency "RxAlamofire", '~> 4.1'
    ss.dependency "ObjectMapper", '~> 3.0'

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
      "Sources/Extensions/TableDirector/*",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift"
    ]

    ss.dependency "CocoaLumberjack/Swift", '~> 3.4'
    ss.dependency "RxSwift", '~> 4.1'
    ss.dependency "RxCocoa", '~> 4.1'
    ss.dependency "RxAlamofire", '~> 4.1'
    ss.dependency "ObjectMapper", '~> 3.0'
  end

  s.default_subspec = 'Core'

end
