//
//  StupidIncorporealAI.swift
//  test
//
//  Created by Rylie Anderson on 9/13/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
class StupidIncorporealAI: MonsterAI {
    var maze: [[UInt8]]
    var count: Int = 0
    var cap: Int
    
    required init(maze: [[UInt8]]) {
        self.maze = maze
        cap = Int(arc4random_uniform(9))
    }
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int {
        if (count < cap) {
            return dir
        }
        return Int(arc4random_uniform(4))
    }
    
    func getDirection(tileX: Int, tileY: Int) -> Int {
        return Int(arc4random_uniform(4))
    }
    
    func getState(x: Int, y: Int) -> UInt8 {
        return maze[x][y]
    }
    
    func getMaze() -> [[UInt8]] {
        return maze
    }
}
