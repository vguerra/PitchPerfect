//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Victor Guerra on 12/03/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(2.0)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        stopAudioEngine()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        stopAudioEngine()
        var playerNode = AVAudioPlayerNode()
        audioEngine.attachNode(playerNode)

        var changePitchNode = AVAudioUnitTimePitch()
        changePitchNode.pitch = pitch
        audioEngine.attachNode(changePitchNode)
        
        audioEngine.connect(playerNode, to: changePitchNode, format: nil)
        audioEngine.connect(changePitchNode, to: audioEngine.outputNode, format: nil)
        
        playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        playerNode.play()
    
    }
    func playAudio(atRage: Float) {
        audioPlayer.stop()
        stopAudioEngine()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = atRage
        audioPlayer.play()
    }
    
    func stopAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
}
