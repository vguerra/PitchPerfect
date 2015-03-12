//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Victor Guerra on 10/03/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
        recordingLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // TODO: Record users voice
        println("in Recording audio")
        println("Recording...")
        
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }

    @IBAction func stopRecordAudio() {
        // TODO: Stop recording voice
        // recordingLabel.hidden = true
        // recordButton.enabled = true
    }
}

