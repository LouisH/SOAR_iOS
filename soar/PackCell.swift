import Alamofire
import AlamofireImage
import Foundation
import UIKit

class PackCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var packNameLabel: UILabel!
    @IBOutlet weak var packMajorLabel: UILabel!
    @IBOutlet weak var packHobbiesLabel: UILabel!
    @IBOutlet weak var packPeevesLabel: UILabel!
    
    func configureForPack(pack: Pack) {
        userImageView.image = pack.image
        packNameLabel.text = pack.name
        packMajorLabel.text = pack.major
        packHobbiesLabel.text = pack.hobbies
        packPeevesLabel.text = pack.peeves
    }
    
}