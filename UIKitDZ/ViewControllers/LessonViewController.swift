//
//  LessonViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 03.10.2022.
//

import AVFoundation
import UIKit
/// код из урока № 6
class LessonViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.frame = CGRect(x: 0, y: 0, width: 200, height: 23)
        slider.center = view.center
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        
        do {
            if let audioPath = Bundle.main.path(forResource: "gribi", ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                slider.maximumValue = Float(player.duration)
                
            }
        } catch {
            print("ERROR")
        }
        
        self.player.play()
    }
    
    @IBAction func playButton(_ sender: Any) {
        self.player.play()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        self.player.pause()
    }
    
    @objc func changeSlider(_ sender: UISlider) {
        if sender == slider {
            player.currentTime = TimeInterval(sender.value)
        }
    }
}
