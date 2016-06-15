import UIKit

class DownloadTableView : UITableViewController {
    
    override func viewDidLoad() {
        
        // Sent from LeftMenu
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openHomeScreen", name: "openHome", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPartnersScreen", name: "openPartners", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPackScreen", name: "openPack", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openDownloadsScreen", name: "openDownloads", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openFeedbackScreen", name: "openFeedback", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openEditProfileScreen", name: "openEditProfile", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPartnerView", name: "showPartnerView", object: nil)
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func openHomeScreen(){
        performSegueWithIdentifier("show_home", sender: self)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openPartnersScreen(){
        performSegueWithIdentifier("show_partners", sender: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openPackScreen(){
        performSegueWithIdentifier("show_pack", sender: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openDownloadsScreen(){
        performSegueWithIdentifier("show_downloads", sender:nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openFeedbackScreen(){
        performSegueWithIdentifier("show_feedback", sender:nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openEditProfileScreen(){
        performSegueWithIdentifier("show_editprofile", sender:nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openPartnerView(){
        performSegueWithIdentifier("show_partnerview", sender: self)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    
    override func canPerformSegue(id: String) -> Bool {
        let segues = self.valueForKey("storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.valueForKey("identifier") as? String == id })
        return (filtered?.count > 0) ?? false
    }
    override func performSegue(id: String, sender: AnyObject?) -> Bool {
        if canPerformSegue(id) {
            self.performSegueWithIdentifier(id, sender: sender)
            return true
        }
        return false
    }
}
