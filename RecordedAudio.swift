//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Victor Guerra on 15/03/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import Foundation

/// MARK: Printable

/*! 
    Represents a file recorded
*/

class RecordedAudio: NSObject {
    
    /*! 
        Audio file URL
    */
    var filePathUrl: NSURL
    /*! 
        Audio file title
    */
    var title: String
    
    /*! 
        Initialises an object with a given path URL and title
        @param filePathURL A NSURL object indicating the path of the audio file
        @param titlea The audio file title
    */
    init(filePathUrl:NSURL, title:String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}