import UIKit


class Partner {
    
    var name: String
    var link: String
    var descript: String
    var image: UIImage?
    var id: String
    var rating: String
    
    init(name: String, link: String, descript: String, image: UIImage?, rating: String, id: String) {
        self.name = name
        self.link = link
        self.descript = descript
        self.image = image
        self.rating = rating
        self.id = id
    }

}