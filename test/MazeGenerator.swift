//
//  MazeGenerator.swift
//  test
//
//  Created by Anderson, Todd W. on 3/28/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation


class MazeGenerator {
    var passage: [(Int, Int)] = [(Int, Int)]()
    var maze: [[UInt8]] = [[UInt8]]()
    
    //starts out with a maze full of walls
    init() {
        var x = 0
        while x < 1000 {
            var y = 0
            var list = [UInt8]()
            while y < 1000 {
                list.append(1)
                y += 1
            }
            x += 1
            maze.append(list)
        }
        passage.append((500, 500))
        maze[500][500] = 0
        generate()
    }
    
    //starts at the origin and randomly branches off from there
    //once there is more than one passage it begins to randomly select a passages and branch off of it then choose a new one the next time
    func generate() {
        var index = 0
        while passage.count != 0 {
            let ran = Int(arc4random_uniform(UInt32(passage.count)))
            let coord = passage[ran]
            if (addBranch(x: coord.0, y: coord.1)) {
                passage.remove(at: ran)
            }
            index += 1
        }
    }
    
    //method called to branch off of a particular point
    func addBranch(x: Int, y: Int) -> Bool {
        var possible: [(Int, Int)] = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        var index = 0
        for dir in possible {
            if (getState(x: x + 2 * dir.0, y: y + 2 * dir.1) != 1) {
                possible.remove(at: index)
            }
            else {
                index += 1
            }
        }
        if (possible.count == 0) {
            if (x < 998 && x > 1 && y < 998 && y > 1 && arc4random_uniform(20) == 0) {
                let m = [(0, 1), (1, 0), (0, -1), (-1, 0)]
                let t = m[Int(arc4random_uniform(4))]
                maze[t.0 + x][t.1 + x] = 0
            }
            return true
        }
        let ran = possible[Int(arc4random_uniform(UInt32(possible.count)))]
        maze[x + ran.0][y + ran.1] = 0
        maze[x + 2 * ran.0][y + 2 * ran.1] = 0
        passage.append((x + 2 * ran.0, y + 2 * ran.1))
        return false
    }
    
    //returns the state (1 for wall, 0 for passage) of a particular tile in the maze.
    func getState(x: Int, y: Int) -> UInt8 {
        if (0 <= x && x < 1000 && 0 <= y && y < 1000) {
            return maze[x][y]
        }
        else {
            return 3;
        }
    }
    
    //returns the maze as a whole
    func getMaze() -> [[UInt8]] {
        return maze
    }
}
