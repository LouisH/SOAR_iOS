import UIKit
import Alamofire
import AlamofireImage

class PackController: PackTableView {
    var packImage: UIImage!
    var packImageView: UIImageView!
    var packName: UILabel!
    var packMajor: UILabel!
    var packHobbies: UILabel!
    var packPeeves: UILabel!
    var packAspirations: UILabel!
    static var packArray: Array<Pack> = []
    static var currentPack: String!
    var pack: Array<Pack>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getUsers()
        self.pack = PackController.packArray
        tableView.reloadData()
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
        return pack.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PackCell", forIndexPath: indexPath) as! PackCell
        cell.configureForPack(pack[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        PackController.currentPack = pack[indexPath.row].id
        api.getUser(PackController.currentPack)
    }
    
    @IBAction func bbbuttun(sender: UIButton) {
        performSegueWithIdentifier("show_home", sender: self)
    }
    

}