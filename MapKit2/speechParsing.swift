//
//  speechParsing.swift
//  MapKit2
//
//  Created by Sheshagiri Haniyur on 11/28/16.
//  Copyright © 2016 Sheshagiri Haniyur. All rights reserved.
//


class speechParsing {
    
    var fullText: String
    var fromPlace: String
    var toPlace: String
    var fromCity: String
    var toCity: String
    var fromZip: String
    var toZip: String
    var fromState: String
    var toState: String
    var status:Bool
    var arrs = ["from", "directions from","direction from","direction between", "route between"]
    var goarrs = ["go to","goto", "route to"]
    
    
    init() {
        self.fullText = ""
        self.fromPlace = ""
        self.toPlace = ""
        self.fromCity = ""
        self.toCity = ""
        self.fromZip = ""
        self.toZip = ""
        self.fromState = ""
        self.toState = ""
        self.status = false
        
    }
    
    
    func parseText(arr: String)
    {
        
//        for arr in arrs {
//        
//        var i = fullText.lowercased().range(of: arr)
//        if (fullText.lowercased().range(of: arr)) != nil{
//        var temp1 = fullText.lowercased().replacingOccurrences(of: arr, with: "", options: .literal, range: nil)
//        temp1 = temp1.lowercased().replacingOccurrences(of: "find ", with: "", options: .literal, range: nil)
//        temp1 = temp1.replacingOccurrences(of: " to ", with: " , ", options: .literal, range: nil)
//        var strArr = temp1.characters.split{$0 == ","}.map(String.init)
//        self.fromPlace = strArr[0]
//        self.toPlace = strArr[1]
//        self.status = true
//            break
//        }
//        else{
//        self.status = false
//        }
//        }
        
        var fi = fullText.lowercased().range(of: "from")
        var ti = fullText.lowercased().range(of: "to")
        let range:Range<String.Index> = Range<String.Index>(uncheckedBounds: (lower: (fi?.upperBound)!, upper: (ti?.lowerBound)!))
        self.fromPlace = fullText.lowercased().substring(with: range)
        self.toPlace  = fullText.lowercased().substring(from: (ti?.upperBound)!)
        
        
    }
    
    func dircTo(arr: String)
    {
            
            var i = fullText.lowercased().range(of: arr)
            self.toPlace = fullText.lowercased().substring(from: (i?.upperBound)!)
    }
 
    func setText(fullText: String)
    {
        self.fullText = fullText    
        parseText(arr: "Something")
        return
    }
    // Setting user request
    func setText1(fullText: String)
    {
        self.fullText = fullText
        //finding if the user wants address between 2 locations or route from current location to destination
        // If user is requesting words in this array then perfom its respective function
        for arr in goarrs {
            
            if (fullText.lowercased().range(of: arr)) != nil{
                dircTo(arr: arr)
                self.status = true
                break
            }
            else{
                self.status = false
            }
        }
        //If the previous condition was not satisfied do the following
        if (self.status == false)
        {
        for arr in arrs {
        
            if (fullText.lowercased().range(of: arr)) != nil{
                parseText(arr: arr)
                self.status = true
                break
            }
            else{
                self.status = false
            }
        }
        }
        

        return
    }
    
    
    
//
//    func findFromCity() -> String
//    {
//        return fromCity
//    }
//    
//    func findToCity() -> String
//    {
//        return toCity
//    }
//    
//    func findFromState() -> String {
//        return fromState
//    }
//    
//    func findToState() -> String {
//        return toState
//    }
//    
//    func findFromZip() -> String {
//        return fromZip
//    }
//    
//    func findToZip() -> String {
//        return toZip
//    }

}
