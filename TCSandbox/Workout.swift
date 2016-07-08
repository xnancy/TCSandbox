//
//  Workout.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/6/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

class Workout: AnyObject {
    var name: String?
    var movesList: [Move]?
    var ownerID: String?
    
    init() {
        name = ""
        movesList = []
    }
}