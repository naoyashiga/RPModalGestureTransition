# RPModalGestureTransition
![](https://raw.githubusercontent.com/naoyashiga/RPModalGestureTransition/master/demo.gif)  
You can dismiss modal by using gesture.

# Usage
## 1.Define animation
You define animator class inherits UIViewControllerAnimatedTransitioning. I made this in [TransitionAnimator.swift](https://github.com/naoyashiga/RPModalGestureTransition/blob/master/RPModalGestureTransition/TransitionAnimator.swift).

## 2.Set UIViewControllerTransitioningDelegate to modal
```swift
import UIKit

extension ModalViewController: UIViewControllerTransitioningDelegate {

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {

        return BackgroundPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return TransitionAnimator(isPresenting: true)
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return TransitionAnimator(isPresenting: false)
    }

    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let percentInteractiveTransition = percentInteractiveTransition else {
            return nil
        }
        
        return percentInteractiveTransition.isInteractiveDissmalTransition ? percentInteractiveTransition : nil
    }
}
```

## 3.Set InteractiveTransition to modal
Class InteractiveTransition inherits UIPercentDrivenInteractiveTransition.
```swift
class ModalViewController: UIViewController {
    
    var percentInteractiveTransition: InteractiveTransition?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .Custom
        transitioningDelegate = self
        
        percentInteractiveTransition = InteractiveTransition(attachedViewController: self)
    }
```

## 4.Define interactive animation
You have to define how animation change with gesture. You check [InteractiveTransition.swift](https://github.com/naoyashiga/RPModalGestureTransition/blob/master/RPModalGestureTransition/InteractiveTransition.swift).
