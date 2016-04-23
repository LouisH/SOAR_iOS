import UIKit


class Pack {
    
    var name: String
    var major: String
    var hobbies: String
    var peeves: String
    var aspirations: String
    var id: String
    var image: UIImage?
    
    init(name: String, major: String, hobbies: String, peeves: String, aspirations: String, image: UIImage?, id: String) {
        self.name = name
        self.major = major
        self.hobbies = hobbies
        self.peeves = peeves
        self.aspirations = aspirations
        self.image = image
        self.id = id
    }
}