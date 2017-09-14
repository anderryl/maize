//
//  StupidGroundAI.swift
//  test
//
//  Created by Rylie Anderson on 9/13/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class StupidGroundAI: MonsterAI {
    var maze: [[UInt8]]
    
    
    required init(maze: [[UInt8]]) {
        self.maze = maze
    }
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int {
        var coord: (Int, Int, Int) = (0, 0, 0)
        switch dir {
        case 0: coord = (0, 1, 0)
        case 1: coord = (1, 0, 1)
        case 2: coord = (0, -1, 2)
        case 3: coord = (-1, 0, 3)
        default: coord = (0, 0, 6)
        }
        if (maze[coord.0 + x][coord.1 + y] == 0) {
            return coord.2
        }
        else {
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
            return getDirection(tileX: x, tileY: y)
        }
    }
    
    func getDirection(tileX: Int, tileY: Int) -> Int {
        var possible = [Int]()
        var count: UInt32 = 0
        if (getState(x: tileX, y: tileY + 1) == 0) {
            possible.append(0)
            count += 1
        }
        if (getState(x: 1 + tileX, y: tileY) == 0) {
            possible.append(1)
            count += 1
        }
        if (getState(x: tileX, y: tileY - 1) == 0) {
            possible.append(2)
            count += 1
        }
        if (getState(x: tileX - 1, y: tileY) == 0) {
            possible.append(3)
            count += 1
        }
        let index = Int(arc4random_uniform(count))
        return possible[index]
    }
    
    func getState(x: Int, y: Int) -> UInt8 {
        return maze[x][y]
    }
    
    func getMaze() -> [[UInt8]] {
        return maze
    }
}
