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

class ViewController2: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.reloadData()
        
        self.tableView.reloadData()
        self.tableView.reloadData()
        self.tableView.reloadData()
        self.tableView.reloadData()
        
        // Using direct connection to particle Cloud.
//        Alamofire.request("https://api.spark.io/v1/devices?access_token="+accessToken, method: .get).responseJSON { response in
//            
//            switch response.result {
//                
//            case .success(let value):
//                let json = JSON(value)
//                
//                
//                for i in 0...(json.array?.count)!-1 {
//                    
//                    
//                    let name: String = json[i]["name"].stringValue
//                    let connected : String = json[i]["connected"].stringValue
//                    let lastIp : String = json[i]["last_ip_address"].stringValue
//                    let id : String = json[i]["id"].stringValue
//                    
//                    self.devices.append(device.init(name: name, connected: connected, lastIP: lastIp, ID: id))
//                    
//                    self.tableView.reloadData()
//                    
//                    
//                }
//                
//            case .failure(let error):
//                print(error)
//            }
//            
//            
//        }
        
    }
    

    @IBOutlet weak var tableView: UITableView!
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = devices[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "actions", sender: devices[indexPath.row])
        
        
    }
    
    // Might be deprecated now that the Node server handles the calling and devices before the screen is loaded.
    @IBAction func reload(_ sender: Any) {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.reloadData()
        
        
//        devices = [device]()
//        Alamofire.request("https://api.spark.io/v1/devices?access_token="+accessToken, method: .get).responseJSON { response in
//            
//            switch response.result {
//                
//            case .success(let value):
//                let json = JSON(value)
//                
//                
//                for i in 0...(json.array?.count)!-1 {
//                    
//                    
//                    let name: String = json[i]["name"].stringValue
//                    let connected : String = json[i]["connected"].stringValue
//                    let lastIp : String = json[i]["last_ip_address"].stringValue
//                    let id : String = json[i]["id"].stringValue
//                    
//                    devices.append(device.init(name: name, connected: connected, lastIP: lastIp, ID: id))
//                    
//                    self.tableView.reloadData()
//                    
//                    
//                }
//                
//            case .failure(let error):
//                print(error)
//            }
//            
        
    //}
    

    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! ViewControllerActions
        guest.deviceSelected = sender as! device
    }
   }
