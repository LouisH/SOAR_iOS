import UIKit
import Alamofire
import AlamofireImage

class PartnerController: UITableViewController {
    var packImage: UIImage!
    var packImageView: UIImageView!
    var packName: UILabel!
    var packMajor: UILabel!
    var packHobbies: UILabel!
    var packPeeves: UILabel!
    var packAspirations: UILabel!
    var partners: Array<Partner>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        UIApplication.sharedApplication().openURL(NSURL(string: partners[indexPath.row].link)!)
    }
    
}