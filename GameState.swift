//
//  GameState.swift
//  test
//
//  Created by Anderson, Todd W. on 4/2/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class GameState {
    var level: Int = 0
    var maze: [[UInt8]] = [[UInt8]]()
    
    
    init(level: Int, maze: [[UInt8]]) {
        self.level = level
        self.maze = maze
    }
}
