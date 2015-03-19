//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Taiowa Waner on 3/14/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Outlets and Props
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var paused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // Update UI
        recordingLabel.text =  "Recording in Progress"
        stopButton.hidden = false
        recordButton.enabled = false
        pauseButton.hidden = false
        restartButton.hidden = false
        
        // Prep and record
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }

    @IBAction func stopRecodingTapped(sender: UIButton) {
        // UI Prep
        self.resetButtons()
        
        // Audio Work
        self.audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    @IBAction func pauseButtonTapped(sender: UIButton) {
        // Pause recording. Leave other buttons visible; change text; update paused var
        
        if !paused {
            self.audioRecorder.pause()
            self.recordingLabel.text = "Paused. Tap Pause To Continue Recording."
            self.paused = true
        } else {
            self.audioRecorder.record()
            self.recordingLabel.text = "Recording in Progress"
            self.paused = false
        }
        
    }
    
    
    @IBAction func restartButtonTapped(sender: UIButton) {
        // Stop recording; hide buttons; enable record; change text
//        self.audioRecorder.stop()
        self.audioRecorder.deleteRecording()
        
        self.resetButtons()
    }
    
    // MARK: - AVAudioRecorderDelegate
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if flag {
            recordedAudio = RecordedAudio(filePathURL: recorder.url, title: recorder.url.lastPathComponent!)
            
            self.performSegueWithIdentifier("stopRecodingSegue", sender: recordedAudio)
        } else {
            println("Recording not finished")
            stopButton.hidden = true
            recordButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "stopRecodingSegue" {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
            pauseButton.hidden = true
            restartButton.hidden = true
        }
    }
    
    // MARK: - Helper funcs
    
    func resetButtons(){
        recordingLabel.text =  "Tap to Record"
        stopButton.hidden = true
        recordButton.enabled = true
        pauseButton.hidden = true
        restartButton.hidden = true
    }
}

