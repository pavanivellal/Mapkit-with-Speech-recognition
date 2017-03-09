//
//  FirstViewController.swift
//  MapKit2
//
//  Created by Pavani Vellal on 9/26/16.
//  Copyright © 2016 Pavani Vellal. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITabBarControllerDelegate {

    @IBOutlet weak var iFromStreet: UITextField!
    @IBOutlet weak var iCity: UITextField!
    @IBOutlet weak var iState: UITextField!
    @IBOutlet weak var iZipCode: UITextField!

    @IBOutlet weak var iToStreet: UITextField!
    @IBOutlet weak var iToCity: UITextField!
    @IBOutlet weak var iToState: UITextField!
    @IBOutlet weak var iToZipCode: UITextField!
    


    var fromPlace:String!
    var toPlace:String!
    var pointV = pointVals()
    
    @IBAction func Go(_ sender: AnyObject) {
        
        fromPlace = iFromStreet.text! + "," +  iCity.text! +  "," + iState.text! + "," + iZipCode.text!
        print(fromPlace)
        toPlace = iToCity.text! + "," + iToCity.text! + "," + iToState.text! + "," + iToZipCode.text!
        print(toPlace)
        
        pointV.sourceStreet = iFromStreet.text
        pointV.sourceCity = iCity.text
        pointV.sourceState = iState.text
        pointV.sourceZipCode = iZipCode.text
        
        pointV.destStreet = iToStreet.text
        pointV.destCity = iToCity.text
        pointV.destState = iToState.text
        pointV.destZipCode = iToZipCode.text
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let MapVC2 = segue.destination as? SecondViewController{
            fromPlace = iFromStreet.text! + "," +  iCity.text! +  "," + iZipCode.text!
            print(fromPlace)
            toPlace = iToCity.text! + "," + iToCity.text! + "," + iToZipCode.text!
            print(toPlace)
            MapVC2.sourceAddress = fromPlace
            MapVC2.destAddress = toPlace
        }
        
        if let MapVC3 = segue.destination as? ThirdViewController{
            fromPlace = iFromStreet.text! + "," +  iCity.text! +  "," + iZipCode.text!
            print(fromPlace)
            toPlace = iToCity.text! + "," + iToCity.text! + "," + iToZipCode.text!
            print(toPlace)
            MapVC3.sourceAddress = fromPlace
            MapVC3.destAddress = toPlace
        }
    }
    
}


