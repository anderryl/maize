//
//  GameScene.swift
//  test
//
//  Created by Anderson, Todd W. on 2/11/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var positionX: Double = 500
    var positionY: Double = 500
    var tileX:Int = 500
    var tileY: Int = 500
    var direction: Int8 = 4
    var player: SKNode?
    var map: TileRegister?
    
    var maze = [[UInt8]]()
    var tileSize: Double = 170 //a tile size should be 1/5 of the width of the screen
    var level: Int = 0
    
    var swipeDown: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    var swipeLeft: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var monster: Monster?
    
    override func didMove(to view: SKView) {
        maze = MazeGenerator.init().getMaze()
        swipeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(GameScene.inputDown))
        swipeDown?.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(swipeDown!)
        
        swipeUp = UISwipeGestureRecognizer.init(target: self, action: #selector(GameScene.inputUp))
        swipeUp?.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(swipeUp!)
        
        swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(GameScene.inputLeft))
        swipeLeft?.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(swipeLeft!)
        
        swipeRight = UISwipeGestureRecognizer.init(target: self, action: #selector(GameScene.inputRight))
        swipeRight?.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(swipeRight!)
        
        anchorPoint = (CGPoint.init(x: 0.5, y: 0.5))
        player = SKShapeNode.init(ellipseIn: CGRect.init(x: Int(0 - (tileSize/3)), y: Int(0 - (tileSize/3)), width: Int(tileSize * 2/3), height: Int(tileSize * 2/3)))
        (player as! SKShapeNode).fillColor = UIColor.green
        player?.zPosition = 3
        addChild(player!)
        player?.run(SKAction.repeatForever(SKAction.sequence(([SKAction.scale(by: CGFloat(1.1), duration: 0.25), SKAction.scale(by: 1 / 1.1, duration: 0.25)]))))
        player?.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.move()
        }, SKAction.wait(forDuration: 1/3)])))
        map = TileRegister(tileSize: tileSize, scene: self)
        var x = -3
        while x < 4 {
            var y = -5
            while y < 6 {
                map?.addTile(y: y, x: x, state: getState(x: 500 + x, y: 500 + y))
                y += 1
            }
            x += 1
        }
        monster = GroundMonster(x: 500, y: 500, callRate: 60, scene: self)
    }
    
    init(size: CGSize, level: Int, tile: Double) {
        self.level = level
        tileSize = tile
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func inputDown() {
        direction = 2
    }
    
    func inputUp() {
        direction = 0
    }
    
    func inputLeft() {
        direction = 3
    }
    
    func inputRight() {
        direction = 1
    }
    
    //0 up, 1 right, 2 down, 3 left, 4 stop
    
    
    //do whatever you do when the player stops
    func stop() {
        direction = 4
    }
    
    func move() {
        monster?.move()
        switch direction {
        case 0:
            if (checkMove(x: 0, y: 1)) {
                moveUp()
                break
            }
            stop()
        case 1:
            if (checkMove(x: 1, y: 0)) {
                moveRight()
                break
            }
            stop()
        case 2:
            if (checkMove(x: 0, y: -1)) {
                moveDown()
                break
            }
            stop()
        case 3:
            if (checkMove(x: -1, y: 0)) {
                moveLeft()
                break
            }
            stop()
        default:
            break
        }
        
    }
    
    func checkMove(x: Int, y: Int) -> Bool {
        //if (tileX + x >= 0 && tileX + x < 1000 && tileY + y >= 0 && tileY + y < 1000) {
        //    if (maze[tileX + x][tileY + y] == 0) {
        //       return true
        //    }
        //}
        //return false
        if (getState(x: tileX + x, y: tileY + y) == 0) {
            return true
        }
        else {
            return false
        }
    }
    
    
    func moveUp() {
        direction = 0;
        for tile: Tile in (map?.getMap())! {
            tile.moveY(amount: -1 * tileSize, duration: 1/3)
        }
        tileY += 1;
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    func moveDown() {
        direction = 2;
        for tile: Tile in (map?.getMap())! {
            tile.moveY(amount: tileSize, duration: 1/3)
        }
        tileY -= 1;
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    func moveRight() {
        direction = 1;
        for tile: Tile in (map?.getMap())! {
            tile.moveX(amount: -1 * tileSize, duration: 1/3)
        }
        tileX += 1;
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    func moveLeft() {
        for tile: Tile in (map?.getMap())! {
            tile.moveX(amount: tileSize, duration: 1/3)
        }
        direction = 3;
        tileX -= 1;
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    
    
    func getState(x: Int, y: Int) -> UInt8 {
        if (0 <= x && x < maze.count && 0 <= y && y < maze.count) {
            return maze[x][y]
        }
        else {
            return 1;
        }
    }
    
    func update() {
        monster?.move()
    }
    
}