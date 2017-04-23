//
//  GroundMonster.swift
//  test
//
//  Created by Anderson, Todd W. on 3/29/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class GroundMonster: Monster {
    var x: Double
    var y: Double
    var node: SKNode
    var scene: GameScene
    var tileSize: Double
    var callIndex: Int = 0
    var callRate: Int
    var tileX: Int
    var tileY: Int
    var speed: Double // in seconds per tile
    var direction: Int = 0
    
    required init(x: Double, y: Double, speed: Double, scene: GameScene) {
        self.x = x
        self.y = y
        self.scene = scene
        self.callRate = Int(60 * speed)
        tileX = Int(x)
        tileY = Int(y)
        tileSize = scene.tileSize
        node = SKShapeNode.init(ellipseIn: CGRect.init(x: Int(0 - (tileSize/3)), y: Int(0 - (tileSize/3)), width: Int(tileSize * 2/3), height: Int(tileSize * 2/3)))
        (node as! SKShapeNode).fillColor = UIColor.red
        node.zPosition = 5
        let difX = (Int(x) - scene.tileX) * Int(tileSize)
        let difY = (Int(y) - scene.tileY) * Int(tileSize)
        node.position.x = CGFloat(difX)
        node.position.y = CGFloat(difY)
        scene.addChild(node)
        self.speed = speed
    }
    
    
    func move() {
        if (abs(node.position.x) <= CGFloat(tileSize * 2/3) && abs(node.position.y) <= CGFloat(tileSize * 2/3)) {
            scene.controller?.failLevel()
        }
        let maze = scene.maze
        if (callIndex >= callRate) {
            callIndex = 0
            evaluate(maze: maze)
            switch direction {
            case 0:
                tileY += 1
                node.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(tileSize), duration: speed))
            case 1:
                tileX += 1
                node.run(SKAction.moveBy(x: CGFloat(tileSize), y: CGFloat(0), duration: speed))
            case 2:
                tileY -= 1
                node.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(-1 * tileSize), duration: speed))
            case 3:
                tileX -= 1
                node.run(SKAction.moveBy(x: CGFloat(-1 * tileSize), y: CGFloat(0), duration: speed))
            default:
                break
            }
            
            x = Double(tileX)
            y = Double(tileY)
        }
        
        callIndex += 1
        /*if (Int(x) == scene.tileX && Int(y) == scene.tileY) {
            scene.controller?.failLevel()
        }*/
    }
    
    func evaluate(maze: [[UInt8]]) {
        var possible = [Int]()
        var count: UInt32 = 0
        if (getState(x: tileX, y: tileY + 1, maze: maze) == 0) {
            possible.append(0)
            count += 1
        }
        if (getState(x: 1 + tileX, y: tileY, maze: maze) == 0) {
            possible.append(1)
            count += 1
        }
        if (getState(x: tileX, y: tileY - 1, maze: maze) == 0) {
            possible.append(2)
            count += 1
        }
        if (getState(x: tileX - 1, y: tileY, maze: maze) == 0) {
            possible.append(3)
            count += 1
        }
        let index = Int(arc4random_uniform(count))
        direction = possible[index]
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
    
    func getState(x: Int, y: Int, maze: [[UInt8]]) -> UInt8 {
        if (0 <= x && x < maze.count && 0 <= y && y < maze.count) {
            return maze[x][y]
        }
        else {
            return 1;
        }
    }
    
    func remove() {
        node.removeFromParent()
    }
}
