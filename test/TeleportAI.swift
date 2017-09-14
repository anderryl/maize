//
//  TeleportAI.swift
//  test
//
//  Created by Rylie Anderson on 9/14/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
protocol TeleportAI: MonsterAI {
    var maze: [[UInt8]] {get}
    
    init(maze: [[UInt8]])
    
    func evaluate(x: Int, y: Int, px: Int, py: Int, dir: Int) -> Int
    
    func teleport(cx: Int, cy: Int, px: Int, py: Int) -> (x: Int, y: Int, d: Int)
}
