import UIKit
import Alamofire

class LoginController: UIViewController, UITextFieldDelegate {
    var currentConnection: NSURLConnection!
    var xmlParser: NSXMLParser!

    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var usernameText: String!
    var passwordText: String!
    var ticketString: String!
    var username : String!
    var password : String!
    var checkString : String!
    var lt: String!
    var execution: String!
    var data: NSData!
    var CASUrl = "https://weblogon.csusb.edu/cas/login?service=https://weblogon.csusb.edu/cas/login"
    var progressView: UIProgressView!
    var userObject = [NSObject : AnyObject]()
    var loggingIn : Int!
    var notification: NSNotification?
    var errorAlert = UIAlertController!()
    let ltInputTagString: NSString = "input type=\"hidden\" name=\"lt\" value=\""
    let executionInputTagString: NSString = "input type=\"hidden\" name=\"execution\" value=\""
    let ticketInputTagString: NSString = "ticket="
    let regex: NSString = "([a-zA-Z0-9\\-]*)?"
    var nsText : NSString!
    var ltInputTagRange : NSRange!
    var ltPosition : Int!
    var ltRange : NSRange!
    var executionInputTagRange : NSRange!
    var executionPosition : Int!
    var executionRange : NSRange!
    let actionOk = UIAlertAction(title: "OK",
        style: .Default,
        handler: nil)

    
    
//    @IBAction func forgotPasswordTapped(sender: UIButton) {
//        findAndResignFirstResponder()
//        let alertView = UIAlertView(title: "Forgot Password", message: "Please enter your " +
//            "email address. Instructions on how to reset your password will be sent there.",
//            delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Submit")
//        alertView.alertViewStyle = .PlainTextInput
//        alertView.textFieldAtIndex(0)!.keyboardType = .EmailAddress
//        alertView.show()
//    }
    


    override func viewDidLoad() {
        loggingIn = 0;
        //keyboard closes on tap
        let tapper = UITapGestureRecognizer.init(target:self, action:Selector("findAndResignFirstResponder"))
        tapper.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tapper);
        //keyboard notifications
        //configure view -- delete
        self.configureView()
        //delegates
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        findAndResignFirstResponder()
        
    }
    
    func findAndResignFirstResponder() {
        if usernameField.isFirstResponder() {
            usernameField.resignFirstResponder()
        } else if(passwordField.isFirstResponder()) {
            passwordField.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configureView() {
        //Makingn view nice
        self.usernameField.autocapitalizationType = .None
        self.usernameField.keyboardType = .Default
        self.usernameField.placeholder = "Coyote ID"
        
        self.passwordField.autocorrectionType = .No
        self.passwordField.keyboardType = .Default
        self.passwordField.secureTextEntry = true
        self.passwordField.placeholder = "Password"
        
    }
    
    

    @IBAction func tryLogin(sender: AnyObject) {
        findAndResignFirstResponder()
        loginIndicator.startAnimating()
        if(self.loggingIn == 0) {
            //Check internet
            self.loggingIn = 1
            self.username = self.usernameField.text ?? ""
            self.password = self.passwordField.text ?? ""
            if(self.usernameField.text != "" && self.passwordField.text != "" && !self.usernameField.text!.isEmpty) {
            Alamofire.request(.GET, self.CASUrl).responseString { response in
                if(response.response!.statusCode == 200) {
                    let result = NSString(data: response.data!, encoding: NSASCIIStringEncoding) as! String
                    self.getLtandExec(result)
                    let params = [
                        "username":self.username,
                        "password":self.password,
                        "lt":self.lt,
                        "execution":self.execution,
                        "_eventId":"submit",
                        "submit":"Login"
                    ]
                    Alamofire.request(.POST, self.CASUrl, parameters: params, encoding: .URL).responseJSON { response in
//                      var token = response.response?.valueForKey("URL") as! String
//                      var ticket = self.getTicket(token)
                        let result = NSString(data: response.data!, encoding: NSASCIIStringEncoding) as! String
                        if(result.containsString("Successful")){ //REPLACE WITH GRABBING TICKET
                            self.loginSuccess()
                        } else {
                            self.loginIndicator.stopAnimating()
                            self.loginFailure()
                        }
                    }
                } else {
                    self.loginIndicator.stopAnimating()
                    self.networkFailure()
                }
            }
        } else {
            let alertVC = UIAlertController(title: "Missing Coyote ID or Password", message: "Please enter your Coyote ID and Password", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertVC.addAction(okAction)
            presentViewController(
                alertVC,
                animated: true,
                completion: nil)
            self.loggingIn = 0
            self.loginIndicator.stopAnimating()
        }
        }
    }
    //prepare for login
    func getLtandExec(resultString:String){
        if(!resultString.containsString("Successful")) {

            nsText = resultString
            // Parse the LT and execution from the HTML response body
        
            ltInputTagRange = nsText.rangeOfString("\(ltInputTagString)\(regex)", options:NSStringCompareOptions.RegularExpressionSearch)
        
            ltPosition = ltInputTagRange.location+ltInputTagString.length
            ltRange = NSMakeRange(ltPosition, ltInputTagRange.length-ltInputTagString.length)
            lt = nsText.substringWithRange(ltRange)
            print(lt)
        
            executionInputTagRange = nsText.rangeOfString("\(executionInputTagString)\(regex)", options:NSStringCompareOptions.RegularExpressionSearch)
            executionPosition = executionInputTagRange.location+executionInputTagString.length
            executionRange = NSMakeRange(executionPosition, executionInputTagRange.length-executionInputTagString.length)
            execution = nsText.substringWithRange(executionRange)
            print(execution)
            
        }
    }
    
    func getTicket(responseString:String){
        if(responseString.containsString("ticket")) {
            
//            var ticket = responseString
//            var ticketTagRange = responseString.rangeOfString("\(self.ticketInputTagString)\(self.regex)", options:NSStringCompareOptions.RegularExpressionSearch)
//            var ticketPosition = ticketTagRange.location+self.ticketInputTagString.length
//            var ticketRange = NSMakeRange(ticketPosition, ticketTagRange.length-self.ticketInputTagString.length)
//            var ticketSub = ticket?.substringWithRange(ticketRange)
//            print(ticketSub)
            
        }
    }

    
    func loginSuccess() {
        api.apiLogin(self.username)
        
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(2.0 * Double(NSEC_PER_SEC))
        ), dispatch_get_main_queue(), {
            self.loginIndicator.stopAnimating()
            self.performSegueWithIdentifier("login_success", sender: self)
            self.loggingIn = 0
        })
        
        
    }
    
    func networkFailure() {
        self.loggingIn = 0
        errorAlert = UIAlertController(title: "No Internet Access", message: "Please connect to the internet before logging in.", preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(actionOk)
        presentViewController(errorAlert, animated: true, completion: nil)
    }
    func loginFailure() {
        self.loggingIn = 0
        errorAlert = UIAlertController(title: "Invalid Coyote ID or password", message: "Please try logging in again", preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(actionOk)
        presentViewController(errorAlert, animated: true, completion: nil)
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

    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance: Int = 160
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

    func dismissKeyboard() {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    
}
var lc = LoginController()

