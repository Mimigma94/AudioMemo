//
//  Utility.swift
//  AudioMemo
//
//  Created by Selina Kröcker on 20.08.18.
//  Copyright © 2018 Selina Piper. All rights reserved.
//

import Foundation
import AVFoundation

class Utility {
    
    private static func getDocumentDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    static func getAudioRecorder() -> AVAudioRecorder? {
        var audioRecorder: AVAudioRecorder?
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        if audioSession.responds(to: #selector(AVAudioSession.requestRecordPermission(_:))) {
            AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                if granted {
                    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try! audioSession.setActive(true)
                    
                    guard let documentsDirectory = getDocumentDirectory() else {
                        return
                    }
                    let url = documentsDirectory.appendingPathComponent("mysound.caf")
                    
                    let settings: [String: Any] = [
                        AVFormatIDKey: Int(kAudioFormatAppleIMA4),
                        AVSampleRateKey: 441000.0,
                        AVNumberOfChannelsKey: 2,
                        AVEncoderBitRateKey: 12800,
                        AVLinearPCMBitDepthKey: 16,
                        AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
                    ]
                    
                    do {
                        audioRecorder = try AVAudioRecorder(url: url, settings: settings)
                    } catch {
                        print("Could not initialise Recorder")
                    }
                    
                } else {
                    print("User denied access")
                }
            })
        }
        return audioRecorder
    }
    
}
