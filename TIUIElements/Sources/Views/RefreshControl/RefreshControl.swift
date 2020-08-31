import UIKit

open class RefreshControl: UIRefreshControl {
    private var action: Selector?
    private var target: NSObjectProtocol?

    // Handle .valueChanged event of refresh control
    public override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        guard case .valueChanged = controlEvents else {
            return super.addTarget(target, action: action, for: controlEvents)
        }

        self.action = action
        self.target = target as? NSObjectProtocol
    }

    public override func removeTarget(_ target: Any?, action: Selector?, for controlEvents: UIControl.Event) {
        guard self.action == action, self.target?.isEqual(target) ?? false else {
            super.removeTarget(target, action: action, for: controlEvents)
            return
        }
        
        self.action = nil
        self.target = nil
    }
    
    public override func sendActions(for controlEvents: UIControl.Event) {
        guard case .valueChanged = controlEvents else {
            return super.sendActions(for: controlEvents)
        }

        // Perform target's action
        if action != nil, target != nil {
            performRefreshAction()
        }
    }
    
    open override func endRefreshing() {
        // Due to Apple's recommends
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) {
            super.endRefreshing()
        }
    }    
    
    private func performRefreshAction() {
        // It is implemented the combined behavior of `touchUpInside` and `touchUpOutside` using `CFRunLoopPerformBlock`,
        // which `UIRefreshControl` does not support
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) { [weak self] in
            guard let action = self?.action else {
                return
            }

            self?.target?.perform(action)
        }
    }
}
