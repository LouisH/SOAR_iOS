import UIKit

class LeftToRightReplaceSegue : UIStoryboardSegue {
    
    override func perform() {
        
        let navigationController: UINavigationController = sourceViewController.navigationController!;
        var controllerStack = navigationController.viewControllers;
        let index = controllerStack.indexOf(sourceViewController);
        controllerStack[index!] = destinationViewController
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        navigationController.view.layer.addAnimation(transition, forKey: kCATransition)
        navigationController.setViewControllers(controllerStack, animated: true);
        
    }
    
}