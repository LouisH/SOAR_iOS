import UIKit
import Alamofire
import AlamofireImage

class HeaderView : UIView {
    
    @IBOutlet var profileImage : UIImageView!
    @IBOutlet var nameText : UILabel!
    @IBOutlet var majorText : UILabel!
    @IBOutlet var hobbiesText : UILabel!
    @IBOutlet var peevesText : UILabel!
    @IBOutlet var aspirationsText : UILabel!
    var profileString : String!
    var imageCache = AutoPurgingImageCache()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let editTap = UITapGestureRecognizer(target:self, action:Selector("editProfile"))
        profileImage.addGestureRecognizer(editTap)
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        setTextProperties()
        setImageProperties()
        self.profileImage.setNeedsDisplay()
    }
    
    func setTextProperties() {
        nameText.text = SessionController.getCoyoteName()
        majorText.text = SessionController.getCoyoteMajor()
        hobbiesText.text = SessionController.getCoyoteHobbies()
        peevesText.text = SessionController.getCoyotePeeves()
        aspirationsText.text = SessionController.getCoyoteAspirations()
    }

    func setImageProperties() {
        profileString = SessionController.getCoyoteImageDir()
        Alamofire.request(.GET, profileString).responseImage { response in
            if let image = response.result.value {
                self.profileImage.image = image
                self.profileImage.setNeedsDisplay()
            }
        }
    }
    
    func setImageTo(image: UIImage) {
        
    }
    
    @IBAction func editProfile() {
        NSNotificationCenter.defaultCenter().postNotificationName("openEditProfile", object: nil)
    }

    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }

}