import Alamofire
import AlamofireImage
import Foundation
import UIKit

class PartnerCell: UITableViewCell {
    
    @IBOutlet weak var partnerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureForPartner(partner: Partner) {
        partnerImageView.image = partner.image
        partnerImageView.contentMode = .ScaleAspectFit  //no stretching images
        descriptionLabel.text = partner.name
    }
    
}