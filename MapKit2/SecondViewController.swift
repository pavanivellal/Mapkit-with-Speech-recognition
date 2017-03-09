//
//  SecondViewController.swift
//  MapKit2
//
//  Created by Pavani Vellal on 9/26/16.
//  Copyright © 2016 Pavani Vellal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var sourceAddress: String! //= "Golden Gate Bridge, San Francisco, CA, USA" // To be fetched from the first view
    var destAddress: String! //= "San Jose State University, 1 washington sq, San Jose, CA, USA, 95192" // To be fetched from the first view
    var pointV:pointVals?
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var showingLocation: UILabel!
    
    
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(rawAddress)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let geocoder1 = CLGeocoder()
        let geocoder2 = CLGeocoder()
        
        geocoder1.geocodeAddressString(sourceAddress, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 100000.0, 100000.0)
                self.myMap.setRegion(region, animated: true)
                self.myMap.isZoomEnabled = true
                self.myMap.addAnnotation(MKPlacemark(placemark: placemark))
                
            }
        })
        
        geocoder2.geocodeAddressString(destAddress, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 100000.0, 100000.0)
                self.myMap.setRegion(region, animated: true)
                self.myMap.isZoomEnabled = true
                self.myMap.addAnnotation(MKPlacemark(placemark: placemark))
                
                
            }
        })
        
        
        
        
    }


}

