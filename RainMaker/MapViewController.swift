//
//  MapViewController.swift
//  RainMaker
//
//  Created by Jean Piard on 12/11/16.
//  Copyright © 2016 Jean Piard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
var locationDevice: CLLocation!
var locationUser: CLLocation!




    
    class MapViewController: UIViewController, CLLocationManagerDelegate {
          @IBOutlet weak var mapView: MKMapView!
        
        let manager = CLLocationManager()
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        
        @IBAction func displayUser(_ sender: Any) {
            
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationUser.coordinate.latitude, locationUser.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            
        }
        
        @IBAction func displayDevice(_ sender: Any) {
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = locationDevice.coordinate
            dropPin.title = "Device"
            mapView.addAnnotation(dropPin)
            
            
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationDevice.coordinate.latitude, locationDevice.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            mapView.setRegion(region, animated: true)
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
            
            locationUser = locations[0];
        }
        

 
        
        
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            //var latlong : [String]
           // latlong = locationinString.components(separatedBy: ",")
            
           // locationDevice = CLLocation(latitude: Double(latlong[0])!, longitude: Double(latlong[1])!)
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
}
