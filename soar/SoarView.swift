//
//  NotificationListener.swift
//  soar
//
//  Created by Ryan Stegman on 3/3/16.
//  Copyright © 2016 Ryan Stegman. All rights reserved.
//

import UIKit

class SoarView : UIViewController {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        
        // Sent from LeftMenu
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openHomeScreen", name: "openHome", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPartnersScreen", name: "openPartners", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPackScreen", name: "openPack", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openDownloadsScreen", name: "openDownloads", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openFeedbackScreen", name: "openFeedback", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openEditProfileScreen", name: "openEditProfile", object: nil)
        
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
        view.endEditing(true)
    }
    
    func openHomeScreen(){
        performSegue("show_home", sender: self)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openPartnersScreen(){
        performSegue("show_partners", sender: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openPackScreen(){
        performSegue("show_pack", sender: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openDownloadsScreen(){
        performSegue("show_downloads", sender:nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openFeedbackScreen(){
        performSegue("show_feedback", sender:nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    func openEditProfileScreen(){
        performSegue("show_editprofile", sender:nil)
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
    }
    
    
    
}

extension UIViewController {
    func canPerformSegue(id: String) -> Bool {
        let segues = self.valueForKey("storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.valueForKey("identifier") as? String == id })
        return (filtered?.count > 0) ?? false
    }
    func performSegue(id: String, sender: AnyObject?) -> Bool {
        if canPerformSegue(id) {
            self.performSegueWithIdentifier(id, sender: sender)
            return true
        }
        return false
    }
}