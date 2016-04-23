//
//  PackViewController.swift
//  soar
//
//  Created by Ryan Stegman on 3/16/16.
//  Copyright © 2016 Ryan Stegman. All rights reserved.
//

import UIKit

class PackViewController : SoarView {
    @IBOutlet var profileImage : UIImageView!
    @IBOutlet var profileName : UILabel!
    @IBOutlet var profileMajor : UILabel!
    @IBOutlet var profileHobbies : UILabel!
    @IBOutlet var profilePeeves : UILabel!
    @IBOutlet var profileAspirations : UILabel!
    static var soarUser : Pack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(profileImage.image !== nil) {
            profileImage.image = PackViewController.soarUser.image
        }
        profileName.text = PackViewController.soarUser.name
        profileMajor.text = PackViewController.soarUser.major
        profileHobbies.text = PackViewController.soarUser.hobbies
        profilePeeves.text = PackViewController.soarUser.peeves
        profileAspirations.text = PackViewController.soarUser.aspirations
        
    }
    
    @IBAction func backButton() {
        performSegueWithIdentifier("show_pack", sender: self)
    }

    
    
}
