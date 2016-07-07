//
//  Challenge.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/7/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation

class Challenge: AnyObject {
    var videoID: String?
    var moves: [Move]?
    var participants: [User]?
    var deadline: NSDate?
    var past: Bool?
}
