//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// Экран с Таймером запуск пауза и отмена
class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Public Properties
    var timer = Timer()
    var seconds = 0.00
    var isTimerRunnig = false
    var timeInterval = 0.1
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
    }
    
    // MARK: - Public methods
    @objc func timerTik(_ sender: Timer) {
        seconds += timeInterval
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let roundedMilliseconds = Double(round(1000 * time) / 1000)
        let milliseconds = Int("\(roundedMilliseconds)".split(separator: ".")[1])
        
        return String(format: "%02i:%02i:%02i.%1i", hours, minutes, seconds, milliseconds ?? 0)
    }
    
    @IBAction func startPauseAction(_ sender: UIButton) {
        
        if isTimerRunnig {
            timer.invalidate()
            isTimerRunnig = false
            sender.setTitle("Start", for: .normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerTik),
                                         userInfo: nil, repeats: true)
            isTimerRunnig = true
            sender.setTitle("Pause", for: .normal)
        }
        
    }
    
    @IBAction func stopAction(_ sender: Any) {
        timer.invalidate()
        isTimerRunnig = false
        seconds = 0
        timeLabel.text = "00:00:00.0"
    }
}
