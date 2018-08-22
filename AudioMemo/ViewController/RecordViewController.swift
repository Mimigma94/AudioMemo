//
//  RecordViewController.swift
//  AudioMemo
//
//  Created by Selina Kröcker on 16.08.18.
//  Copyright © 2018 Selina Piper. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {

    //--------------------------------------------------
    // MARK: - IBOutlet
    //--------------------------------------------------
    
    @IBOutlet weak var informationLabel: UILabel!
    
    //--------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------
    
    var audioRecorder: AVAudioRecorder?
    var accessGranted = false
    
    //--------------------------------------------------
    // MARK: - Lifecycle
    //--------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAudioRecorder()
    }
    
    //--------------------------------------------------
    // MARK: - IBActions
    //--------------------------------------------------
    
    @IBAction func recordButtonTouchDown(_ sender: UIButton) {
        if accessGranted {
            startRecording()
            updateInformationLabel(recording: true)
        } else {
            showAccessAlert()
        }
    }
    
    @IBAction func recordButtonTouchUpInside(_ sender: UIButton) {
        guard accessGranted else { return }
        stopRecording()
        updateInformationLabel(recording: false)
    }
    
    @IBAction func recordButtonTouchUpOutside(_ sender: UIButton) {
        guard accessGranted else { return }
        stopRecording()
        updateInformationLabel(recording: false)
    }
    
    //--------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------
    
    func updateInformationLabel(recording: Bool) {
        if recording {
            informationLabel.text = "Recording..."
            informationLabel.textColor = UIColor.red
        } else {
            informationLabel.text = "Hold Button To Record"
            informationLabel.textColor = UIColor.white
        }
    }
    
    func startRecording() {
        print("Starting recording...")
        audioRecorder?.record()
    }
    
    func stopRecording() {
        print("Stopped recording")
        audioRecorder?.stop()
    }
    
    func showAccessAlert() {
        let title = "No Access To Microphone"
        let message = "Please allow AudioMemo access to the microphone in your settings"
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    func setupAudioRecorder() {
        if let audioRecorder = Utility.getAudioRecorder() {
            self.audioRecorder = audioRecorder
            self.audioRecorder!.delegate = self
            accessGranted = true
        } else {
            print("User denied access")
        }
    }
}


extension RecordViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Everything is ok")
            if let saveViewController =
                storyboard?.instantiateViewController(withIdentifier: "SaveViewController") as? SaveViewController {
                present(saveViewController, animated: true, completion: nil)
            }
        } else {
            print("Error during recording")
        }
    }
    
}
