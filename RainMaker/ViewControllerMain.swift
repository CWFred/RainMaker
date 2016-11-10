//
//  ViewControllerMain.swift
//  RainMaker
//
//  Created by Jean Piard on 11/10/16.
//  Copyright © 2016 Jean Piard. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewControllerMain: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
  
        Alamofire.request("https://api.spark.io/v1/devices?"+accessToken, method: .get).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
               print(json)
               
                
            case .failure(let error):
                print(error)
            }
            
            
        }
       

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logOut(_ sender: Any) {
    }
    
    
    
}
