# TIUIElements

Bunch of useful protocols and views:

- `RefreshControl` - a basic UIRefreshControl with fixed refresh action.

# HeaderTransitionDelegate
Use for transition table header to navigationBar view while scrolling

## Your class must implement HeaderViewHandlerProtocol protocol

## HeaderViewHandlerProtocol
```swift 
public protocol HeaderViewHandlerProtocol {
    var largeHeaderView: UIView? { get }
    var headerView: UIView? { get }
    var navigationBar: UINavigationBar? { get }
    var window: UIWindow? { get }
    var tableView: UITableView { get }
}
```

## Usage if your ViewController don't needs extend UITableViewDelegate
```swift 
let headerTransitionDelegate = HeaderTransitionDelegate(headerViewHandler: self)
tableView.delegate = headerTransitionDelegate
```

## Usage if your ViewController needs extend UITableViewDelegate
```swift 
let headerTransitionDelegate = HeaderTransitionDelegate(headerViewHandler: self)
tableView.delegate = self
.
.
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerTransitionDelegate?.scrollViewDidScrollHandler(scrollView)
    
    /// Your local work
}
```

## Customization 
You can use different kinds of animations to change views
```swift
HeaderTransitionDelegate(headerViewHandler: HeaderViewHandlerProtocol,
                         headerAnimationType: HeaderAnimationType = .paralaxWithTransition)
```
1. *headerAnimationType* - определяет тип анимации перехода отображений:
    - **onlyParalax** - applies only parallax effect to the header of table
    - **paralaxWithTransition** - applies parallax effect to the header of table with transition effect down up of the navigationBar titleView
    - **transition** - applies only transition effect down up of the navigationBar titleView
    - **scale** - applies only scale effect down up of the navigationBar titleView
    - **paralaxWithScale** - applies parallax effect to the header of table with scale effect down up of the navigationBar titleView
    - **none** **(default value)** - dont applies any effects 
## Examples
#### **none**
<table border="0" cellspacing="30" cellpadding="30">
    <tbody>
        <tr>
            <td>
                <p align="left">
                   <img src="Assets/first_header_transition_example.gif" width=300 height=600>  
                </p>
            </td>
            <td>
                <p align="right">
                   <img src="Assets/licard_header_transition_example.gif" width=300 height=600>  
                </p>
            </td>
        </tr>
     </tbody>
</table>

#### **onlyParalax**
<p align="right">
   <img src="Assets/onlyParalax.gif" width=300 height=600>  
</p>

#### **paralaxWithTransition**
<p align="right">
   <img src="Assets/paralaxWithTransition.gif" width=300 height=600>  
</p>

#### **transition**
<p align="right">
   <img src="Assets/transition.gif" width=300 height=600>  
</p>

#### **scale**
<p align="right">
   <img src="Assets/scale.gif" width=300 height=600>  
</p>

#### **paralaxWithScale**
<p align="right">
   <img src="Assets/paralaxWithScale.gif" width=300 height=600>  
</p>
                
# Installation via SPM

You can install this framework as a target of LeadKit.
