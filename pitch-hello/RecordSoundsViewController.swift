//
//  RecordSoundsViewController.swift
//  pitch-hello
//
//  Created by rnd on 20/1/19.
//  Copyright © 2019 everdimensiondev. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    enum State {
        case recording
        case notRecording
    }
    
    var state = State.notRecording

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setState(newState: State.notRecording)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setState(newState: State) {
        state = newState
        self.update(state: state)
    }
    
    func update(state: State) {
        switch state {
        case .recording:
            recordingLabel.text = "Recording..."
            recordButton.isEnabled = false
            stopRecordingButton.isEnabled = true
        case .notRecording:
            recordingLabel.text = "Press to Record"
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        }
    }

    @IBAction func recordAction(_ sender: Any) {
        self.setState(newState: State.recording)
        
        // Start recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(
                AVAudioSession.Category.playAndRecord,
                mode: AVAudioSession.Mode.default,
                options: AVAudioSession.CategoryOptions.defaultToSpeaker
            )
            print("did set category")
            session.requestRecordPermission() { [] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("recording is allowed")
                    } else {
                        print("recording is not allowed")
                    }
                }
            }
        } catch {
            print("error setting category")
        }

        do {
            try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("error making audooRecorder")
        }
    }
    
    @IBAction func stopRecordAction(_ sender: Any) {
        self.setState(newState: State.notRecording)
        
        // Stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        print("done recording")
        print(audioRecorder.url)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let destinationController = segue.destination as! PlaySoundsViewController
            destinationController.getPrepared(sender: sender as! URL)
        }
    }
}

