//
//  ViewController.swift
//  pitch-hello
//
//  Created by rnd on 20/1/19.
//  Copyright © 2019 everdimensiondev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
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
    }
    
    @IBAction func stopRecordAction(_ sender: Any) {
        self.setState(newState: State.notRecording)
    }
}

