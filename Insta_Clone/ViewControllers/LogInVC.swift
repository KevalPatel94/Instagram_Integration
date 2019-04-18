//
//  LogInVC.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/11/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import UIKit
import WebKit
import SwiftInstagram
class LogInVC: UIViewController {
    enum urlConstants: String{
        case authUrl = "https://api.instagram.com/oauth/authorize/?client_id=37f760e876354d19881800b74b451927&redirect_uri=https://kevaltpatel.wixsite.com/kevalmobiledeveloper&response_type=token&scope=likes+comments+relationships&DEBUG=True"
        case getData = "https://api.instagram.com/v1/users/self/media/recent/?access_token="
        case redirectUri = "https://kevaltpatel.wixsite.com/kevalmobiledeveloper"
    }
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var wkWebView: WKWebView!
    let urlString = urlConstants.authUrl.rawValue
    var accessToken = ""
    private var estimatedProgressObserver: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        loadWebPage(urlString)
    }
    /**
     Function that set up navigationBar properties.
     ## Properties
     - navigationItem title
     */
    func setUpNavigationBar(){
        self.navigationItem.title = "Login To Instagram"
    }
    func loadWebPage(_ urlString: String){
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        wkWebView.allowsBackForwardNavigationGestures = true
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        wkWebView.load(myRequest)
        webViewProperties()
    }
    func fetchData(_ url: String, accessToken : String){
        WebService.shared.fetchPosts(url, accessToken) { (PostModel, error) in
            print("Done")
        }
    }
    /**
     Function that set up WKWebView properties and set up observer.
     ## Properties
     
     - set uiDelegate
     - set navigationDelegate
     - set allowsBackForwardNavigationGestures
     - set up observer and animate progress *progressView*
     */
    func webViewProperties(){
        estimatedProgressObserver = wkWebView.observe(\.estimatedProgress, options: [.new]) { [weak self] wkWebView, _ in
            self?.progressView.progress = Float(wkWebView.estimatedProgress)
        }
    }
    /**
     Show progressView with animation
     */
    func showProgressView() {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }
    
    /**
     Hide progressView with animation
     */
    func hideProgressView() {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0
        }, completion: nil)
    }

}

//MARK: - WKNavigationDelegate Methods
extension LogInVC : WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgressView()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showProgressView()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideProgressView()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
        let responseUrl = navigationResponse.response.url
        guard responseUrl != nil else {return}
        let strUrl = "\(responseUrl!)"
        print(strUrl)
        if strUrl.hasPrefix(urlConstants.redirectUri.rawValue){
            let str = strUrl.components(separatedBy:"#access_token=")
            accessToken = str[1]
            if let destVC = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as? PostVC{
                destVC.accessToken = accessToken
                self.navigationController?.pushViewController(destVC, animated: true)
            }
        }
    }

}

