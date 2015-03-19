//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Taiowa Waner on 3/17/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathURL: NSURL!
    var title: String!
    
    init(filePathURL: NSURL, title: String) {
        self.filePathURL = filePathURL
        self.title = title
    }
}