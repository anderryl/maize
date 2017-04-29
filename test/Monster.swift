//
//  Monster.swift
//  test
//
//  Created by Anderson, Todd W. on 3/29/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

protocol Monster {
    var x: Double {get set}
    var y: Double {get set}
    var node: SKNode {get}
    var scene: GameScene? {get set}
    var tileSize: Double {get}
    var callIndex: Int {get}
    var callRate: Int {get}
    
    func move()
    
    func playerMove(direction: Int)
    
    func remove()
    
    func copy() -> Monster
}
