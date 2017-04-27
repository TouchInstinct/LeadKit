Pod::Spec.new do |s|
  s.name            = "LeadKit"
  s.version         = "0.5.0"
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

    ss.source_files = "LeadKit/LeadKit/Sources/Extensions/UIColor/UIColor+Hex.swift"
  end

  s.subspec 'Drawing' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.tvos.deployment_target = '9.0'
    ss.watchos.deployment_target = '2.0'

    ss.source_files = [
      "LeadKit/LeadKit/Sources/Enums/ResizeContentMode.swift",
      "LeadKit/LeadKit/Sources/Extensions/{CGContext,CGImage,CGSize,UIImage}/*",
      "LeadKit/LeadKit/Sources/Protocols/{DrawingOperation,SupportProtocol}.swift",
      "LeadKit/LeadKit/Sources/Structures/Drawing/*",
    ]
    ss.watchos.exclude_files = "LeadKit/LeadKit/Sources/Structures/Drawing/CALayerDrawingOperation.swift"
  end

  s.subspec 'Core' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.tvos.deployment_target = '9.0'
    ss.watchos.deployment_target = '2.0'

    ss.source_files = "LeadKit/LeadKit/Sources/**/*.swift"
    ss.watchos.exclude_files = [
      "LeadKit/LeadKit/Sources/Classes/Pagination/PaginationTableViewWrapperDelegate.swift",
      "LeadKit/LeadKit/Sources/Classes/View/XibView.swift",
      "LeadKit/LeadKit/Sources/Extensions/CGFloat/CGFloat+Pixels.swift",
      "LeadKit/LeadKit/Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
      "LeadKit/LeadKit/Sources/Extensions/PaginationTableViewWrapperDelegate/PaginationTableViewWrapperDelegate+DefaultImplementation.swift",
      "LeadKit/LeadKit/Sources/Extensions/StoryboardProtocol/*",
      "LeadKit/LeadKit/Sources/Extensions/Support/UIScrollView+Support.swift",
      "LeadKit/LeadKit/Sources/Extensions/TableDirector/TableDirector+Extensions.swift",
      "LeadKit/LeadKit/Sources/Extensions/UIActivityIndicator/UIActivityIndicator+LoadingIndicator.swift",
      "LeadKit/LeadKit/Sources/Extensions/UICollectionView/*",
      "LeadKit/LeadKit/Sources/Extensions/UIDevice/*",
      "LeadKit/LeadKit/Sources/Extensions/UIImage/*",
      "LeadKit/LeadKit/Sources/Extensions/UIStoryboard/*",
      "LeadKit/LeadKit/Sources/Extensions/UIView/*",
      "LeadKit/LeadKit/Sources/Extensions/UIViewController/*",
      "LeadKit/LeadKit/Sources/Extensions/UIWindow/*",
      "LeadKit/LeadKit/Sources/Protocols/LoadingIndicator.swift",
      "LeadKit/LeadKit/Sources/Protocols/StoryboardProtocol.swift",
      "LeadKit/LeadKit/Sources/Structures/Views/AnyLoadingIndicator.swift",
      "LeadKit/LeadKit/Sources/Structures/DrawingOperations/CALayerDrawingOperation.swift",
    ]
    ss.tvos.exclude_files = [
      "LeadKit/LeadKit/Sources/Structures/Drawing/CALayerDrawingOperation.swift",
      "LeadKit/LeadKit/Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
      "LeadKit/LeadKit/Sources/Extensions/PaginationTableViewWrapperDelegate/PaginationTableViewWrapperDelegate+DefaultImplementation.swift",
      "LeadKit/LeadKit/Sources/Extensions/Support/UIScrollView+Support.swift",
      "LeadKit/LeadKit/Sources/Extensions/TableDirector/TableDirector+Extensions.swift",
    ]

    ss.dependency "CocoaLumberjack/Swift", '~> 3.1.0'
    ss.dependency "RxSwift", '3.2.0'
    ss.dependency "RxCocoa", '3.2.0'
    ss.dependency "RxAlamofire", '3.0.0'
    ss.dependency "ObjectMapper", '~> 2.1'

    ss.ios.dependency "Toast-Swift", '~> 2.0.0'
    ss.ios.dependency "TableKit", '~> 2.3.1'
    ss.ios.dependency "UIScrollView-InfiniteScroll", '~> 1.0.0'
  end

  s.subspec 'Core-iOS-Extension' do |ss|
    ss.platform = :ios, '9.0'

    ss.source_files = "LeadKit/LeadKit/Sources/**/*.swift"

    ss.exclude_files = [
      "LeadKit/LeadKit/Sources/Classes/Pagination/PaginationTableViewWrapperDelegate.swift",
      "LeadKit/LeadKit/Sources/Extensions/NetworkService/NetworkService+ActivityIndicator.swift",
      "LeadKit/LeadKit/Sources/Extensions/PaginationTableViewWrapperDelegate/PaginationTableViewWrapperDelegate+DefaultImplementation.swift",
      "LeadKit/LeadKit/Sources/Extensions/TableDirector/TableDirector+Extensions.swift",
    ]

    ss.dependency "CocoaLumberjack/Swift", '~> 3.1.0'
    ss.dependency "RxSwift", '3.2.0'
    ss.dependency "RxCocoa", '3.2.0'
    ss.dependency "RxAlamofire", '3.0.0'
    ss.dependency "ObjectMapper", '~> 2.1'
  end

  s.default_subspec = 'Core'

end
