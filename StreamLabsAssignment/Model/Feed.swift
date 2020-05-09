//
//  Feed.swift
//  StreamLabsAssignment
//
//  Created by Jude on 16/02/2019.
//  Copyright © 2019 streamlabs. All rights reserved.
//

import Foundation


import Foundation

struct Feed: Decodable {
    
    let id: Int
    let url: URL?
    let path: savedContent?
   
    
}

struct savedContent: Codable{
    var name: String?
    var format: String?
    
    init(filename: String){
        let components = filename.split(separator: ".")
        name = String(components[0])
        format = String(components[1])
    }
}
