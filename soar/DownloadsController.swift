import UIKit
import Alamofire
import AlamofireImage

class DownloadsController: DownloadTableView {
    
    @IBOutlet weak var fileName: UILabel!
    static var downloadsArray: Array<Download> = []
    static var currentDownload: String!
    var downloads: Array<Download>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloads = DownloadsController.downloadsArray
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
        return downloads.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    @IBAction func downloadsBackButton(sender: UIButton) {
        performSegueWithIdentifier("show_home", sender: self)
    }
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DownloadCell", forIndexPath: indexPath) as! DownloadCell
        cell.configureForDownload(downloads[indexPath.row])
        return cell
    }*/
    
    
    //Not sure about this, should get file(pdf) from server. If so, need func in API
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        DownloadsController.currentDownload = downloads[indexPath.row].id
        //api.getDownloads(DownloadsController.currentDownload)
    }
    
    
    
}