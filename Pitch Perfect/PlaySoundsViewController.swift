//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Taiowa Waner on 3/15/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: - Outlets/Vars
    
    var player: AVAudioPlayer?
    var file = "movie_quote"
    var receivedAudio: RecordedAudio?
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var error: NSError? = nil
        self.player = AVAudioPlayer(contentsOfURL: receivedAudio?.filePathURL, error: &error)
        self.player?.enableRate = true
        
        self.audioEngine = AVAudioEngine()
        self.audioFile = AVAudioFile(forReading: receivedAudio?.filePathURL, error: &error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBActions
    
    @IBAction func slowButtonTapped(sender: UIButton) {
        playAudio(0.5, reset: true)
    }
    
    @IBAction func fastButtonTapped(sender: UIButton) {
        playAudio(1.5, reset: true)
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        self.player?.stop()
    }
    
    @IBAction func playChipmunkTapped(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthButtonTapped(sender: UIButton) {
        
    }

    // MARK: - Helper methods
    
    func playAudio(speed: Float, reset:Bool){
        self.player?.stop()
        if reset {
            self.player?.currentTime = 0.0
        }
        self.player?.rate = speed
        self.player?.play()

    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        self.player?.stop()
        self.audioEngine.stop()
        self.audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        self.audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        self.audioEngine.attachNode(changePitchEffect)
        
        self.audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        self.audioEngine.connect(changePitchEffect, to: self.audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        self.audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
