//
//  FeedViewController.swift
//  StreamLabsAssignment
//
//  Created by Jude on 16/02/2019.
//  Copyright © 2019 streamlabs. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class FeedViewController: AVPlayerViewController, StoryboardScene {
    
    static var sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var index: Int!
    fileprivate var feed: Feed!
    fileprivate var isPlaying: Bool!
    
    static func instantiate(feed: Feed, andIndex index: Int, isPlaying: Bool = false) -> UIViewController {
        let viewController = FeedViewController.instantiate()
        viewController.feed = feed
        viewController.index = index
        viewController.isPlaying = isPlaying
        return viewController
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFeed()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    
    fileprivate func initializeFeed() {
       // let url = feed.url
        let input = feed.path!
        guard let path = Bundle.main.path(forResource: input.name, ofType:input.format) else {
            debugPrint("video not found")
            return
        }
        
//        guard let path = Bundle.main.path(forResource: "vid1", ofType: "mp4") else {
//                  debugPrint("video not found")
//                  return
//              }
//        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        isPlaying ? play() : nil
    }
}


