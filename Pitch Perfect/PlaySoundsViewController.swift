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
    /// The Audio Engine used to play Audio File + Effects
    var audioEngine: AVAudioEngine!
    /// The Audio file object we receive from the Recording Screen
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        playWithRateAndPitch(rate: 0.7)
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
    
    @IBAction func playReverb(sender: UIButton) {
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbNode.wetDryMix = 80.0
        
        playAudioWithNodeEffect(reverbNode);
    }

    @IBAction func playDelay(sender: UIButton) {
        let delayNode = AVAudioUnitDelay()
        delayNode.delayTime = 0.3
        
        playAudioWithNodeEffect(delayNode)
    }

    @IBAction func stopAudio(sender: UIButton) {
        stopAudioEngine()
    }
    
    /*!
        Apply all effects to audio that modify its rate and pitch values.
        
        @param rate Rate value the effect should apply. 1.0 by default.
        @param pitch Pitch value the effect should apply. 1.0 by default.
    */
    func playWithRateAndPitch(rate: Float = 1.0, pitch: Float = 1.0) {
        let withRatePitchNode = AVAudioUnitTimePitch()
        withRatePitchNode.rate = rate
        withRatePitchNode.pitch = pitch
        
        playAudioWithNodeEffect(withRatePitchNode)
    }

    /*!
        Plays the audio file specified by the audioFile property with a given audio effect.
        @param: audioNodeEffect The desired audio node effect that is used to stream the audio file through
    */
    func playAudioWithNodeEffect(audioNodeEffect: AVAudioNode) {
        stopAudioEngine()
        
        let playerNode = AVAudioPlayerNode()
        audioEngine.attachNode(playerNode)
        
        audioEngine.attachNode(audioNodeEffect)
        
        // we proceed to make the proper node connections.
        audioEngine.connect(playerNode, to: audioNodeEffect, format: nil)
        audioEngine.connect(audioNodeEffect, to: audioEngine.outputNode, format: nil)
        
        playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        playerNode.play()
    }
    
    /// Stops and resets the Audio Engine.
    func stopAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
}
