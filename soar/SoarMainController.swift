import UIKit

class SoarMainController: SoarView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newMedia: Bool! 
    var detailItem: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load pack
        api.getUsers()
        api.getPartners()
        if(APIClient.register == 1) {
            NSNotificationCenter.defaultCenter().postNotificationName("openEditProfile", object: nil)
        }
        //create UI
        self.configureView()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView() {
        
    }
    
    @IBAction func sideBar(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }

    @IBAction func csusbURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://csusb.edu/")!)
    }

    @IBAction func infoURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://orientation.csusb.edu/")!)
    }

    @IBAction func photosURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.instagram.com/csusbsoar/")!)
    }

    @IBAction func mapURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://cdn-map1.nucloud.com/nucloudmap/index.html?map=92")!)
    }

    @IBAction func faqURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://orientation.csusb.edu/faqs.html")!)
    }

    @IBAction func conversationURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/csusbadmissions")!)
    }

    @IBAction func emergencyURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://9095375999")!)
    }

    @IBAction func toCamera(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {

        let cameraController = UIImagePickerController()
            cameraController.allowsEditing = false
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraController.cameraCaptureMode = .Photo
            cameraController.modalPresentationStyle = .FullScreen
            presentViewController(cameraController,
                animated: true,
                completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(
            alertVC,
            animated: true,
            completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]){
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {dismissViewControllerAnimated(true,completion: nil)
        dismissViewControllerAnimated(true,
            completion: nil)
    }
    //Camera delegates End//
    //Image Resizer

    
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // get the controller that storyboard has instantiated and set it's delegate
//        cameraController = segue!.destinationViewController as! UIImagePickerController
//        cameraController.delegate = self;
    }
}