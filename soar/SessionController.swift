import UIKit
class SessionController: NSObject, NSURLConnectionDelegate, UITextFieldDelegate, NSXMLParserDelegate {
    var currentConnection: NSURLConnection!
    var xmlParser: NSXMLParser!
    static var coyoteName: String!
    
    static var coyoteMajor: String!
    
    static var coyoteHobbies: String!
    
    static var coyotePeeves: String!
    
    static var coyoteAspirations: String!
    
    static var coyoteImageDir: String!
    
    static var apiKey: String!
    
    static var optStatus: Int!
    
    static var user : [String : String]!

    static func getCoyoteName() -> String {
        return coyoteName
    }

    static func getCoyoteMajor() -> String {
        return coyoteMajor
    }

    static func getCoyoteHobbies() -> String {
        return coyoteHobbies
    }

    static func getCoyotePeeves() -> String {
        return coyotePeeves
    }

    static func getCoyoteAspirations() -> String {
        return coyoteAspirations
    }

    static func getCoyoteImageDir() -> String {
        return coyoteImageDir
    }

    static func getApiKey() -> String {
        return apiKey
    }

    func apiLoginURL() -> String {
        return "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/android_api/login.php"
    }

    func apiUpdateURL() -> String {
        return "http://ec2-54-200-96-167.us-west-2.compute.amazonaws.com/android_api/update.php"
    }
    
    static func updateOpt(status:Int) {
        optStatus = status
    }
    
    static func getOpt() -> Int {
        return optStatus
    }

    static func deleteSession() {
        coyoteName = "name"
        coyoteMajor = "major"
        coyoteHobbies = "hobbies"
        coyotePeeves = "peeves"
        coyoteAspirations = "aspirations"
        coyoteImageDir = "imagedir"
        apiKey = "apiKey"
    }

    static func setCoyote(user: NSDictionary) {
        coyoteName = user["name"] as! String
        coyoteMajor = user["major"] as! String
        coyoteHobbies = user["hobbies"] as! String
        coyotePeeves = user["peeves"] as! String
        coyoteAspirations = user["aspirations"] as! String
        coyoteImageDir = user["image_dir"] as! String
        apiKey = user["apiKey"] as! String
    }
    
    static func updateCoyote(user: NSDictionary) {
        coyoteName = user["name"] as! String
        coyoteMajor = user["major"] as! String
        coyoteHobbies = user["hobbies"] as! String
        coyotePeeves = user["peeves"] as! String
        coyoteAspirations = user["aspirations"] as! String
    }
    
    static func updateImageDir(image_dir: String) {
        coyoteImageDir = image_dir
    }

}

var sc = SessionController()


