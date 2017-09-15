//
//  HologramMonster.swift
//  test
//
//  Created by Rylie Anderson on 9/14/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class HologramMonster: Monster {
    var x: Double
    var y: Double
    var node: SKNode
    var scene: GameScene?
    var tileSize: Double
    var callIndex: Int = 0
    var callRate: Int
    var tileX: Int
    var tileY: Int
    var speed: Double // in seconds per tile
    var direction: Int = 0
    var AI: MonsterAI
    var canX: Bool = true
    var dups: Int = 0
    var count: Int = 0
    var cap: Int = 15
    
    //represents a monster that is on the ground (so far scarecrow and pumpkin)
    required init(x: Double, y: Double, speed: Double, ai: String, scene: GameScene) {
        //sets its attributes according to arguments
        self.x = x
        self.y = y
        self.callRate = Int(60 * speed)
        self.scene = scene
        tileX = Int(x)
        tileY = Int(y)
        tileSize = (scene.tileSize)
        //creates a red circle and adds it to the scene in the appropriate position
        node = SKShapeNode.init(ellipseIn: CGRect.init(x: Int(0 - (tileSize/3)), y: Int(0 - (tileSize/3)), width: Int(tileSize * 2/3), height: Int(tileSize * 2/3)))
        (node as! SKShapeNode).fillColor = UIColor.red
        node.alpha = CGFloat(0.50)
        node.zPosition = 5
        let difX = (Int(x) - (scene.tileX)) * Int(tileSize)
        let difY = (Int(y) - (scene.tileY)) * Int(tileSize)
        node.position.x = CGFloat(difX)
        node.position.y = CGFloat(difY)
        scene.addChild(node)
        self.speed = speed
        switch ai {
        case "smart": AI = SmartHologramAI(maze: scene.maze)
        case "stupid": AI = StupidGroundAI(maze: scene.maze)
        default: AI = SmartGroundAI(maze:scene.maze)
        }
    }
    
    
    //required method of monsters that when called moves the monster
    func move() {
        //if the monster and the player occupy the same space fail the level
        if (abs(node.position.x) <= CGFloat(tileSize * 2/3) && abs(node.position.y) <= CGFloat(tileSize * 2/3)) {
            scene?.controller?.failLevel()
        }
        //move in a direction depending on the direction attribute
        if (callIndex >= callRate) {
            callIndex = 0
            //evaluate(maze: maze!)
            direction = AI.evaluate(x: tileX, y: tileY, px: (scene?.tileX)!, py: (scene?.tileY)!, dir: direction)
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
            case 4:
                if (canX && dups < 1) {
                    dups += 1
                    scene?.monsters?.monsters.append(copy())
                }
                tileY += 1
                node.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(tileSize), duration: speed))
            case 5:
                if (canX && dups < 1) {
                    dups += 1
                    scene?.monsters?.monsters.append(copy())
                }
                tileX += 1
                node.run(SKAction.moveBy(x: CGFloat(tileSize), y: CGFloat(0), duration: speed))
            case 6:
                if (canX && dups < 1) {
                    dups += 1
                    scene?.monsters?.monsters.append(copy())
                }
                tileY -= 1
                node.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(-1 * tileSize), duration: speed))
            case 7:
                if (canX && dups < 1) {
                    dups += 1
                    scene?.monsters?.monsters.append(copy())
                }
                tileX -= 1
                node.run(SKAction.moveBy(x: CGFloat(-1 * tileSize), y: CGFloat(0), duration: speed))
            default:
                break
            }
            
            //sets its new position
            x = Double(tileX)
            y = Double(tileY)
        }
        //increments the callIndex
        callIndex += 1
    }
    
    //method that decides where to move
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
        
        if (possible.contains(direction)) {
            if (possible.contains(((direction - 2) * -1))) {
                var index = 0
                for int in possible {
                    if (int == ((direction - 2) * -1)) {
                        possible.remove(at: index)
                        count -= 1
                    }
                    index += 1
                }
            }
        }
        let index = Int(arc4random_uniform(count))
        direction = possible[index]
    }
    
    //
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
    
    
    func copy() -> Monster {
        var aiType: String = " "
        if (AI is StupidGroundAI) {
            aiType = "stupid"
        }
        else if (AI is SmartHologramAI) {
            aiType = "smart"
        }
        else {
            //put other kinds here
        }
        
        return HologramMonster(x: x, y: y, speed: speed, ai: aiType, scene: scene!)
    }
}
