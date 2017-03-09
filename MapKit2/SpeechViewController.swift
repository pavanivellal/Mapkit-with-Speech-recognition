//
//  SpeechViewController.swift
//  MapKit2
//
//  Created by Sheshagiri Haniyur on 11/26/16.
//  Copyright © 2016 Sheshagiri Haniyur. All rights reserved.
//

import UIKit
import Speech
import CoreLocation


@available(iOS 10.0, *)
class SpeechViewController: UIViewController,SFSpeechRecognizerDelegate {
    

    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var micButton1: UIButton!
    @IBOutlet weak var speechText: UITextView!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var sp = speechParsing()
    var fullText:String = ""
    var locationManager: CLLocationManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MapKit Speech"
        
        micButton.isEnabled = false
        micButton1.isEnabled = false
        

        
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.micButton.isEnabled = isButtonEnabled
                self.micButton1.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    @IBAction func onMicTap(_ sender: AnyObject) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            micButton.isEnabled = false
            let image1 = UIImage(named: "openmic") as UIImage?
            micButton.setImage(image1, for: UIControlState.normal)
        } else {
            startRecording()
            let image2 = UIImage(named: "closemic") as UIImage?
            micButton.setImage(image2, for: UIControlState.normal)
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                
                self.speechText.text = result?.bestTranscription.formattedString  //9
                self.fullText = (result?.bestTranscription.formattedString)!
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.micButton.isEnabled = true
                self.micButton1.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        speechText.text = "Say something, I'm listening!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            micButton.isEnabled = true
            micButton1.isEnabled = true
        } else {
            micButton.isEnabled = false
            micButton1.isEnabled = false
        }
    }
    
    
    @IBAction func onMicTap1(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            micButton1.isEnabled = false
            micButton1.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            micButton1.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func formatCustomMessage(message: String) -> String {
        return ""
    }
    
    func openMaps()
    {
        self.fullText = "find directions from fremont California to LA California"
        //self.sp.setText1(fullText: (self.fullText))
        var saveFile = FileOperations()
        if self.sp.fromPlace.isEmpty {
            saveFile.saveData(data: "From My Current Location to \(self.sp.toPlace)/n")
        }
        else{
            saveFile.saveData(data: "From \(self.sp.fromPlace) Location to \(self.sp.toPlace)/n")
        }
        
        //self.sp.setText1(fullText: "directions from San Jose California to San Francisco California")
        //self.sp.setText1(fullText: "find directions from san jose state university to Levis Stadium")


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let MapVC2 = segue.destination as? SecondViewController{
            self.openMaps()
            print(self.sp.fromPlace)
            print(self.sp.toPlace)
            MapVC2.sourceAddress = self.sp.fromPlace
            MapVC2.destAddress = self.sp.toPlace
        }
        
        if let MapVC3 = segue.destination as? ThirdViewController{
            self.openMaps()
            print(self.sp.fromPlace)
            print(self.sp.toPlace)
            MapVC3.sourceAddress = self.sp.fromPlace
            MapVC3.destAddress = self.sp.toPlace
        }
        
    }
    
    


}
