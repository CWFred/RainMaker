//
//  ViewController.swift
//  RainMaker
//
//  Created by Jean Piard on 11/4/16.
//  Copyright © 2016 Jean Piard. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var userNameInfo = ""
    var passwordInfo = ""
    var accessToken = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SignIn(_ sender: Any) {
         userNameInfo = userName.text!
         passwordInfo = password.text!
        
    
//        SparkCloud.sharedInstance().login(withUser: userNameInfo, password: passwordInfo) { error in
//            if error != nil {
//                print("Wrong credentials or no internet connectivity, please try again")
//            }
//            else {
//                print("Logged in")
//            }
//        }
        
        let header: HTTPHeaders = [
            "Authorization": "Basic",
            "Accept": "application/json"
        ]
        
        
        
        let parameters: Parameters = [
            "grant_type":"password",
            "client_id":123,
            "client_secret":123,
            "username":userNameInfo,
            "password":passwordInfo
            
        ]
        
        Alamofire.request("https://api.particle.io/oauth/token", method: .post, parameters: parameters, headers: header).authenticate(user: "particle", password: "particle").responseJSON { response in
            print(response)
            
           
        }
    
}
}
