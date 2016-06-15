//
//  DownloadCell.swift
//  soar
//
//  Created by Lou on 6/3/16.

import Alamofire
import AlamofireImage
import Foundation
import UIKit

class DownloadCell: UITableViewCell {
    
    weak var fileTitle: UILabel!
    
    func configureForDownload(download: Download) {
        //fileTitle.text = download.title
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.stackoverflow.com")!)
    }
    
}