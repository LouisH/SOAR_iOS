import UIKit
import Alamofire
class DrawerContainer : UIViewController {
    //size of menu from storyboard
    let leftMenuWidth:CGFloat = 260
    //call scrollview from storyboard
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        print(scrollView.contentOffset.x)
        // Initial close in main thread
        dispatch_async(dispatch_get_main_queue()) {
            self.closeMenu(false)
        }
        
        //call functions from notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: "toggleMenu", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeMenuViaNotification", name: "closeMenuViaNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openlogoutScreen", name: "openLogout", object: nil)
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    //cleanup
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // closeMenu to match notifications
    func closeMenuViaNotification(){
        closeMenu(true)
    }
    
    func toggleMenu(){
        scrollView.contentOffset.x == 0  ? closeMenu(true) : openMenu()
        print(scrollView.contentOffset)
    }
    
    func closeMenu(animated:Bool){
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            scrollView.setContentOffset(CGPoint(x: 508, y: 0), animated: animated)
        }
    }
    
    /*override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape {
            self.closeMenu(true)
        } else {
            self.closeMenu(true)
        }
    }*/
    
    //closes side menu upon changing landscape orientation change
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            self.closeMenu(true)
        }
     }
 
    
    func openMenu(){
        print("opening side menu")
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.scrollView)
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.scrollView)
    }
    
    func openlogoutScreen(){
        Alamofire.request(.GET, "https://weblogon.csusb.edu/cas/logout")
        closeMenu(true)
        performSegueWithIdentifier("do_logout", sender: nil)
    }
}


extension DrawerContainer : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollView.pagingEnabled = true
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.pagingEnabled = false
    }
}
