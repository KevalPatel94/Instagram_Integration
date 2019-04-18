//
//  ViewController.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/11/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit
import SwiftInstagram
class ViewController: UIViewController {

    @IBOutlet weak var btnInstagramLogIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let api = Instagram.shared
//        
//        https://api.instagram.com/oauth/authorize/?client_id=37f760e876354d19881800b74b451927&redirect_uri=https://kevaltpatel.wixsite.com/kevalmobiledeveloper&response_type=token&scope=likes+comments+relationships&DEBUG=True
//        // Login
//        api.login(from: navigationController!, success: {
//            print("Success")
//            if let destVC = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as? LogInVC{
//                self.navigationController?.pushViewController(destVC, animated: true)
//            }
//            // Do your stuff here ...
//        }, failure: { error in
//            print(error.localizedDescription)
//        })
//        
//        // Returns whether a user is currently authenticated or not
//        let _ = api.isAuthenticated
//        print(api.isAuthenticated)
        // Logout
//        api.logout()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selbtnInstaLogIN(_ sender: Any) {
        if let destVC = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as? LogInVC{
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
    }
    
}

