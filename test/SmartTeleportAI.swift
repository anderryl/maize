//
//  SmartTeleportAI.swift
//  test
//
//  Created by Rylie Anderson on 9/14/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
class SmartTeleportAI: TeleportAI {
    var maze: [[UInt8]]
    
    
    required init(maze: [[UInt8]]) {
        self.maze = maze
    }
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int {
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
        
        var coord: (Int, Int, Int) = (0, 0, 0)
        switch dir {
        case 0: coord = (0, 1, 0)
        case 1: coord = (1, 0, 1)
        case 2: coord = (0, -1, 2)
        case 3: coord = (-1, 0, 3)
        default: coord = (0, 1, 0)
        }
        if (maze[coord.0 + x][coord.1 + y] == 0) {
            return coord.2
        }
        else {
            return 4 // 4 means teleport
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
    
    //teleports any open space in a 10 * 10 square chunk
    func teleport(cx: Int, cy: Int, px: Int, py: Int) -> (x: Int, y: Int, d: Int) {
        var x = -5
        var possibles: [(x: Int, y: Int)] = [(x: Int, y: Int)]()
        while x < 5 {
            var y = -5
            while y < 5 {
                if (maze[x + cx][y + cy] == 0) {
                    possibles.append((x: x + cx, y: y + cy))
                }
                y += 1
            }
            x += 1
        }
        let coord = possibles[Int(arc4random_uniform(UInt32(possibles.count)))]
        return (x: coord.x, y: coord.y, d: evaluate(x: coord.x, y: coord.y, px: px, py: py, dir: Int(arc4random_uniform(4))))
    }
    
    func getMaze() -> [[UInt8]] {
        return maze
    }
}
