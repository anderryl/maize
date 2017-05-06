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
    //template for monsters and represents all monsters calling move() on Monster calls move() on the appropriate subclass
    var x: Double {get set}
    var y: Double {get set}
    var node: SKNode {get}
    var scene: GameScene? {get set}
    var tileSize: Double {get}
    var callIndex: Int {get}
    var callRate: Int {get}
    
    //a required method that moves the monster
    func move()
    
    //a required method that moves the monster according to the players input
    func playerMove(direction: Int)
    
    //removes the momster from the scene and deallocates its data
    func remove()
    
    //provides an identical monster object
    func copy() -> Monster
}
