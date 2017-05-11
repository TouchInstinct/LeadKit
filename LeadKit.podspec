Pod::Spec.new do |s|
  s.name            = "LeadKit"
  s.version         = "0.5.1"
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

    ss.source_files = "LeadKit/Sources/Extensions/UIColor/UIColor+Hex.swift"
  end

  s.subspec 'Drawing' do |ss|
    # ss.ios.deployment_target = '8.0' # can't get it work: DrawingOperation.swift:29:17: note: did you mean 'DrawingOperation'?
    # ss.tvos.deployment_target = '9.0' # can't get it work: DrawingOperation.swift:29:17: note: did you mean 'DrawingOperation'?
    ss.watchos.deployment_target = '2.0'

    ss.source_files = [
      "LeadKit/Sources/Enums/ResizeContentMode.swift",
      "LeadKit/Sources/Extensions/{CGContext,CGImage,CGSize,UIImage}/*",
      "LeadKit/Sources/Protocols/{DrawingOperation,SupportProtocol}.swift",
      "LeadKit/Sources/Structures/Drawing/*",
    ]
    ss.watchos.exclude_files = [
      "LeadKit/Sources/Structures/Drawing/CALayerDrawingOperation.swift",
      "LeadKit/Sources/Extensions/UIImage/*",
    ]
  end

  s.subspec 'Core' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.tvos.deployment_target = '9.0'
    ss.watchos.deployment_target = '2.0'

    ss.source_files = "LeadKit/Sources/**/*.swift"
    ss.watchos.exclude_files = [
      "LeadKit/Sources/Classes/Pagination/PaginationTableViewWrapper.swift",
      "LeadKit/Sources/Classes/Views/XibView.swift",
      "LeadKit/Sources/Classes/Views/SpinnerView.swift",
      "LeadKit/Sources/Extensions/CABasicAnimation/*",
      "LeadKit/Sources/Extensions/CGFloat/CGFloat+Pixels.swift",
      "LeadKit/Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
      "LeadKit/Sources/Extensions/NetworkService/NetworkService+RxLoadImage.swift",
      "LeadKit/Sources/Extensions/PaginationTableViewWrapperDelegate/PaginationTableViewWrapperDelegate+DefaultImplementation.swift",
      "LeadKit/Sources/Extensions/StoryboardProtocol/*",
      "LeadKit/Sources/Extensions/Support/UIScrollView+Support.swift",
      "LeadKit/Sources/Extensions/TableDirector/TableDirector+Extensions.swift",
      "LeadKit/Sources/Extensions/UIActivityIndicatorView/*",
      "LeadKit/Sources/Extensions/UIAlertcontroller/*",
      "LeadKit/Sources/Extensions/UICollectionView/*",
      "LeadKit/Sources/Extensions/UIDevice/*",
      "LeadKit/Sources/Extensions/UIImage/*",
      "LeadKit/Sources/Extensions/UIStoryboard/*",
      "LeadKit/Sources/Extensions/UIView/*",
      "LeadKit/Sources/Extensions/UIViewController/*",
      "LeadKit/Sources/Extensions/UIWindow/*",
      "LeadKit/Sources/Protocols/LoadingIndicator.swift",
      "LeadKit/Sources/Protocols/StoryboardProtocol.swift",
      "LeadKit/Sources/Structures/Views/AnyLoadingIndicator.swift",
      "LeadKit/Sources/Structures/DrawingOperations/CALayerDrawingOperation.swift",
      "LeadKit/Sources/Structures/DrawingOperations/RoundDrawingOperation.swift",
      "LeadKit/Sources/Structures/DrawingOperations/BorderDrawingOperation.swift",
    ]
    ss.tvos.exclude_files = [
      "LeadKit/Sources/Classes/Pagination/PaginationTableViewWrapper.swift",
      "LeadKit/Sources/Structures/Drawing/CALayerDrawingOperation.swift",
      "LeadKit/Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
      "LeadKit/Sources/Extensions/PaginationTableViewWrapperDelegate/PaginationTableViewWrapperDelegate+DefaultImplementation.swift",
      "LeadKit/Sources/Extensions/Support/UIScrollView+Support.swift",
      "LeadKit/Sources/Extensions/TableDirector/TableDirector+Extensions.swift",
    ]

    ss.dependency "CocoaLumberjack/Swift", '~> 3.1.0'
    ss.dependency "RxSwift", '3.4.0'
    ss.dependency "RxCocoa", '3.4.0'
    ss.dependency "RxAlamofire", '3.0.2'
    ss.dependency "ObjectMapper", '~> 2.2'

    ss.ios.dependency "TableKit", '~> 2.3.1'
    ss.ios.dependency "UIScrollView-InfiniteScroll", '~> 1.0.0'
  end

  s.subspec 'Core-iOS-Extension' do |ss|
    ss.platform = :ios, '9.0'

    ss.source_files = "LeadKit/Sources/**/*.swift"

    ss.exclude_files = [
      "LeadKit/Sources/Classes/Pagination/PaginationTableViewWrapper.swift",
      "LeadKit/Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
      "LeadKit/Sources/Extensions/PaginationTableViewWrapperDelegate/PaginationTableViewWrapperDelegate+DefaultImplementation.swift",
      "LeadKit/Sources/Extensions/TableDirector/TableDirector+Extensions.swift",
    ]

    ss.dependency "CocoaLumberjack/Swift", '~> 3.1.0'
    ss.dependency "RxSwift", '3.4.0'
    ss.dependency "RxCocoa", '3.4.0'
    ss.dependency "RxAlamofire", '3.0.2'
    ss.dependency "ObjectMapper", '~> 2.2'
  end

  s.default_subspec = 'Core'

end
