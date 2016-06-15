//
//  PackViewController.swift
//  soar
//
//  Created by Ryan Stegman on 3/16/16.
//  Copyright © 2016 Ryan Stegman. All rights reserved.
//

import UIKit

class PartnerViewController : SoarView {
    @IBOutlet var partnerImage : UIImageView!
    @IBOutlet var partnerName : UILabel!
    @IBOutlet var partnerDescription : UILabel!
    var partnerLink : String!
    static var soarPartner : Partner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(PartnerViewController.soarPartner.image !== nil) {
            partnerImage.image = PartnerViewController.soarPartner.image
        }
        partnerName.text = PartnerViewController.soarPartner.name
        partnerDescription.text = PartnerViewController.soarPartner.descript
        partnerLink = PartnerViewController.soarPartner.link
    }
    
    @IBAction func linkButton() {
        api.getPartnerLink(PartnerViewController.soarPartner.id)
    UIApplication.sharedApplication().openURL(NSURL(string: partnerLink)!)
    }
    
    @IBAction func backButton() {
        performSegueWithIdentifier("show_partners", sender: self)
    }
    
    
    
}
