//
//  ViewController.swift
//  Wristlight
//
//  Created by Michał Bażyński on 2/8/16.
//  Copyright © 2016 Michał Bażyński. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var flashButton: UIButton!
    
    @IBAction func toggleFlashlight(sender: UIButton) {
        let flashLight = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (!flashLight.torchAvailable || !flashLight.isTorchModeSupported(.On)) {
            return
        }
        do {
            try flashLight.lockForConfiguration()
            if (flashLight.torchMode == .On) {
                flashLight.torchMode = .Off
                flashButton.setTitle("Turn Phone Flashlight On", forState: .Normal)
            } else {
                flashLight.torchMode = .On
                flashButton.setTitle("Turn Phone Flashlight Off", forState: .Normal)
            }
        } catch {
            print("could not toggle flashlight")
        }
    }
}

