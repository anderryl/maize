//
//  TileRegister.swift
//  test
//
//  Created by Anderson, Todd W. on 3/26/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

//keeps track of all tiles that you see  on screen
class TileRegister {
    var map = [Tile]()
    var tileSize: Double
    var scene: GameScene
    
    //the initializer of the reister also creates the initial tiles that you first see when the game starts
    init(tileSize: Double, scene: GameScene) {
        self.tileSize = tileSize
        self.scene = scene
        //loops through and creates tiles to cover the whole screen
        var x = -9
        while x < 10 {
            var y = -11
            while y < 12 {
                addTile(y: y, x: x, state: getState(x: scene.tileX + x, y: scene.tileY + y))
                y += 1
            }
            x += 1
        }
    }
    
    //returns all the tiles on the screen
    func getMap() -> [Tile] {
        return map
    }
    
    //creates a new row of tiles as the player moves into a region that is not yet loaded
    func appendTileRow(direction: Int, tileX: Int, tileY: Int) {
        let sizeX = 4
        let sizeY = 7
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
        var nMap = [Tile]()
        for tile in map {
            if (abs(tile.x) > 5 || abs(tile.y) > 6) {
                tile.getGround().removeFromParent()
            }
            else {
                nMap.append(tile)
            }
            
        }
        map = nMap
        
    }
    
    //method that adds a new tile at a given coordinate
    func addTile(y: Int, x: Int, state: UInt8) {
        map.append(Tile(state: state, size: CGRect.init(x: (Double(x) * tileSize - tileSize/2), y: Double(y) * tileSize - tileSize/2, width: tileSize, height: tileSize), scene: scene, x: x, y: y));
        
    }
    
    //gets the state 1 or 0 (wall or passage) of any tile in the maze
    func getState(x: Int, y: Int) -> UInt8 {
        if (0 <= x && x < scene.maze.count && 0 <= y && y < scene.maze.count) {
            return scene.maze[x][y]
        }
        else {
            return 1;
        }
    }
    
}
