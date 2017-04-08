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
        var x = -4
        while x < 5 {
            var y = -6
            while y < 7 {
                addTile(y: y, x: x, state: getState(x: 500 + x, y: 500 + y))
                y += 1
            }
            x += 1
        }
    }
    
    func getMap() -> [Tile] {
        return map
    }
    
    func appendTileRow(direction: Int, tileX: Int, tileY: Int) {
        let sizeX = 5
        let sizeY = 6
        if (direction == 0) {
            var y = -1 * sizeX
            while y < sizeX + 1 {
                
                addTile(y: sizeY, x: y, state: getState(x: tileX + y, y: tileY + sizeY))
                
                y += 1
            }
        }
        else {
            if (direction == 1) {
                var y = -1 * sizeY
                while y < sizeY + 1 {
                    addTile(y: y, x: sizeX, state: getState(x: tileX + sizeX, y: tileY + y))
                    y += 1
                }
            }
            else {
                if (direction == 2) {
                    var y = -1 * sizeX
                    while y < sizeX + 1 {
                        addTile(y: -1 * sizeY, x: y, state: getState(x: tileX + y, y: tileY - sizeY))
                        y += 1
                    }
                }
                else {
                    if (direction == 3) {
                        var y = -1 * sizeY
                        while y < sizeY + 1 {
                            addTile(y: y, x: -1 * sizeX, state: getState(x: tileX - sizeX, y: tileY + y))
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
