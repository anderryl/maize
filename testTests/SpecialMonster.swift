//
//  SpecialMonster.swift
//  test
//
//  Created by Anderson, Todd W. on 8/12/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class SpecialMonster: Monster {
    var x: Double
    var y: Double
    var node: SKNode
    var scene: GameScene?
    var tileSize: Double
    var callIndex: Int = 0
    var callRate: Int
    var behavior: Int
    
    
    init(x: Double, y: Double, callRate: Int, scene: GameScene, behavior: Int) {
        //sets its attributes according to arguments
        self.x = x
        self.y = y
        self.callRate = callRate
        self.scene = scene
        tileSize = (scene.tileSize)
        //creates a red circle and adds it to the scene in the appropriate position
        node = SKShapeNode.init(rect: CGRect.init(x: Int(0 - (tileSize/3)), y: Int(0 - (tileSize/3)), width: Int(tileSize * 2/3), height: Int(tileSize * 2/3)))
        (node as! SKShapeNode).fillColor = UIColor.red
        node.zPosition = 5
        let difX = (Int(x) - (scene.tileX)) * Int(tileSize)
        let difY = (Int(y) - (scene.tileY)) * Int(tileSize)
        node.position.x = CGFloat(difX)
        node.position.y = CGFloat(difY)
        scene.addChild(node)
        self.behavior = behavior
    }
    
    //a required method that moves the monster
    func move() {
        //var newX = scene.positionX + arc4random_uniform(20) + 5
    }
    
    //a required method that moves the monster according to the players input
    func playerMove(direction: Int) {
        switch direction {
        case 0:
            node.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(-1 * tileSize), duration: 1/3))
        case 1:
            node.run(SKAction.moveBy(x: CGFloat(-1 * tileSize), y: CGFloat(0), duration: 1/3))
        case 2:
            node.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(tileSize), duration: 1/3))
        case 3:
            node.run(SKAction.moveBy(x: CGFloat(tileSize), y: CGFloat(0), duration: 1/3))
        default:
            break
        }
    }
    
    //removes the momster from the scene and deallocates its data
    func remove() {
        node.removeFromParent()
    }
    
    //provides an identical monster object
    func copy() -> Monster {
        return SpecialMonster(x: x, y: y, callRate: callRate, scene: scene!, behavior: behavior)
    }
}
