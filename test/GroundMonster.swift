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
    var speed: Int // in ticks per tile
    var direction: Int = 0
    
    required init(x: Double, y: Double, callRate: Int, scene: GameScene) {
        self.x = x
        self.y = y
        self.scene = scene
        self.callRate = callRate
        tileX = Int(x)
        tileY = Int(y)
        tileSize = scene.tileSize
        node = SKShapeNode(ellipseIn: CGRect(x: (x - scene.positionX - tileSize / 3) * tileSize, y: (y - scene.positionY - tileSize / 3) * tileSize, width: tileSize * 2/3, height: tileSize * 2/3))
        (node as! SKShapeNode).fillColor = UIColor.red
        scene.addChild(node)
        self.speed = callRate
    }
    
    
    func move() {
        let maze = scene.maze
        let xc = scene.positionX
        let yc = scene.positionY
        if (callIndex == callRate) {
            callIndex = 0
            evaluate(maze: maze)
            switch direction {
            case 0:
                tileY += 1
            case 1:
                tileX += 1
            case 2:
                tileY -= 1
            case 3:
                tileX -= 1
            default:
                break
            }
            x = Double(tileX)
            y = Double(tileY)
        }
        switch direction {
        case 0:
            y += Double(1/speed)
        case 1:
            x += Double(1/speed)
        case 2:
            y -= Double(1/speed)
        case 3:
            x -= Double(1/speed)
        default:
            break
        }
        callIndex += 1
        node.position.x = CGFloat(x - xc)
        node.position.y = CGFloat(y - yc)
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
    
    func getState(x: Int, y: Int, maze: [[UInt8]]) -> UInt8 {
        if (0 <= x && x < maze.count && 0 <= y && y < maze.count) {
            return maze[x][y]
        }
        else {
            return 1;
        }
    }
    
    func remove() {
        
    }
}
