import Foundation
import Alamofire
import AlamofireImage

var downloadedImage: UIImage!

class APIClient: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    static var register = 0
    static var loggedIn = 0
    static var optStatus = 0
    let manager: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        return Manager(configuration: configuration)
    }()
    func apiLogin(username:String) -> Void {
        
        let params = ["username" : username]
        
        Alamofire.request(.POST, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/login", parameters: params).responseJSON { response in
            if((response.result.value!.valueForKey("message") as! String).containsString("Register")) {
                APIClient.register = 1
            }
            let user = response.result.value
            let userDict : [String:String] = [
                "name": user!.valueForKey("name") as! String,
                "username": user!.valueForKey("username") as! String,
                "image_dir": user!.valueForKey("image_dir") as! String,
                "major": user!.valueForKey("major") as! String,
                "hobbies": user!.valueForKey("hobbies") as! String,
                "peeves": user!.valueForKey("peeves") as! String,
                "aspirations": user!.valueForKey("aspirations") as! String,
                "apiKey": user!.valueForKey("apiKey") as! String
            ]
            SessionController.setCoyote(userDict)
            APIClient.loggedIn = 1
            api.getOpt()
        }
    }
    
    func updateUser(name:String, major:String, hobbies:String, peeves:String, aspirations:String) -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        let params = ["name" : name, "major" : major, "hobbies" : hobbies, "peeves": peeves, "aspirations":aspirations];
        Alamofire.request(.POST, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/update", parameters: params, headers: headers).responseJSON {
            response in
            let error : Bool = response.result.value?.valueForKey("error") as! Bool
            if(!error) {
                let userDict : [String:String] = [
                    "name":name,
                    "major":major,
                    "hobbies":hobbies,
                    "peeves":peeves,
                    "aspirations":aspirations
                ]
                SessionController.updateCoyote(userDict)
                NSNotificationCenter.defaultCenter().postNotificationName("setHeaderText", object: nil)
            } else {
                print("ERROR OCCURRED WHILE UPDATING")
            }
        }
    }
    
    func getUsers() -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        print("STARTED USERS")
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/users", headers: headers).responseJSON { response in
            PackController.packArray = []
            if let jsonResult = response.result.value?.valueForKey("users") {
                print("OK REALLY DID START")
                for(var i=0;i<jsonResult.count;++i) {
                    let image_dir = jsonResult[i]["image_dir"] as! String
                    let idString = jsonResult[i]["id"] as! String
                    let name = jsonResult[i]["name"] as! String
                    let major = jsonResult[i]["major"] as! String
                    let hobbies = jsonResult[i]["hobbies"] as! String
                    let peeves = jsonResult[i]["peeves"] as! String
                    let aspirations = jsonResult[i]["aspirations"] as! String
                    let image : UIImage = UIImage()
                    let userI = Pack(name: name, major: major, hobbies: hobbies, peeves: peeves, aspirations: aspirations, image: image, id:idString)
                    print(userI)
                    PackController.packArray.append(userI)
                    self.downloadPackImage(image_dir, index: i)
                }
            }
        }
    }
    
    func getUser(id:String) -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        print("GET USER")
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/user/"+id, headers: headers).responseJSON { response in
            print(response.result.value)
            if let jsonResult = response.result.value?.valueForKey("user") {
                    print(jsonResult)
                    let image_dir = jsonResult["image_dir"] as! String
                    let name = jsonResult["name"] as! String
                    let major = jsonResult["major"] as! String
                    let hobbies = jsonResult["hobbies"] as! String
                    let peeves = jsonResult["peeves"] as! String
                    let aspirations = jsonResult["aspirations"] as! String
                    let image : UIImage = UIImage()
                    let pack = Pack(name: name, major: major, hobbies: hobbies, peeves: peeves, aspirations: aspirations, image: image, id: id)

                    self.downloadPackViewImage(image_dir, pack: pack)
            }
        }
    }
    
    func downloadPackImage(image_dir:String, index:Int) {
        Alamofire.request(.GET, image_dir).responseImage { response in
            if let responseImage = response.result.value {
                PackController.packArray[index].image = responseImage
            }
        }
    }
    
    
    
    func downloadPackViewImage(image_dir:String, pack:Pack) {
        Alamofire.request(.GET, image_dir).responseImage { response in
            if let responseImage = response.result.value {
                pack.image = responseImage
                PackViewController.soarUser = pack
                
            } else {
                pack.image = nil
                PackViewController.soarUser = pack
                NSNotificationCenter.defaultCenter().postNotificationName("showPackView", object: nil)
            }
        }
    }
    
    
    func uploadFile(let image:UIImage) -> Void {
        let imageData = UIImageJPEGRepresentation(image, 1.0);
        let encodedImage = (imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength))
        let headers = ["Authorization": SessionController.getApiKey()]
        let params = ["image":encodedImage]
        //the jello
        Alamofire.request(.POST, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/upload", parameters: params, headers: headers).responseJSON { response in
            print("Uploaded Image!")
            Alamofire.request(.GET, SessionController.getCoyoteImageDir()).responseImage { response in
                if let responseImage = response.result.value {
                    downloadedImage = responseImage
                NSNotificationCenter.defaultCenter().postNotificationName("setHeaderImage", object: nil)
                }
            }
        }
    }
    
    func updateDir() -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        Alamofire.request(.POST, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/updateDir", headers: headers).responseJSON {
            response in
            let error : Bool = response.result.value?.valueForKey("error") as! Bool
            if(!error) {
                let image_dir = response.result.value?.valueForKey("image_dir") as! String
                SessionController.updateImageDir(image_dir)
            } else {
                print("ERROR OCCURRED WHILE UPDATING IMAGE DIR")
            }
        }
    }
    
    func getOpt() -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/getopt", headers: headers).responseJSON {
            response in
            let error : Bool = response.result.value?.valueForKey("error") as! Bool
            if(!error) {
                let status = (response.result.value?.valueForKey("opt") as! NSString).integerValue
                SessionController.updateOpt(status)
                APIClient.optStatus = 1
            } else {
                print("ERROR OCCURRED WHILE GETTING OPT STATUS")
            }
        }
    }
    
    func setOpt() -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        Alamofire.request(.POST, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/setopt", headers: headers).responseJSON {
            response in
            let error : Bool = response.result.value?.valueForKey("error") as! Bool
            if(!error) {
                let status = response.result.value?.valueForKey("opt") as! Int
                SessionController.updateOpt(status)
            } else {
                print("ERROR OCCURRED WHILE GETTING OPT STATUS")
            }
        }
    }
    
    func getPartners() -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/partners", headers: headers).responseJSON { response in
            if let jsonResult = response.result.value?.valueForKey("partners") {
                
                for(var i=0;i<jsonResult.count;++i) {
                    let image_dir = jsonResult[i]["image_dir"] as! String
                    let idString = jsonResult[i]["id"] as! String
                    let name = jsonResult[i]["name"] as! String
                    let description = jsonResult[i]["description"] as! String
                    let link = jsonResult[i]["link"] as! String
                    let rating = jsonResult[i]["rating"] as! String
                    let image : UIImage = UIImage()
                    let partnerI = Partner(name: name, link: link, descript: description, image: image, rating: rating, id: idString)
                    if(PartnerController.partnersArray.count > i) {
                        if(PartnerController.partnersArray[i].id != idString) {
                            PartnerController.partnersArray.append(partnerI)
                            self.downloadPartnerImage(image_dir, index: i)
                        }
                    } else {
                        PartnerController.partnersArray.append(partnerI)
                        self.downloadPartnerImage(image_dir, index: i)
                    }
                }
            }
        }
    }

    func getPartner(id:String) -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        print("GET PARTNER")
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/partner/"+id, headers: headers).responseJSON { response in
            if let jsonResult = response.result.value?.valueForKey("partner") {
                
                let image_dir = jsonResult["image_dir"] as! String
                let name = jsonResult["name"] as! String
                let description = jsonResult["description"] as! String
                let link = jsonResult["link"] as! String
                let rating = jsonResult["rating"] as! String
                let image : UIImage = UIImage()
                let partner = Partner(name: name, link: link, descript: description, image: image, rating: rating, id: id)
                self.downloadPartnerViewImage(image_dir, partner: partner)
            }
        }
    }
    
    func getPartnerLink(id:String) -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/partner/"+id+"/link", headers: headers).responseJSON { response in
            if let _ = response.result.value {
                print("got link")
            }
        }
    }
    
    func downloadPartnerImage(image_dir:String, index:Int) {
        Alamofire.request(.GET, image_dir).responseImage { response in
            if let responseImage = response.result.value {
                PartnerController.partnersArray[index].image = responseImage
            }
        }
    }
    
    func downloadPartnerViewImage(image_dir:String, partner:Partner) {
        Alamofire.request(.GET, image_dir).responseImage { response in
            if let responseImage = response.result.value {
                partner.image = responseImage
                PartnerViewController.soarPartner = partner
                
            } else {
                partner.image = nil
                PartnerViewController.soarPartner = partner
            NSNotificationCenter.defaultCenter().postNotificationName("showPartnerView", object: nil)
            }
        }

    }
    //Downloads
    func getDownloads() -> Void {
        let headers = ["Authorization": SessionController.getApiKey()]
        Alamofire.request(.GET, "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/api/soar/v1/index.php/downloads", headers: headers).responseJSON { response in
            if let jsonResult = response.result.value?.valueForKey("downloads") {
                
                for(var i=0;i<jsonResult.count;++i) {
                    let idString = jsonResult[i]["id"] as! String
                    let name = jsonResult[i]["title"] as! String
                    let file = jsonResult[i]["file"] as! String
                    //let file = NSURL(fileURLWithPath: documentDirectoryPath.stringByAppendingString("http://107.170.239.96/api1/v1/index.php/downloads"))
                }
            }
        }
    }
    
    
}
var api = APIClient()

extension Array
{
    func containsObject(object: Any) -> Bool
    {
        if let anObject: AnyObject = object as? AnyObject
        {
            for obj in self
            {
                if let anObj: AnyObject = obj as? AnyObject
                {
                    if anObj === anObject { return true }
                }
            }
        }
        return false
    }
}
