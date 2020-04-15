//
//  ViewController.swift
//  Xylophone
//
//  Created by Claudia Cavalini Maganhi on 14/04/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonStyle()
    }
    
    @IBAction func playNote(_ sender: UIButton) {
        animateButton(sender)
        playSound(soundNote: sender.titleLabel?.text ?? "")
    }
    
    private func setButtonStyle() {
        buttonCollection.forEach { $0.layer.cornerRadius = 30 }
        buttonCollection.forEach { $0.layer.masksToBounds = true }
    }
    
    private func playSound(soundNote: String) {
        guard let url = Bundle.main.url(forResource: soundNote, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func animateButton(_ button: UIButton) {
        button.alpha = 0.5
        UIView.animate(withDuration: 0.5) {
            button.alpha = 1
        }
    }
    
}

