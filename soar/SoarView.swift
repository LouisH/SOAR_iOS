//
//  NotificationListener.swift
//  soar
//
//  Created by Ryan Stegman on 3/3/16.
//  Copyright © 2016 Ryan Stegman. All rights reserved.
//

import UIKit

class SoarView : UIViewController {
    
    override func viewDidLoad() {
        
        // Sent from LeftMenu
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openHomeScreen", name: "openHome", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPartnersScreen", name: "openPartners", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPackScreen", name: "openPack", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openDownloadsScreen", name: "openDownloads", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openFeedbackScreen", name: "openFeedback", object: nil)
        
        
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
        view.endEditing(true)
    }
    
    func openHomeScreen(){
        performSegueWithIdentifier("show_home", sender: self)
    }
    func openPartnersScreen(){
        performSegueWithIdentifier("show_partners", sender: nil)
    }
    func openPackScreen(){
        performSegueWithIdentifier("show_pack", sender: nil)
    }
    func openDownloadsScreen(){
        performSegueWithIdentifier("show_downloads", sender:nil)
    }
    func openFeedbackScreen(){
        performSegueWithIdentifier("show_feedback", sender:nil)
    }
    
    
    
}