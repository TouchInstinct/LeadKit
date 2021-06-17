# TICoordinatorKit

A framework for performing navigation in iOS application. 

## Supporting custom navigation controllers

In *ModalRoutable* protocol there is a group of methods called *presentChild*:

```swift
presentChild(_:navigationControllerFactory:) -> StackRoutable?
presentChild(_:navigationControllerFactory:animated:) -> StackRoutable?
```

These methods wrap given module in navigation controller and present the wrapper. The `navigationControllerFactory` argument is a closure of type `(UIViewController) -> UINavigationController`. For example:

```swift
router.presentChild(module, 
                    navigationControllerFactory: { 
                      UINavigationController(rootViewController: $0) 
                    }, 
                    animated: true)
```

To simplify this method call (or in case your application has custom implementation of UINavigationController), you may consider creating a standalone  *NavigationControllerFactory*:

```swift
// ModalRoutable+NavigationControllerFactory.swift
import TICoordinatorKit

extension ModalRoutable {

    // MARK: - Navigation Controller Factory

    private var factory: ModalRoutable.NavigationControllerFactory {

        return { 
            CustomNavigationController(rootViewController: $0)
        }
    }

    // MARK: - Defaults

    func presentChild(_ module: Presentable?) -> StackRoutable? {
        return presentChild(module, navigationControllerFactory: factory)
    }

    func presentChild(_ module: Presentable?, animated: Bool) -> StackRoutable? {
        return presentChild(module, navigationControllerFactory: factory, animated: animated)
    }
}

```

## License

See the LICENSE file for more info.
