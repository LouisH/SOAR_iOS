import UIKit
import Alamofire
import AlamofireImage

class PartnerController: PartnerTableView {
    var partnerImage: UIImage!
    var partnerImageView: UIImageView!
    var partnerName: UILabel!
    static var partnersArray: Array<Partner> = []
    static var currentPartner: String!
    var partners: Array<Partner>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.partners = PartnerController.partnersArray
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partners.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PartnerCell", forIndexPath: indexPath) as! PartnerCell
        cell.configureForPartner(partners[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        PartnerController.currentPartner = partners[indexPath.row].id
        api.getPartner(PartnerController.currentPartner)
        
    }
    @IBAction func bbutton(sender: UIButton) {
        performSegueWithIdentifier("show_home", sender: self)
    }
    
}