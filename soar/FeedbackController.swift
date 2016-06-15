import UIKit

class FeedbackController: SoarView, UITextFieldDelegate {
    
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    var subjectInput: String!
    var messageInput: String!
    let UIAccessibilityAnnouncementKeyStringValue = "Success"
    
    
    @IBOutlet weak var cancel: UILabel!
    
    @IBAction func changeSubject(sender: AnyObject) {
        subjectInput = subjectField.text
    }
    
    @IBAction func changeMessage(sender: AnyObject) {
        messageInput = messageField.text
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectField.delegate = self
        messageField.delegate = self
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIButton) {
        performSegueWithIdentifier("show_home", sender: self)
    }
    
    @IBAction func sendButton(){
        let url = NSURL(string: "mailto:003977661@coyote.csusb.edu" + "?subject=" + subjectInput + "&body=" + messageInput)
        UIApplication.sharedApplication().openURL(url!)
        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.UIAccessibilityAnnouncementKeyStringValue)
        print("hi")
    }
    
    //Making keyboard nice
    
    //Tap to remove keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //Move everything to see text when typing
    func textFieldDidBeginEditing(textField: UITextField) {
        self.animateTextField(textField, up: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.animateTextField(textField, up: false)
    }
    @IBAction func cancelButton() {
        performSegueWithIdentifier("show_home", sender: self)
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            let movementDistance: Int = 100
            // tweak as needed
            let movementDuration: NSTimeInterval = 0.3
            // tweak as needed
            let movement: CGFloat = CGFloat((Int(up ? -movementDistance : movementDistance)))
            UIView.beginAnimations("anim", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(movementDuration)
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
            UIView.commitAnimations()
        } else {
        let movementDistance: Int = 220
        // tweak as needed
        let movementDuration: NSTimeInterval = 0.3
        // tweak as needed
        let movement: CGFloat = CGFloat((Int(up ? -movementDistance : movementDistance)))
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
        }
    }
    func dismissKeyboard() {
        self.messageField.resignFirstResponder()
    }
 }