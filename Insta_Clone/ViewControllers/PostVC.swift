//
//  PostVC.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/16/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit

class PostVC: UIViewController {
    enum urlConstants: String{
        case authUrl = "https://api.instagram.com/oauth/authorize/?client_id=37f760e876354d19881800b74b451927&redirect_uri=https://kevaltpatel.wixsite.com/kevalmobiledeveloper&response_type=token&scope=likes+comments+relationships&DEBUG=True"
        case getData = "https://api.instagram.com/v1/users/self/media/recent/?access_token="
        case redirectUri = "https://kevaltpatel.wixsite.com/kevalmobiledeveloper"
    }
    @IBOutlet weak var colPosts: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var accessToken : String?
    var postViewModel = [PostViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colPosts.delegate = self
        colPosts.dataSource = self
        initialSetUp()
        setUpNavigationBar()
        // Set the PinterestLayout delegate
        if let layout = colPosts?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        fetchData(urlConstants.getData.rawValue, accessToken: accessToken ?? "")
        
    }
    /**
     Function that set up navigationBar properties.
     ## Properties
     - navigationItem title
     */
    func setUpNavigationBar(){
        self.navigationItem.title = "Instagram Images"
    }
    /**
     Calls *startAndShowActivity()* and Hide  tableView *tblFeeds*
     */
    func initialSetUp(){
        startAndShowActivity()
        colPosts.isHidden = true
    }
    /**
     Start animate and show activity *activityIndicator*
     */
    func startAndShowActivity(){
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    /**
     Stop animate and hide activity *activityIndicator*
     */
    func stopAndHideActivity(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func fetchData(_ url: String, accessToken : String){
        WebService.shared.fetchPosts(url, accessToken) { (postModels, error) in
            guard postModels != nil else{return}
            for post in postModels!{
                self.postViewModel.append(PostViewModel(post))
            }
            print("Done")
            DispatchQueue.main.async {
                self.initialSetUp()
                self.colPosts.isHidden = false
                self.colPosts.reloadData()
            }
        }
    }
    
}

extension PostVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colPosts.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.postViewModel = postViewModel[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postViewModel.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let destVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePicVC") as? ProfilePicVC{
            destVC.postViewModel = postViewModel[indexPath.row]
            self.present(destVC, animated: true, completion: nil)
        }
    }
}


//MARK: - PINTEREST LAYOUT DELEGATE
extension PostVC : PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if indexPath.item == 0 || indexPath.item % 3 == 0 {
            return 200
        }
        else{
            return 100
        }
    }
    
}
