//
//  ViewController.swift
//  Test Instagram
//
//  Created by Aaqib Hussain on 02/08/2017.
//  Copyright © 2017 Aaqib Hussain. All rights reserved.
//

import UIKit
import InstagramKit



class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let auth = InstagramEngine.shared().authorizationURL()
        self.webView.loadRequest(URLRequest(url: auth))
        getUserDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserDetails(){
    
        InstagramEngine.shared().getSelfUserDetails(success: { (user) in
            print("User:\(user.fullName ?? "")\nProfile:\(user.profilePictureURL?.absoluteString ?? "")")
            
        }, failure: { (error, code) in
          print(error.localizedDescription)
        })
    
    }


}
extension ViewController: UIWebViewDelegate{


//MARK: WebView
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        do {
            if let url = request.url {
                if (String(describing: url).range(of: "access") != nil){
                    try InstagramEngine.shared().receivedValidAccessToken(from: url)
                    
                    if let accessToken = InstagramEngine.shared().accessToken {
                        NSLog("accessToken: \(accessToken)")
                      
                        
                    }
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        return true
    }






}
