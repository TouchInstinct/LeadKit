import UIKit

open class RefreshControl: UIRefreshControl {
    private var action: Selector?
    private var target: NSObjectProtocol?

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

        if action != nil, target != nil {
            performRefreshAction()
        }
    }

    private func performRefreshAction() {
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) { [weak self] in
            guard let action = self?.action else {
                return
            }

            self?.target?.perform(action)
        }
    }
}
