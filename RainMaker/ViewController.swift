//
//  ViewController.swift
//  RainMaker
//
//  Created by Jean Piard on 11/4/16.
//  Copyright © 2016 Jean Piard. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var accessToken = ""
var userNameInfo = ""
var passwordInfo = ""

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
   
    
    
    
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
            "password":passwordInfo,

            
        ]
        
        Alamofire.request("https://api.particle.io/v1/devices", method: .post, parameters: parameters, headers: header).authenticate(user: "particle", password: "particle").responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                accessToken = json["access_token"].stringValue
                //self.performSegue(withIdentifier: "SignInComplete", sender: self)
                
            case .failure(let error):
                print(error)
            }
            
           
        }
    
}
}
