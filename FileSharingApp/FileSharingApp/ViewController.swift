//
//  ViewController.swift
//  FileSharingApp
//
//  Created by ankit bharti on 14/07/18.
//  Copyright © 2018 Ankit Bharti. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBAction func fetchAudioFiles(_ sender: Any) {
        guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        guard let fileUrls = try? FileManager.default.contentsOfDirectory(atPath: documentURL.path) else { return }
        let audioFiles = fileUrls.filter { $0.hasSuffix("mp3") }
        let audioFileURLs = audioFiles.map {
            documentURL.appendingPathComponent($0)
        }
        
        print(audioFileURLs)
        guard let url = audioFileURLs.first else { return }
        playSongs(url: url)
    }
    
    private func playSongs(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let player = try AVAudioPlayer(data: data)
            player.volume = 1.0
            player.prepareToPlay()
            player.play()
        }catch {
            print("couldn't play")
        }
    }
}

