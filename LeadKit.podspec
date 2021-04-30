Pod::Spec.new do |s|
  s.name            = "LeadKit"
  s.version         = "1.2.0"
  s.summary         = "iOS framework with a bunch of tools for rapid development"
  s.homepage        = "https://github.com/TouchInstinct/LeadKit"
  s.license         = "Apache License, Version 2.0"
  s.author          = "Touch Instinct"
  s.source          = { :git => "https://github.com/TouchInstinct/LeadKit.git", :tag => s.version }
  s.platform        = :ios, '10.0'
  s.swift_versions = ['5.1']

  s.subspec 'UIColorHex' do |ss|
    ss.ios.deployment_target = '10.0'
    ss.tvos.deployment_target = '10.0'
    ss.watchos.deployment_target = '3.0'

    ss.source_files = "Sources/Extensions/UIColor/UIColor+Hex.swift"
  end

  s.subspec 'Core' do |ss|
    ss.ios.deployment_target = '10.0'
    ss.tvos.deployment_target = '10.0'
    ss.watchos.deployment_target = '3.0'

    ss.source_files = "Sources/**/*.swift"
    ss.watchos.exclude_files = [
      "Sources/Classes/Controllers/**/*",
      "Sources/Classes/Views/SeparatorRowBox/*",
      "Sources/Classes/Views/BaseRxTableViewCell/*",
      "Sources/Classes/Views/ContainerTableCell/*",
      "Sources/Classes/Views/SeparatorCell/*",
      "Sources/Classes/Views/EmptyCell/*",
      "Sources/Classes/Views/LabelTableViewCell/*",
      "Sources/Classes/DataLoading/PaginationDataLoading/PaginationWrapper.swift",
      "Sources/Classes/Views/XibView/*",
      "Sources/Classes/Views/SpinnerView/*",
      "Sources/Classes/Views/DefaultPlaceholders/*",
      "Sources/Classes/Views/CollectionViewWrapperView/*",
      "Sources/Classes/Views/TableViewWrapperView/*",
      "Sources/Classes/Views/BasePlaceholderView/*",
      "Sources/Classes/Views/CustomizableButton/*",
      "Sources/Classes/Search/*",
      "Sources/Enums/Search/*",
      "Sources/Extensions/CABasicAnimation/*",
      "Sources/Extensions/CGFloat/CGFloat+Pixels.swift",
      "Sources/Extensions/NetworkService/NetworkService+RxLoadImage.swift",
      "Sources/Extensions/DataLoading/GeneralDataLoading/GeneralDataLoadingController+DefaultImplementation.swift",
      "Sources/Extensions/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/Support/UINavigationItem+Support.swift",
      "Sources/Extensions/TableKit/**/*.swift",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Extensions/Array/Array+RowExtensions.swift",
      "Sources/Extensions/Drawing/UIImage/*",
      "Sources/Extensions/UIKit/**/*.swift",
      "Sources/Extensions/Views/ViewBackground/*",
      "Sources/Extensions/Views/SeparatorCell/*",
      "Sources/Extensions/Views/ConfigurableView/*",
      "Sources/Extensions/Views/PlaceholderConfigurable/*",
      "Sources/Protocols/UIKit/**/*.swift",
      "Sources/Protocols/LoadingIndicator.swift",
      "Sources/Protocols/DataLoading/PaginationDataLoading/PaginationWrappable.swift",
      "Sources/Protocols/DataLoading/GeneralDataLoading/GeneralDataLoadingController.swift",
      "Sources/Protocols/Views/SeparatorCell/*",
      "Sources/Protocols/Views/PlaceholderConfigurable/*",
      "Sources/Protocols/TableKit/**/*",
      "Sources/Protocols/Controllers/SearchResultsViewController.swift",
      "Sources/Structures/Views/AnyLoadingIndicator.swift",
      "Sources/Structures/DrawingOperations/CALayerDrawingOperation.swift",
      "Sources/Structures/DrawingOperations/RoundDrawingOperation.swift",
      "Sources/Structures/DrawingOperations/BorderDrawingOperation.swift",
      "Sources/Structures/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/UIInterfaceOrientation/*"
    ]
    ss.tvos.exclude_files = [
      "Sources/Classes/Controllers/BaseConfigurableController.swift",
      "Sources/Classes/Controllers/BaseCollectionContentController.swift",
      "Sources/Classes/Views/TableViewWrapperView/TableViewWrapperView.swift",
      "Sources/Classes/Views/CollectionViewWrapperView/CollectionViewWrapperView.swift",
      "Sources/Classes/Controllers/BaseScrollContentController.swift",
      "Sources/Classes/Controllers/BaseCustomViewController.swift",
      "Sources/Classes/Controllers/BaseOrientationNavigationController.swift",
      "Sources/Extensions/UIKit/UIDevice/UIDevice+ScreenOrientation.swift",
      "Sources/Classes/Controllers/BaseTableContentController.swift",
      "Sources/Classes/Views/BaseRxTableViewCell/*",
      "Sources/Classes/Views/ContainerTableCell/*",
      "Sources/Classes/Views/SeparatorRowBox/*",
      "Sources/Classes/Views/SeparatorCell/*",
      "Sources/Classes/Views/EmptyCell/*",
      "Sources/Classes/Views/LabelTableViewCell/*",
      "Sources/Classes/Views/CustomizableButton/*",
      "Sources/Classes/DataLoading/PaginationDataLoading/PaginationWrapper.swift",
      "Sources/Classes/Search/*",
      "Sources/Structures/Drawing/CALayerDrawingOperation.swift",
      "Sources/Enums/Search/*",
      "Sources/Extensions/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/Support/UINavigationItem+Support.swift",
      "Sources/Extensions/TableKit/**/*.swift",
      "Sources/Extensions/Array/Array+SeparatorRowBoxExtensions.swift",
      "Sources/Extensions/Array/Array+RowExtensions.swift",
      "Sources/Extensions/Views/SeparatorCell/*",
      "Sources/Protocols/DataLoading/PaginationDataLoading/PaginationWrappable.swift",
      "Sources/Protocols/Views/SeparatorCell/*",
      "Sources/Protocols/TableKit/**/*",
      "Sources/Protocols/Controllers/SearchResultsViewController.swift",
      "Sources/Structures/DataLoading/PaginationDataLoading/*",
      "Sources/Extensions/UIInterfaceOrientation/*",
      "Sources/Classes/Controllers/BaseOrientationController.swift"
    ]

    ss.dependency "RxSwift", '~> 6.0.0'
    ss.dependency "RxCocoa", '~> 6.0.0'
    ss.dependency "RxAlamofire", '~> 6.1.1'
    ss.dependency "SwiftDate", '~> 6'

    ss.ios.dependency "TableKit", '~> 2.11'
    ss.ios.dependency "SnapKit", '~> 5.0.1'
    ss.ios.dependency "UIScrollView-InfiniteScroll", '~> 1.1.0'
  end

  s.default_subspec = 'Core'

end
