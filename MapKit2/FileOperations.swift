//
//  FileOperations.swift
//  MapKit2
//
//  Created by Sheshagiri Haniyur on 11/30/16.
//  Copyright © 2016 Sheshagiri Haniyur. All rights reserved.
//

import UIKit

//File Operation
let Folder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
let FileName = "/myLocationFile"
let FilePath = Folder + FileName
let readFile:String = ""


//End of File Operation

class FileOperations: NSObject {
    
//    var data:String = ""
    
    
    func saveData(data:String)
    {
//        self.data = data
        let fileManager = FileManager.default
        
        if(!fileManager.fileExists(atPath: FilePath))
        {
            do {
                try data.write(toFile: FilePath, atomically: true, encoding: String.Encoding.utf8)
                
            }
            catch let error as NSError{print("Error: \(error.domain) . Could not write to the file")}
            
        }
        else
        {
            
            appendData(data)
        }
        
    
    }
    
    private func appendData(_ data:String){
        let data = data
        
        let uText = data.data(using: String.Encoding.utf8)
        let fileHandle = FileHandle(forUpdatingAtPath: FilePath)
        fileHandle?.seekToEndOfFile()
        fileHandle?.write(uText!)
        fileHandle?.closeFile()
        print("New Records Appended to file : \(FilePath)")
        
    }
    
    private func getCurrDate() ->String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy, HH:mm a"
        return dateFormatter.string(from: date)
    }


}
