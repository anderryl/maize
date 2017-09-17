//
//  File.swift
//  test
//
//  Created by Rylie Anderson on 9/14/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
class StupidTeleportAI: TeleportAI {
    var maze: [[UInt8]]
    var count: Int = 0
    let cap: Int = 9
    
    required init(maze: [[UInt8]]) {
        self.maze = maze
    }
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int {
        if (count >= cap) {
            count = 0
            return 4
        }
        count += 1
        return 5
        }
    
    //teleports any open space in a 10 * 10 square chunk
    func teleport(cx: Int, cy: Int, px: Int, py: Int) -> (x: Int, y: Int, d: Int) {
        var x = -1
        var possibles: [(x: Int, y: Int)] = [(x: Int, y: Int)]()
        while x < 1 {
            var y = -1
            while y < 1 {
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
