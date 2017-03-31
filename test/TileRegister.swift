//
//  TileRegister.swift
//  test
//
//  Created by Anderson, Todd W. on 3/26/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class TileRegister {
    var map = [Tile]()
    var tileSize: Double
    var scene: GameScene
    
    init(tileSize: Double, scene: GameScene) {
        self.tileSize = tileSize
        self.scene = scene
    }
    
    func getMap() -> [Tile] {
        return map
    }
    
    func appendTileRow(direction: Int, tileX: Int, tileY: Int) {
        if (direction == 0) {
            var y = -3
            while y < 4 {
                
                addTile(y: 5, x: y, state: getState(x: tileX + y, y: tileY + 5))
                
                y += 1
            }
        }
        else {
            if (direction == 1) {
                var y = -5
                while y < 6 {
                    addTile(y: y, x: 3, state: getState(x: tileX + 3, y: tileY + y))
                    y += 1
                }
            }
            else {
                if (direction == 2) {
                    var y = -3
                    while y < 4 {
                        addTile(y: -5, x: y, state: getState(x: tileX + y, y: tileY - 5))
                        y += 1
                    }
                }
                else {
                    if (direction == 3) {
                        var y = -5
                        while y < 6 {
                            addTile(y: y, x: -3, state: getState(x: tileX - 3, y: tileY + y))
                            y += 1
                        }
                    }
                }
            }
        }
        var x: Int = 0
        var nMap = [Tile]()
        while x < map.count {
            if abs(map[x].getGround().position.x) > CGFloat(tileSize * 7) {
                map[x].getGround().removeFromParent()
            }
            else {
                if abs(map[x].getGround().position.y) > CGFloat(tileSize * 11) {
                    map[x].getGround().run(SKAction.removeFromParent())
                }
                else {
                    nMap.append(map[x])
                }
            }
            x += 1
        }
        map = nMap
        //for index in deletes {
        //    if (index < map.count) {
        //        map.remove(at: index)
        //    }
        //}
    }
    
    func addTile(y: Int, x: Int, state: UInt8) {
        map.append(Tile(state: state, size: CGRect.init(x: (Double(x) * tileSize - tileSize/2), y: Double(y) * tileSize - tileSize/2, width: tileSize, height: tileSize), scene: scene));
        
    }
    
    func getState(x: Int, y: Int) -> UInt8 {
        if (0 <= x && x < scene.maze.count && 0 <= y && y < scene.maze.count) {
            return scene.maze[x][y]
        }
        else {
            return 1;
        }
    }
    
}
