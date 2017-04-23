//
//  AirMonster.swift
//  test
//
//  Created by Anderson, Todd W. on 4/23/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class AirMonster: Monster {
    var x: Double
    var y: Double
    var node: SKNode
    var scene: GameScene
    var tileSize: Double
    var callIndex: Int = 0
    var callRate: Int
    var speed: Double
    var momX: Double = 0
    var momY: Double = 0
    
    required init(x: Double, y: Double, speed: Double, scene: GameScene) {
        self.x = x
        self.y = y
        self.scene = scene
        self.callRate = Int(60 * speed)
        tileSize = scene.tileSize
        node = SKShapeNode()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: tileSize * -1/3, y: tileSize * -1/3))
        path.addLine(to: CGPoint(x: tileSize * 1/3, y: tileSize * -1/3))
        path.addLine(to: CGPoint(x: 0.0, y: tileSize * 1/3))
        (node as? SKShapeNode)?.path = path.cgPath
        (node as! SKShapeNode).fillColor = UIColor.red
        node.zPosition = 5
        let difX = (Int(x) - scene.tileX) * Int(tileSize)
        let difY = (Int(y) - scene.tileY) * Int(tileSize)
        node.position.x = CGFloat(difX)
        node.position.y = CGFloat(difY)
  
        scene.addChild(node)
        self.speed = speed
    }
    
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
    
    func move() {
        if (abs(node.position.x) <= CGFloat(tileSize * 2/3) && abs(node.position.y) <= CGFloat(tileSize * 2/3)) {
            scene.controller?.failLevel()
        }
        callIndex += 1
        if (callIndex >= callRate) {
            callIndex = 0
            evaluate()
            node.run(SKAction.move(by: CGVector.init(dx: momX, dy: momY), duration: speed))
        }
    }
    
    func evaluate() {
        momX += Double(arc4random_uniform(UInt32(tileSize / 3))) - (tileSize / 6)
        momY += Double(arc4random_uniform(UInt32(tileSize / 3))) - (tileSize / 6)
    }
    
    func remove() {
        
    }
}
