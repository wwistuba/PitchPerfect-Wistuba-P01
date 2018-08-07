//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Wilson Wistuba on 30/07/2018.
//  Copyright © 2018 Wistuba. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable button before start record
        self.stopRecordingButton.isEnabled = false
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("PitchPerfect receive a warning memory....")
        // Dispose of any resources that can be recreated.
    }


    @IBAction func stopRecording(_ sender: Any) {
        print("stop recording was button pressed")
        self.stopRecordingButton.isEnabled = false
        self.recordButton.isEnabled = true
        self.recordingLabel.text = "Tap top Record"
        
        //Finish Auddio
        self.audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false);
    }
    
    
    @IBAction func recordAudio(_ sender: Any) {
        print("record button pressed")
        self.stopRecordingButton.isEnabled = true
        self.recordButton.isEnabled = false
        self.recordingLabel.text = "Recording in Progress..."
    
        
        //Record some audio using hardcoded settings
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        print("The audio file is in: \(filePath)")
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if(flag){
            self.performSegue(withIdentifier: "stopRecordingSegue", sender: self.audioRecorder.url)
            print("Finish recording....")
        }else{
             print("Not working to record....")
        }
        
    }
}
