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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func recordAction(_ sender: Any) {
        print("button is clicked")
        recordingLabel.text = "Recording..."
    }
    
    @IBAction func stopRecordAction(_ sender: Any) {
        recordingLabel.text = "Press to Record"
    }
}

