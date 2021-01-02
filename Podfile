source 'https://cdn.cocoapods.org/'

platform :ios, '10.0'

def lead_kit_pods

  # Rx
  pod 'RxAlamofire', '~> 6.0'
  pod 'RxSwift', '~> 6.0'
  pod 'RxCocoa', '~> 6.0'

  # UI
  pod 'TableKit', :git => 'https://github.com/TouchInstinct/TableKit'
  pod 'UIScrollView-InfiniteScroll'
  pod 'SnapKit', '~> 5.0'

  # Utils
  pod 'SwiftDate'
  pod 'Alamofire'

end

target 'LeadKit iOS' do
  use_frameworks!

  lead_kit_pods

end

target 'LeadKit tvOS' do
  use_frameworks!

  lead_kit_pods

end

target 'LeadKit watchOS' do
  use_frameworks!

  lead_kit_pods

end
