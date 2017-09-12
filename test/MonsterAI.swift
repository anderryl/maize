//
//  MonsterAI.swift
//  test
//
//  Created by Anderson, Todd W. on 9/11/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

protocol MonsterAI {
    var maze: [[UInt8]] {get}
    
    init(maze: [[UInt8]])
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int
    
    func getDirection(tileX: Int, tileY: Int) -> Int
}
