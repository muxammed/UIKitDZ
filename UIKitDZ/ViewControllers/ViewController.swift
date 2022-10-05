//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// ViewController - основной где захардкоден список из двух песен
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(firstSongTapped))
        firstSong.addGestureRecognizer(tapOne)
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(secondSongTapped))
        secondSong.addGestureRecognizer(tapTwo)
        loadDummyData()
    }

    // MARK: - IBOutlet
    @IBOutlet weak var firstSong: UIView!
    @IBOutlet weak var secondSong: UIView!
    // MARK: - Visual Components

    // MARK: - Public Properties
    var songs: [Song] = []

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - UIViewController(*)

    // MARK: - Public methods
    @objc func firstSongTapped() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let playerViewController = storyboard.instantiateViewController(withIdentifier: "playerVC")
            as? PlayerViewController {
            playerViewController.songs = songs
            playerViewController.currentTrack = 0
            self.present(playerViewController, animated: true, completion: nil)
        }
        
    }
    
    @objc func secondSongTapped() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let playerViewController = storyboard.instantiateViewController(withIdentifier: "playerVC")
            as? PlayerViewController {
            playerViewController.songs = songs
            playerViewController.currentTrack = 1
            self.present(playerViewController, animated: true, completion: nil)
        }
        
    }
    
    func loadDummyData() {
        let songone = Song(songName: "Behind Your Eyes",
                           songArtist: "Limp Bizkit",
                           songCoverImage: UIImage(named: "albumone") ?? UIImage(),
                           songFileName: "songone")
        let songtwo = Song(songName: "My Generation",
                           songArtist: "Limp Bizkit",
                           songCoverImage: UIImage(named: "albumtwo") ?? UIImage(),
                           songFileName: "songtwo")
        songs.append(songone)
        songs.append(songtwo)
    }

    // MARK: - IBAction
    
    // MARK: - Private Methods

    // MARK: - Types
    
    // MARK: - Constants

}
