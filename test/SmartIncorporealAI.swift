//
//  IncorporealAI.swift
//  test
//
//  Created by Rylie Anderson on 9/13/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
class SmartIncorporealAI: MonsterAI {
    var maze: [[UInt8]]
    
    
    required init(maze: [[UInt8]]) {
        self.maze = maze
    }
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int {
        if (maze[x][y] == 0) {
            if (x == px) {
                var c = 0
                if (py > y) {
                    c = 1
                }
                else {
                    c = -1
                }
                var index: Int = 0
                while (getState(x: x, y: index + y) == 0 && index != py - y) {
                    index += c
                }
                if (index == py - y) {
                    if (py > y) {
                        return 0
                    }
                    else {
                        return 2
                    }
                }
            }
            if (y == py) {
                var c = 0
                if (px > x) {
                    c = 1
                }
                else {
                    c = -1
                }
                var index: Int = 0
                while (getState(x: index + x, y: y) == 0 && index != px - x) {
                    index += c
                }
                if (index == px - x) {
                    if (px > x) {
                        return 1
                    }
                    else {
                        return 3
                    }
                }
            }
        }
        return dir
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
