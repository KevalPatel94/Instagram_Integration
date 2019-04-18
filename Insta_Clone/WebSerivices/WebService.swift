//
//  WebService.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/14/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import Foundation
class WebService: NSObject {
    static let shared = WebService()
    func fetchPosts(_ url: String,_ accessToken: String,completion: @escaping ([PostModel]?, Error?) -> ()) {
        DispatchQueue.main.async {
//            SVProgressHUD.show(withStatus: alert.loading.rawValue)
        }
        let urlString = "\(url)\(accessToken)"
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: []) as! [String:AnyObject]
                guard jsonResponse["data"] != nil  else{
                    completion(nil, err)
                    return
                }
                var postModelArray = [PostModel]()
                let array = jsonResponse["data"]! as! [Dictionary<String,Any>]
                for index in 0...array.count - 1{
                    let postModel = PostModel(images: array[index]["images"] as! Dictionary<String, Any>, tags: array[index]["tags"] as! [String])
                    postModelArray.append(postModel)
                }
                completion(postModelArray, err)
            }
            catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
    }
}
