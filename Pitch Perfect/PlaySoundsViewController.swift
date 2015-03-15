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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var fileLocation = NSBundle.mainBundle().pathForResource(file, ofType: "mp3")
        var error: NSError? = nil
//        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation!), error: &error)
        
        
        if var filePath = NSBundle.mainBundle().pathForResource(file, ofType: "mp3") {
            var filePathURL = NSURL.fileURLWithPath(filePath)
            self.player = AVAudioPlayer(contentsOfURL: filePathURL, error: &error)
            self.player?.enableRate = true
        } else {
            println("Path is empty")
        }

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

    // MARK: - Helper methods
    
    func playAudio(speed: Float, reset:Bool){
        self.player?.stop()
        if reset {
            self.player?.currentTime = 0.0
        }
        self.player?.rate = speed
        self.player?.play()

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
