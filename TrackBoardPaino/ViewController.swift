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
    var keySet:[NSTextField] = []
    var keyTouched:[Int] = [0,0,0,0,0,0,0]
    var keyMovedTouched:[Int] = [0,0,0,0,0,0,0]
    var moved:Bool = false
    @IBAction func startBtn(_ sender: Any) {
        self.view.wantsRestingTouches = true
//        self.view.acceptsTouchEvents = true
        self.view.allowedTouchTypes = NSTouch.TouchTypeMask.indirect
        keySet.append(key1)
        keySet.append(key2)
        keySet.append(key3)
        keySet.append(key4)
        keySet.append(key5)
        keySet.append(key6)
        keySet.append(key7)
    }
    @IBAction func stopBtn(_ sender: Any) {
        self.view.wantsRestingTouches = false
        self.view.allowedTouchTypes = NSTouch.TouchTypeMask.direct
        for i:Int in 0 ... 6{
            keySet[i].backgroundColor = NSColor.init(calibratedRed: 255, green: 255, blue: 255, alpha: 1)
        }
        
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
            keyTouched[pos-1] = 1
            keyMovedTouched[pos-1] = 1
            keySet[pos-1].backgroundColor = NSColor.init(calibratedRed: 0, green: 0, blue: 0, alpha: 1)
            var soundID : SystemSoundID = 0
            guard let url = Bundle.main.url(forResource: pos.description, withExtension: ".mp3") else {return}
            AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
            AudioServicesPlayAlertSoundWithCompletion(soundID, {
//                   print("end")
            })
        }
    }
    
    override func touchesMoved(with event: NSEvent) {
        let touch = event.touches(matching: NSTouch.Phase.moved, in: self.view)
        for t in touch{
            let p = t.normalizedPosition as NSPoint
            let pos = Int(p.x * 7) + 1
            if(keyMovedTouched[pos-1] == 0){
                moved = true
                keySet[pos-1].backgroundColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 1)
                for i:Int in 0 ... 6{
                    keyMovedTouched[i] = 0
                    if (keyTouched[i] == 0 && i != pos-1){
                        keySet[i].backgroundColor = NSColor(calibratedRed: 255, green: 255, blue: 255, alpha: 1)
                    }
                }
                var soundID : SystemSoundID = 0
                guard let url = Bundle.main.url(forResource: pos.description, withExtension: ".mp3") else {return}
                AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
                AudioServicesPlayAlertSoundWithCompletion(soundID, {
//                    print("end")
                })
                keyMovedTouched[pos-1] = 1
            }
        }
    }
    
    override func touchesEnded(with event: NSEvent) {
//        let touch = event.touches(matching: NSTouch.Phase.began, in: self.view)

        let touch = event.touches(matching: NSTouch.Phase.ended, in: self.view)
//        print(touch.count)
        
        var tmp:[Int] = [0,0,0,0,0,0,0]
        for t in touch{
            let p = t.normalizedPosition as NSPoint
            let pos = Int(p.x * 7) + 1
            tmp[pos-1] = 1
            keyTouched[pos-1] = 0
            keySet[pos-1].backgroundColor = NSColor(calibratedRed: 255, green:255, blue: 255, alpha: 1)
        }
        
        if moved == true{
            moved = false
            for i:Int in 0 ... 6{
                keySet[i].backgroundColor = NSColor(calibratedRed: 255, green:255, blue: 255, alpha: 1)
            }
        }
        
        for i:Int in 0 ... 6{
            if keyMovedTouched[i] == 1{
                for j:Int in 0 ... 6{
                    keyMovedTouched[j] = 0
                }
            }
        }
    }
    
    @IBOutlet weak var key1: NSTextField!
    @IBOutlet weak var key2: NSTextField!
    @IBOutlet weak var key3: NSTextField!
    @IBOutlet weak var key4: NSTextField!
    @IBOutlet weak var key5: NSTextField!
    @IBOutlet weak var key6: NSTextField!
    @IBOutlet weak var key7: NSTextField!
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            
        }
    }
}

