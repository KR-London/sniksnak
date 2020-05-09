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

let phrases = [ "Every bite is a chance to be curious."
          ,"Every sniff is a chance to be curious."
           ,"Every lick is a chance to be curious."
           ,"Buffets: try before you commit."
           ,"Buffets: take tiny tastes of different foods."
            , "Every meal is a fresh start"
          ,"Stay curious!"
             ,"'Normal' eating is different for everyone.",
              "Canned fruits and veg are just as healthy as fresh."
]


class FeedViewController: AVPlayerViewController, StoryboardScene {
    
    static var sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var index: Int!
    fileprivate var feed: Feed!
    fileprivate var isPlaying: Bool!
    var Label = UILabel()
    
    static func instantiate(feed: Feed, andIndex index: Int, isPlaying: Bool = false) -> UIViewController {
        let viewController = FeedViewController.instantiate()
        viewController.feed = feed
        viewController.index = index
        viewController.isPlaying = isPlaying
        
      //  let viewController = UIViewController()
        return viewController
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        


            initializeFeed()
        
        if feed.text == nil{
            Label.isHidden = true
        }
        else{
            Label = UILabel(frame: self.view.frame)
            Label.text = phrases.randomElement()
            self.contentOverlayView?.addSubview(Label)
            Label.textAlignment = .center
            Label.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 70 )
            Label.lineBreakMode = .byWordWrapping
            Label.numberOfLines = 7
            Label.frame.inset(by: UIEdgeInsets(top: 15,left: 15,bottom: 15,right: 15))
            Label.textColor = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)].randomElement()
            view.bringSubviewToFront(Label)
        }
        
        showsPlaybackControls = false
        videoGravity = AVLayerVideoGravity.resizeAspectFill
            
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
        // MARK: I need to bifurcate here to handle the different types of content
        
        let url = feed.url
        let input = feed.path!
        guard let path = Bundle.main.path(forResource: input.name, ofType:input.format) else {
            debugPrint("video not found")
            return
        }

   
   
        
//        guard let path = Bundle.main.path(forResource: "vid1", ofType: "MOV") else {
//                  debugPrint("video not found")
//                  return
//              }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        isPlaying ? play() : nil
        
        //player.
 
    }
}


