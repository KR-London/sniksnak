//
//  FeedPagePresenter.swift
//  StreamLabsAssignment
//
//  Created by on Jude on 16/02/2019.
//  Copyright © 2019 streamlabs. All rights reserved.
//

import Foundation
import AVFoundation
import ProgressHUD

protocol FeedPagePresenterProtocol: class {
    func viewDidLoad()
    func fetchNextFeed() -> IndexedFeed?
    func fetchPreviousFeed() -> IndexedFeed?
    func updateFeedIndex(fromIndex index: Int)
}

class FeedPagePresenter: FeedPagePresenterProtocol {
    fileprivate unowned var view: FeedPageView
    fileprivate var fetcher: FeedFetchProtocol
    fileprivate var feeds: [Feed] = []
    fileprivate var currentFeedIndex = 0
    
    init(view: FeedPageView, fetcher: FeedFetchProtocol = FeedFetcher()) {
        self.view = view
        self.fetcher = fetcher
    }
    
    func viewDidLoad() {
        fetcher.delegate = self
        configureAudioSession()
        fetchFeeds()
        
    }
    
    func fetchNextFeed() -> IndexedFeed? {
        return getFeed(atIndex: currentFeedIndex + 1)
    }
    
    func fetchPreviousFeed() -> IndexedFeed? {
        return getFeed(atIndex: currentFeedIndex - 1)
    }
    
    func updateFeedIndex(fromIndex index: Int) {
        currentFeedIndex = index
    }
    
    
    fileprivate func configureAudioSession() {
        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
    }
    
    fileprivate func fetchFeeds() {
        view.startLoading()
        fetcher.fetchFeeds()
    }
    
    fileprivate func getFeed(atIndex index: Int) -> IndexedFeed? {
        guard index >= 0 && index < feeds.count else {
            return nil
        }

        return (feed: feeds[index], index: index)
    }
    
    
}




extension FeedPagePresenter: FeedFetchDelegate {
    func feedFetchService(_ service: FeedFetchProtocol, didFetchFeeds feeds: [Feed], withError error: Error?) {
        view.stopLoading()
        if let error = error {
            view.showMessage(error.localizedDescription)
            return
        }
        
        self.feeds = self.initialiseHardCodedFeed()
        
        
        /// our feed is stored in presenter
        //self.feeds = feeds
        
        
        guard let initialFeed = self.feeds.first else {
            view.showMessage("No Availavle Video Feeds")
            return
        }
        view.presentInitialFeed(initialFeed)
    }
    
    
    /// this is an ugly hack . I am placing this in view when it clearly should be model
    func initialiseHardCodedFeed() -> [Feed]{
        
        /// master list of material
        
        /// load a random selection of these (including your own)
        
//        let f1 = Feed(id: 0, url: nil, path: savedContent(filename: "vid1.MOV"))
//        let f2 = Feed(id: 0, url: nil, path: savedContent(filename: "vid2.MP4"))
//        let f3 = Feed(id: 0, url: nil, path: savedContent(filename: "vid3.MP4"))
//        let f4 = Feed(id: 0, url: nil, path: savedContent(filename: "vid4.MP4"))
//        let f5 = Feed(id: 0, url: nil, path: savedContent(filename: "vid5.MOV"))
//        
        //let docsPath = Bundle.main.resourcePath!
        var docsPath = Bundle.main.path(forResource: "vid1", ofType: ".MOV")
        docsPath = String((docsPath?.dropLast(8))!)
        print(docsPath)
        let fileManager = FileManager.default

        var list = [Feed]()
        do {
            let docsArray = try fileManager.contentsOfDirectory(atPath: docsPath!).filter({$0.hasSuffix(".MP4")||$0.hasSuffix(".MOV")})
               
            for i in 0...15{
                /// later include remote video and sti;; images
                let type = ["localVideo", "text"].randomElement()
                print(type)

                switch type{
                    case "localVideo":
                        let vid = Feed(id: i, url: nil, path: savedContent(filename: docsArray.randomElement()!), text: nil)
                        list.append(vid)
                    case "text":
                        let vid = Feed(id: i, url: nil, path: savedContent(filename: ["bac1.mp4", "bac2.mov","background3.mp4", "bac4.mp4", "bac3.mp4"].randomElement()!), text: phrases.randomElement())
                        list.append(vid)
                    default: break // add a placeholder here
                }
                
               /// let vid = Feed(id: i, url: nil, path: savedContent(filename: docsArray.randomElement()!))
                //let vid = Feed(id: i, url: nil, path: savedContent(filename: ["bac1.mp4", "bac2.mov","background3.mp4", "bac4.mp4", "bac3.mp4"].randomElement()! ))
               // list.append(vid)
            }
        }
        catch{
                print("Local video loading failed")
            }
   
        return list
    }
}
