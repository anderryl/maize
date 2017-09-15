//
//  SmartGroundAI.swift
//  test
//
//  Created by Anderson, Todd W. on 9/11/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class SmartGroundAI: MonsterAI {
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
        return getWeightedDirection(tileX: x, tileY: y, dir: dir)
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
    
    func getWeightedDirection(tileX: Int, tileY: Int, dir: Int) -> Int {
        var possible = [(x: Int, y: Int)]()
        switch (dir + 1) % 4 {
        case 1: possible.append((1, 0))
        case 2: possible.append((0, -1))
        case 3: possible.append((-1, 0))
        default: possible.append((0, 1))
        }
        switch (dir + 3) % 4 {
        case 1: possible.append((1, 0))
        case 2: possible.append((0, -1))
        case 3: possible.append((-1, 0))
        default: possible.append((0, 1))
        }
        switch dir {
        case 1: possible.append((1, 0))
        case 2: possible.append((0, -1))
        case 3: possible.append((-1, 0))
        default: possible.append((0, 1))
        }
        var pos = [(Int, Int)]()
        for entry in possible {
            if (maze[entry.x + tileX][entry.y + tileY] == 0) {
                pos.append((entry.x, entry.y))
            }
        }
        if (pos.count > 0) {
            switch pos[Int(arc4random_uniform(UInt32(pos.count)))] {
            case (1, 0): return 1
            case (0, -1): return 2
            case (-1, 0): return 3
            default: return 0
            }
        }
        return getDirection(tileX: tileX, tileY: tileY)
    }
    
    func getState(x: Int, y: Int) -> UInt8 {
        return maze[x][y]
    }
    
    func getMaze() -> [[UInt8]] {
        return maze
    }
}
