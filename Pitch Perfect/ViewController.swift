//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Taiowa Waner on 3/14/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets and Props
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom work

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        stopButton.enabled = false
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recoding in progress"
        //TODO: Record the user's voice
        println("In recoding")
        recordingLabel.hidden = false
        recordingLabel.text =  "Recording in Progress"
        stopButton.hidden = false
        recordButton.enabled = false
    }

    @IBAction func stopRecodingTapped(sender: UIButton) {
        recordingLabel.hidden = true
        recordingLabel.text =  "Press to Record"
        stopButton.hidden = true
        recordButton.enabled = true
    }
}

