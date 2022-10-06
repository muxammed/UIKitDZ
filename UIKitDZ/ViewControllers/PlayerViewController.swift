//
//  PlayerViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 05.10.2022.
//

import AVFoundation
import UIKit
/// PlayerViewController - модальный viewController который будет проигрывать выбранные трэк
final class PlayerViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var albumCoverContainerView: UIView!
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var playerTimeSlider: UISlider!
    @IBOutlet weak var nextTrackButton: UIButton!
    @IBOutlet weak var prevTrackButton: UIButton!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackNameTopLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    // MARK: - Visual Components
    
    // MARK: - Public Properties
    var audioPlayer = AVAudioPlayer()
    var songs: [Song]?
    var currentTrack = 0
    var isPlaying = false
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    // MARK: - UIViewController(*)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251 / 255, green: 251 / 255, blue: 251 / 255, alpha: 1)
        
        checkNextPrevTracks()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureAudioPlayer()
        
    }
    
    // MARK: - Public methods
    
    @objc func updateTimeAction(_ timer: Timer) {
        playerTimeSlider.value = Float(audioPlayer.currentTime)
        currentTimeLabel.text = "\(audioPlayer.currentTime.minuteSecond)"
        remainingTimeLabel.text = "-\((audioPlayer.duration - audioPlayer.currentTime).minuteSecond)"
    }
    
    fileprivate func setAlphaToZeroTo(to: CGFloat) {
        self.albumCoverContainerView.alpha = to
        self.artistNameLabel.alpha = to
        self.trackNameLabel.alpha = to
        self.trackNameTopLabel.alpha = to
        self.view.layoutIfNeeded()
    }
    
    func configureAudioPlayer() {
        
        if trackNameLabel.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                self.setAlphaToZeroTo(to: 0.0)
            } completion: { _ in
                self.albumCoverImage.image = self.songs?[self.currentTrack].songCoverImage
                self.trackNameLabel.text = self.songs?[self.currentTrack].songName
                self.trackNameTopLabel.text = self.songs?[self.currentTrack].songName
                
                guard let path = Bundle.main.path(forResource: self.songs?[self.currentTrack].songFileName,
                                                  ofType: "mp3") else {
                    print("url not found")
                    return }
                    let url = URL(fileURLWithPath: path)

                    do {
                        try AVAudioSession.sharedInstance().setCategory(
                                    AVAudioSession.Category.playback)

                        try AVAudioSession.sharedInstance().setActive(true)

                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        self.remainingTimeLabel.text = "-\(self.audioPlayer.duration.minuteSecond)"
                        self.playerTimeSlider.maximumValue = Float(self.audioPlayer.duration)
                        self.playerTimeSlider.value = 0.0
                        Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                             selector: #selector(self.updateTimeAction), userInfo: nil, repeats: true)
                        if self.isPlaying {
                            self.audioPlayer.play()
                        }
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                
                self.albumCoverContainerView.backgroundColor = .clear
                self.albumCoverImage.frame = self.albumCoverContainerView.bounds
                self.albumCoverImage.layer.cornerRadius = 10
                self.albumCoverContainerView.dropShadow()
                UIView.animate(withDuration: 0.5, animations: {
                    self.setAlphaToZeroTo(to: 1.0)
                })
            }

        } else {
            self.albumCoverImage.image = self.songs?[self.currentTrack].songCoverImage
            self.trackNameLabel.text = self.songs?[self.currentTrack].songName
            self.trackNameTopLabel.text = self.songs?[self.currentTrack].songName
            
            guard let path = Bundle.main.path(forResource: self.songs?[self.currentTrack].songFileName,
                                              ofType: "mp3") else {
                print("url not found")
                return }
                let url = URL(fileURLWithPath: path)

                do {
                    try AVAudioSession.sharedInstance().setCategory(
                                AVAudioSession.Category.playback)

                    try AVAudioSession.sharedInstance().setActive(true)

                    self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    self.remainingTimeLabel.text = "-\(audioPlayer.duration.minuteSecond)"
                    self.playerTimeSlider.maximumValue = Float(audioPlayer.duration)
                    self.playerTimeSlider.value = 0.0
                    Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                         selector: #selector(self.updateTimeAction), userInfo: nil, repeats: true)
                    if isPlaying {
                        audioPlayer.play()
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            
            self.albumCoverContainerView.backgroundColor = .clear
            self.albumCoverImage.frame = albumCoverContainerView.bounds
            self.albumCoverImage.layer.cornerRadius = 10
            self.albumCoverContainerView.dropShadow()
            UIView.animate(withDuration: 0.5, animations: {
                self.setAlphaToZeroTo(to: 1.0)
            })
        }
    }
    
    // MARK: - IBAction
    @IBAction func playPauseButtonAction(_ sender: UIButton) {
        
        sender.setBackgroundImage(audioPlayer.isPlaying ? UIImage(systemName: "play.fill") :
                                    UIImage(systemName: "pause.fill"), for: .normal)
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            isPlaying = false
        } else {
            audioPlayer.play()
            isPlaying = true
        }
    }
    
    @IBAction func playerSliderAction(_ sender: UISlider) {
        audioPlayer.currentTime = TimeInterval(sender.value)
    }
    
    @IBAction func nextTrackButtonAction(_ sender: Any) {
        if currentTrack == 0 {
            currentTrack += 1
            configureAudioPlayer()
            checkNextPrevTracks()
        }
    }
    
    @IBAction func prevTrackButtonAction(_ sender: Any) {
        if currentTrack == 1 {
            currentTrack -= 1
            configureAudioPlayer()
            checkNextPrevTracks()
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.albumCoverContainerView.alpha = 0
            self.artistNameLabel.alpha = 0
            self.trackNameLabel.alpha = 0
            self.trackNameTopLabel.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let shareItems = ["Зацени песьню \(songs?[currentTrack].songName ?? "")."]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    // MARK: - Private Methods
    fileprivate func checkNextPrevTracks() {
        if currentTrack == 0 {
            prevTrackButton.tintColor = .gray
            nextTrackButton.tintColor = .black
        } else {
            nextTrackButton.tintColor = .gray
            prevTrackButton.tintColor = .black
        }
    }
}

/// расширение для добавления тени вьюхе
extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

/// разширение для перевода секунд в читаемый текст мин:сек
extension TimeInterval {
    var minuteSecond: String {
        String(format: "%d:%02d", minute, second)
    }
    var minute: Int {
        Int((self / 60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
}
