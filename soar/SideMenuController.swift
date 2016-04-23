
import UIKit
class SideMenuController: UITableViewController {
    var instagramURL: NSURL!
    var instagramUploadURL: NSURL!
    var twitterURL: NSURL!
    var sideImages = []
    var sideNames = []
    var sideLinks = []
    var objects: [AnyObject]!
    var documentController: UIDocumentInteractionController!
    var imageOut: UIImage!
    var newMedia: Bool!
    var fileURL: NSURL!
    var mainSB = UIStoryboard(name: "Main", bundle: nil)
    var headerView: HeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1)
        self.sideNames = ["Home", "Partners", "Who's in the Pack?", "Downloads", "Soar Instagram", "Share Photos", "Join the Convo", "Campus Map", "Contact Us", "Feedback", "Logout"]
        self.sideImages = [UIImage(named: "side_home.png")!, UIImage(named: "side_partners.png")!, UIImage(named: "side_fellowyotes.png")!, UIImage(named: "side_downloads.png")!, UIImage(named: "side_photos.png")!, UIImage(named: "side_uploadphotos.png")!, UIImage(named: "side_conversation.png")!, UIImage(named: "side_map.png")!, UIImage(named: "side_contactus.png")!, UIImage(named: "side_feedback.png")!, UIImage(named: "side_logout.png")!]
        self.instagramURL = NSURL(string: "instagram://user?username=csusbsoar")!
        self.instagramUploadURL = NSURL(string: "instagram://camera")!
        self.twitterURL = NSURL(string: "twitter://user?screen_name=CSUSBofye")!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setHeaderText", name: "setHeaderText", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setHeaderImage", name: "setHeaderImage", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateHeaderImage", name: "updateHeaderImage", object: nil)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //cleanup
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = sideNames[indexPath.row] as? String
        cell.imageView!.image = sideImages[indexPath.row] as? UIImage
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
            case 0://home
                NSNotificationCenter.defaultCenter().postNotificationName("openHome", object: nil)
            break
            case 1://partners
                NSNotificationCenter.defaultCenter().postNotificationName("openPartners", object: nil)
            break
            case 2://whos in the pack
                NSNotificationCenter.defaultCenter().postNotificationName("openPack", object: nil)
            break
            case 3://downloads
                NSNotificationCenter.defaultCenter().postNotificationName("openDownloads", object: nil)
            break
            case 4://instagram
                if UIApplication.sharedApplication().canOpenURL(self.instagramURL) {
                    UIApplication.sharedApplication().openURL(self.instagramURL)
                } else {
                    UIApplication.sharedApplication().openURL(NSURL(string: "https://instagram.com/csusbadmissions/")!)
                }
            break
            case 5://upload instagram
                if UIApplication.sharedApplication().canOpenURL(self.instagramUploadURL) {
                    UIApplication.sharedApplication().openURL(self.instagramUploadURL)
                } else {
                    UIApplication.sharedApplication().openURL(NSURL(string: "https://instagram.com/")!)
                }
            break
            case 6://twitter
                if UIApplication.sharedApplication().canOpenURL(self.twitterURL) {
                    UIApplication.sharedApplication().openURL(self.twitterURL)
                } else {
                    UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/CSUSBofye")!)
                }
            break
            case 7://campus map
                UIApplication.sharedApplication().openURL(NSURL(string: "http://cdn-map1.nucloud.com/nucloudmap/index.html?map=92")!)
            case 8://contactus
                UIApplication.sharedApplication().openURL(NSURL(string: "https://orientation.csusb.edu/aboutUs/orientationLeader.html")!)
            break
            case 9://feedback
                NSNotificationCenter.defaultCenter().postNotificationName("openFeedback", object: nil)
            break
            case 10://logout
                SessionController.deleteSession()
                NSNotificationCenter.defaultCenter().postNotificationName("openLogout", object: nil)
            default:
                break
        }
    }


    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        headerView = HeaderView.loadNib()
        headerView.frame = CGRect(x: 0, y: 0, width: 260, height: 160)
        return headerView
    }
    
    func getHeader() -> HeaderView {
        self.headerView = HeaderView.loadNib()
        return headerView
    }
    
    func setHeaderText() {
        headerView.setTextProperties()
    }
    
    func setHeaderImage() {
        headerView.setImageProperties()
    }
    
    func updateHeaderImage(notification: NSNotification) {
        headerView.profileImage.image = notification.userInfo!["image"] as? UIImage
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
    }

    func infoURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://orientation.csusb.edu/")!)
    }

    func photosURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.instagram.com/csusbsoar/")!)
    }

    func conversationURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/csusbadmissions")!)
    }

    func emergencyURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://9095375999")!)
    }
    


    func setImage(image: UIImage, toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}