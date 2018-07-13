//
//  UIStreamingView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 10..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import AVKit
//import AVFoundation

class UIStreamingView: UIView {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var avPlayerViewController: AVPlayerViewController!
    var avPlayerLayer: AVPlayerLayer!
    var isEndPlaying: Bool = false
    var urlData: URL!
    
    func initAVKit(url: String) {
        self.urlData = URL(string: url)!
        print("av kit url: \(url)")
        
        self.thumbnailImageView.isHidden = false
        self.thumbnailImageView.image = nil
        
        AlamoUtil.loadThumbnail(url: url) { (image) in
            self.thumbnailImageView.image = image
        }
        
        
        if self.avPlayerViewController == nil {
            self.avPlayerViewController = AVPlayerViewController()
            self.avPlayerLayer = AVPlayerLayer()
            self.avPlayerLayer.frame = self.bounds
            self.layer.insertSublayer(self.avPlayerLayer, at: 0)
        }
        self.avPlayerViewController.player = AVPlayer(url: self.urlData)
        self.avPlayerLayer.player = nil
        self.isEndPlaying = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayerViewController.player?.currentItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidStopPlaying), name: NSNotification.Name.AVPlayerViewControllerDismissingNotification, object: nil)
    }
    
    func playeVideoToAVPlayer(viewController: UIViewController) {
        
        self.thumbnailImageView.isHidden = true
        
        viewController.present(self.avPlayerViewController, animated: true) {
            
            if self.isEndPlaying {
                self.avPlayerViewController.player!.replaceCurrentItem(with: AVPlayerItem(url: self.urlData))
                self.avPlayerLayer.player = nil
                self.isEndPlaying = false
            }
            else {
                if self.avPlayerLayer.player != nil {
                    print("asd")
                    self.avPlayerViewController.player = self.avPlayerLayer.player
                }
                self.avPlayerLayer.player = nil
            }
            
            self.avPlayerViewController.player!.play()
        }
    }
    
    @objc func playerDidStopPlaying(note: NSNotification) {
        self.avPlayerLayer.player = self.avPlayerViewController.player
        print("dismiss view")
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.avPlayerViewController.dismiss(animated: true)
        self.avPlayerLayer.player = self.avPlayerViewController.player
        self.isEndPlaying = true
        self.thumbnailImageView.isHidden = false
    }
}
