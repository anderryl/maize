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
    var x: Double {get}
    var y: Double {get}
    var node: SKNode {get}
    var scene: GameScene {get}
    var tileSize: Double {get}
    var callIndex: Int {get}
    var callRate: Int {get}
    
    
    func move()
    
    func remove()
}
