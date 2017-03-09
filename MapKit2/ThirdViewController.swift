//
//  ThirdViewController.swift
//  MapKit2
//
//  Created by Pavani Vellal on 9/28/16.
//  Copyright © 2016 Pavani Vellal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ThirdViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    
    var myRoute : MKRoute!
    var sourceAddress: String = ""//"41588 Casabella Common,Fremont,94539"
    var destAddress: String = ""//"San Jose,San Jose,San Jose State University, 1 Washington Sq,95192"
    

    var source:MKMapItem = MKMapItem()
    var destination:MKMapItem = MKMapItem()
    var points:[CLLocationCoordinate2D] = []
    var locationManager: CLLocationManager! = CLLocationManager()
    var toAddress :String!
    var fromAddress :String!
    var counter = 0
    var curLocation: CLLocationCoordinate2D!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Map View"
        self.myMap.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //If source address is empty add curr location as source address
        if sourceAddress.isEmpty{
            addCurLoc(locValue: ((self.locationManager.location!.coordinate)))
            
        }
        else{
          addressGeocode(sourceAddress)
        }
        addressGeocode(destAddress)
        
    }
    
    func addressGeocode(_ address:String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler:{(placemarks, error) -> Void in
            if let placemark = placemarks?.first {
                let coordinates = placemark.location!.coordinate
                let latitude = coordinates.latitude
                let longitude = coordinates.longitude
                
                let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 10000.0, 10000.0)
                self.myMap.setRegion(region, animated: true)
                self.myMap.isZoomEnabled = true
                self.myMap.addAnnotation(MKPlacemark(placemark: placemark))
                self.addPoint(location)
                if(self.counter == 2){
                    self.showRoute()
                }
            }
        })
        
    }
    
    func addPoint(_ location: CLLocationCoordinate2D) {
        self.points.append(location)
        counter = counter + 1
    }
    
    
    func showRoute(){
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.points[0], addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: self.points[1],addressDictionary: nil))
        //request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                
                self.myMap.add(route.polyline)
                self.myMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2.0
        renderer.strokeColor = UIColor.red
        return renderer
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        
//    }
    
    func addCurLoc(locValue: CLLocationCoordinate2D) {

            let coordinates = locValue
            let latitude = coordinates.latitude
            let longitude = coordinates.longitude
        
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = locValue
            dropPin.title = "My Location"
    
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
            let region = MKCoordinateRegionMakeWithDistance(coordinates, 10000.0, 10000.0)
            self.myMap.setRegion(region, animated: true)
            self.myMap.isZoomEnabled = true
            self.myMap.addAnnotation(dropPin)
            self.addPoint(location)
            if(self.counter == 2){
                self.showRoute()
            }
        
    }
    
}
