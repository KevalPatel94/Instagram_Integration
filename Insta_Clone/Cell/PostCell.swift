//
//  PostCell.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/16/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit
import SDWebImage
class PostCell: UICollectionViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblHashTag: UILabel!

    var postViewModel : PostViewModel!{
        didSet{
            postImageView.sd_setImage(with: URL(string: getImage(postViewModel.images)), placeholderImage:UIImage(named: "PlaceHolder"), options: .refreshCached, completed: { (image, err, cache, url) in
            })
            guard postViewModel?.tags != nil else {return}
            lblHashTag.text = getHashTags(postViewModel!.tags)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblHashTag.layer.cornerRadius = 1.0
        lblHashTag.layer.masksToBounds = true
       
    }
    func getImage(_ images: Dictionary<String,Any>) -> String{
        let dict = images["standard_resolution"]! as! Dictionary<String, Any>
        return "\(dict["url"]!)"
    }
    func getHashTags(_ hashTagArray: [String]) -> String{
        var str = ""
        for index in hashTagArray {
            str.append("#\(index)")
        }
        return str
    }
}
