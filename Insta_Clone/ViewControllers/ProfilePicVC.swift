//
//  ProfilePicVC.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/17/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit
import SDWebImage
class ProfilePicVC: UIViewController {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imgProfilePic: UIImageView!
    var postViewModel : PostViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard postViewModel?.images != nil else {return}
        setImageView(getImage(postViewModel!.images))
    }
    func getImage(_ images: Dictionary<String,Any>) -> String{
        let dict = images["standard_resolution"]! as! Dictionary<String, Any>
        return "\(dict["url"]!)"
    }
    func setImageView(_ url: String){
        imgProfilePic.sd_setImage(with: URL(string:url), placeholderImage: nil, options: .refreshCached, completed: { (image, err, cache, url) in
            self.imgProfilePic.image = image
        })
    }
    
    //MARK: - selBtnCancel
    @IBAction func selBtnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
