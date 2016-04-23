import UIKit
import Alamofire
import AlamofireImage

class EditProfileController: SoarView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newMedia: Bool!
    @IBOutlet var imageOut: UIImageView!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var majorInput: UITextField!
    @IBOutlet var hobbiesInput: UITextField!
    @IBOutlet var peevesInput: UITextField!
    @IBOutlet var aspirationsInput: UITextField!
    @IBOutlet var optSwitch: UISwitch!
    
    var currentImage : String!
    var resizedImage : UIImage!
    var didChangeImage : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(SessionController.optStatus == 0) {
            optSwitch.setOn(false, animated: false)
        } else {
            optSwitch.setOn(true, animated: false)
        }
        optSwitch.addTarget(self, action: Selector("toggleOpt:"), forControlEvents: UIControlEvents.ValueChanged)
        let chooseTap = UITapGestureRecognizer(target:self, action:Selector("chooseImage"))
        imageOut.addGestureRecognizer(chooseTap)
        setText()
        setPreview()
        didChangeImage = false
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidAppear(animated: Bool) {
        if(SessionController.optStatus == 0) {
            optSwitch.setOn(false, animated: false)
        } else {
            optSwitch.setOn(true, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText() {
        nameInput.text = SessionController.getCoyoteName()
        majorInput.text = SessionController.getCoyoteMajor()
        hobbiesInput.text = SessionController.getCoyoteHobbies()
        peevesInput.text = SessionController.getCoyotePeeves()
        aspirationsInput.text = SessionController.getCoyoteAspirations()
    }
    
    func setPreview() {
        currentImage = SessionController.getCoyoteImageDir()
        Alamofire.request(.GET, currentImage).responseImage { response in
            if let image = response.result.value {
                self.imageOut.image = image
            }
        }
    }
    
    func toggleOpt(switchState: UISwitch) {
        api.setOpt()
    }
    
    @IBAction func chooseImage() {

        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        imageOut.image = newImage
        didChangeImage = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func save() {
        updateUserProfle()
        if(APIClient.register == 1){
            APIClient.register = 0
        }
        NSNotificationCenter.defaultCenter().postNotificationName("openHome", object: nil)
    }
    
    func updateUserProfle() {
        if(didChangeImage == true) {
            if(SessionController.getCoyoteImageDir().containsString("default")) {
                api.updateDir()
                print("updating dir")
            }
            api.uploadFile(self.imageOut.image!)
            print("uploading image")
        }
        api.updateUser(nameInput.text!, major: majorInput.text!, hobbies: hobbiesInput.text!, peeves: peevesInput.text!, aspirations: aspirationsInput.text!)
        print("updating user")
        let userInfo = ["image": self.imageOut.image!]
        NSNotificationCenter.defaultCenter().postNotificationName("updateHeaderText", object: nil, userInfo: userInfo)
    }
}