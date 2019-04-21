//
//  ViewController.swift
//  TrackBoardPaino
//
//  Created by Feng Qiu on 2019/3/30.
//  Copyright © 2019 Feng Qiu. All rights reserved.
//

import Cocoa
import AppKit
import AVFoundation

class ViewController: NSViewController {
    
    @IBAction func startBtn(_ sender: Any) {
        self.view.wantsRestingTouches = true
//        self.view.acceptsTouchEvents = true
        self.view.allowedTouchTypes = NSTouch.TouchTypeMask.indirect
    }
    @IBAction func stopBtn(_ sender: Any) {
        self.view.wantsRestingTouches = false
        self.view.allowedTouchTypes = NSTouch.TouchTypeMask.direct
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(with event: NSEvent) {
        let touch = event.touches(matching: NSTouch.Phase.began, in: self.view)
        for t in touch{
            let p = t.normalizedPosition as NSPoint
            let pos = Int(p.x * 7) + 1
            print(pos)
            var soundID : SystemSoundID = 0
            guard let url = Bundle.main.url(forResource: pos.description, withExtension: ".mp3") else {return}
            AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
            AudioServicesPlayAlertSoundWithCompletion(soundID, {
                print("end")
            })
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            
        }
    }
}

