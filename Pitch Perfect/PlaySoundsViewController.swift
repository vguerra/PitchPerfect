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

    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playWithRateAndPitch(rate: 0.6)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playWithRateAndPitch(rate: 2.0)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playWithRateAndPitch(pitch: 1000)
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playWithRateAndPitch(pitch: -1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudioEngine()
    }
    
    @IBAction func playReverb(sender: UIButton) {
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbNode.wetDryMix = 80.0
        
        playAudioWithNodeEffect(reverbNode);
    }
    
    @IBAction func playDelay(sender: UIButton) {
        let delayNode = AVAudioUnitDelay()
        delayNode.delayTime = 0.5

        playAudioWithNodeEffect(delayNode)
    }
    
    @IBAction func playDistortion(sender: UIButton) {
        let distortionNode = AVAudioUnitDistortion()
        distortionNode.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiBrokenSpeaker)
        distortionNode.wetDryMix = 50.0
        
        playAudioWithNodeEffect(distortionNode)
    }
    
    func playWithRateAndPitch(rate: Float = 1.0, pitch: Float = 1.0) {
        let withRatePitchNode = AVAudioUnitTimePitch()
        withRatePitchNode.rate = rate
        withRatePitchNode.pitch = pitch
        
        playAudioWithNodeEffect(withRatePitchNode)

    }
    func playAudioWithVariablePitch(pitch: Float) {
        let changePitchNode = AVAudioUnitTimePitch()
        changePitchNode.pitch = pitch
        
        playAudioWithNodeEffect(changePitchNode)
    }
    
    func playAudioWithNodeEffect(audioNodeEffect: AVAudioNode) {
        stopAudioEngine()
        
        let playerNode = AVAudioPlayerNode()
        audioEngine.attachNode(playerNode)
        
        audioEngine.attachNode(audioNodeEffect)
        
        audioEngine.connect(playerNode, to: audioNodeEffect, format: nil)
        audioEngine.connect(audioNodeEffect, to: audioEngine.outputNode, format: nil)
        
        playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        playerNode.play()
    }
    
    func stopAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
}
