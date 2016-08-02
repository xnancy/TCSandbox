//
//  cellContents.swift
//  TCSandbox
//
//  Created by Jose Rodriguez Quinones on 7/27/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class cellContents: NSObject
{
    var challenge: Challenge?
    var participants: [String]?
    var participantPictures: [String]?
    var currentParticipant: String?
    var currentName: String?
    var url: NSURL?
    var senderName: String?
    var playerItem: AVPlayerItem?
    
    override init()
    {
    }
}
