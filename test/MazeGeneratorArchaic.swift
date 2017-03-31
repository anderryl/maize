//
//  MazeGenerator.swift
//  test
//
//  Created by Anderson, Todd W. on 2/18/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class MazeGeneratorArchiac {
    
    var pathIndex = 0
    var maze = [[UInt8]]()
    var size: Int
    //Make the entire maze walls
    init(size: Int) {
        self.size = size
        var x = 0
        while x < size {
            var y = 0
            var list = [UInt8]()
            while y < size {
                list.append(UInt8(arc4random_uniform(2)))
                y += 1
            }
            x += 1
            maze.append(list)
        }
        generate()
        
    }
    
    func generate() {
        var x = 0;
        while x < 15 {
            x += 1
            generation()
        }
    }
    
    //1 is dead, 0 is alive
    func generation() {
        var nMaze = [[UInt8]]()
        var x = 0;
        for row in maze {
            var y = 0;
            var nRow = [UInt8]()
            for state in row {
                if (state == 1) {
                    if (getNieghbors(x: x, y: y) == 3) {
                        nRow.append(0);
                    }
                    else {
                        nRow.append(1);
                    }
                }
                else {
                    if (getNieghbors(x: x, y: y) < 6) {
                        nRow.append(0);
                    }
                    else {
                        nRow.append(1);
                    }
                }
                y += 1
            }
            nMaze.append(nRow)
            x += 1
        }
        maze = nMaze
    }
    
    func getMaze() -> [[UInt8]] {
        return maze;
    }
    
    func getNieghbors(x: Int, y: Int) -> UInt8 {
        var nieghbors: UInt8 = 8
        nieghbors -= getState(x: x - 1, y: y + 1)
        nieghbors -= getState(x: x, y: y + 1)
        nieghbors -= getState(x: x + 1, y: y + 1)
        nieghbors -= getState(x: x - 1, y: y)
        nieghbors -= getState(x: x + 1, y: y)
        nieghbors -= getState(x: x - 1, y: y - 1)
        nieghbors -= getState(x: x, y: y - 1)
        nieghbors -= getState(x: x + 1, y: y - 1)
        return nieghbors
    }
    
    func getState(x: Int, y: Int) -> UInt8 {
        if (0 <= x && x < size && 0 <= y && y < size) {
            return maze[x][y]
        }
        else {
            return 1;
        }
    }
    
}
