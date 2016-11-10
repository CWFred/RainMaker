//
//  ViewController2.swift
//  RainMaker
//
//  Created by Jean Piard on 11/10/16.
//  Copyright © 2016 Jean Piard. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController2: UIViewController {

    var devices = [device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
      
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func hi(_ sender: Any) {
        Alamofire.request("https://api.spark.io/v1/devices?access_token="+accessToken, method: .get).responseJSON { response in

            switch response.result {
                
            case .success(let value):
            let json = JSON(value)
            
            
               
           //devices.append(device.init(name: <#T##String#>, connected: json["connected"], lastIP: <#T##String#>, ID: <#T##String#>))
            
            //print(device.toString(self.devices[0]))
                
            case .failure(let error):
                print(error)
            }

            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
