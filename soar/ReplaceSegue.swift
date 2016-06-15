import UIKit

class ReplaceSegue : UIStoryboardSegue {
    override func perform() {
        let navigationController: UINavigationController = sourceViewController.navigationController!;
        
        var controllerStack = navigationController.viewControllers;
        let index = controllerStack.indexOf(sourceViewController);
        controllerStack[index!] = destinationViewController
        
        navigationController.setViewControllers(controllerStack, animated: true);
    }
}