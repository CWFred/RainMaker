//
//  Device.swift
//  RainMaker
//
//  Created by Jean Piard on 11/10/16.
//  Copyright © 2016 Jean Piard. All rights reserved.
//

import Foundation

class device {
    var ID :String!
    var connected : String!
    var lastIP: String!
    var name: String!
   
    

    init(name: String, connected : String, lastIP : String, ID:String) {
        self.name = name
        self.connected = connected
        self.lastIP = lastIP
        self.ID = ID
        
    }
    
    func toString() -> String {
        return "name: "+name+" ,id: "+ID+" ,Last IP adress:"+lastIP
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
