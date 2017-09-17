//
//  GameScene.swift
//  test
//
//  Created by Anderson, Todd W. on 2/11/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    var positionX: Double = 500
    var positionY: Double = 500
    var tileX:Int = 500
    var tileY: Int = 500
    var direction: Int8 = 4
    var player: SKNode?
    var map: TileRegister?
    var monsters: MonsterRegister?
    
    var maze: [[UInt8]] = [[UInt8]]()
    var tileSize: Double = 122 //a tile size should be 1/5 of the width of the screen
    var level: Int = 1
    var controller: GameViewController?
    
    var swipeDown: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    var swipeLeft: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var tapPause: UITapGestureRecognizer?
    var node: SKShapeNode?
    var time: Int?
    var timerLabel: SKLabelNode?
    var mplayer: AVAudioPlayer?
    var countLoop: Timer?
    var gameIsPaused: Bool = false
    var pauseIndex: Int = 0
    var pauseLabel: SKLabelNode = SKLabelNode(text:
    "PAUSED")
    
    override func didMove(to view: SKView) {
        //sets up the swipe gesture recognizers for each direction
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
        
        tapPause = UITapGestureRecognizer.init(target: self, action: #selector(GameScene.inputPause))
        self.view?.addGestureRecognizer(tapPause!)
        
        //sets the middle of the screenas the origin of the grid
        anchorPoint = (CGPoint.init(x: 0.5, y: 0.5))
        
        //initiates the player node as a pulsing green dot
        player = SKShapeNode.init(ellipseIn: CGRect.init(x: Int(0 - (tileSize/3)), y: Int(0 - (tileSize/3)), width: Int(tileSize * 2/3), height: Int(tileSize * 2/3)))
        (player as! SKShapeNode).fillColor = UIColor.green
        //puts the player over the tiles
        player?.zPosition = 3
        //adds the player to the screen
        addChild(player!)
        //adds the pulsing motion
        player?.run(SKAction.repeatForever(SKAction.sequence(([SKAction.scale(by: CGFloat(1.1), duration: 0.25), SKAction.scale(by: 1 / 1.1, duration: 0.25)]))))
        
        
        //begins the game loop by repeatedly calling 'move' methods on the player and the monster
        player?.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.move()
        }, SKAction.wait(forDuration: 1/3)])))
        player?.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.moveMonsters()
            }, SKAction.wait(forDuration: 1/60)])))
        player?.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.countdown()
            }, SKAction.wait(forDuration: 1)])))
        
        //initiated the tile register to keep track of tiles
        map = TileRegister(tileSize: tileSize, scene: self)
        
        // initiates the monster register to keep track of monsters
        monsters = MonsterRegister(level: level, scene: self, index: level * 2 + 3)
        
        //sets and starts the timer to an amount dependant on the level
        time = 30 + (level * 1)
        
        
        //creates the level label seen at the start of each round that says 'Night Blah'
        let levelLabel = SKLabelNode(text: "Night " + level.description)
        levelLabel.fontSize = 80
        levelLabel.fontColor = UIColor.black
        levelLabel.fontName = "Zapfino"
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.zPosition = 10
        levelLabel.position.x = 0
        levelLabel.position.y = CGFloat(tileSize) * 2
        //adds the label to the scene
        addChild(levelLabel)
        //causes the label to stay for two seconds then to fade out over one second.
        levelLabel.run(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.fadeOut(withDuration: 1)]))
        
        //initiates the label in the top left hand corner that displays the time left in the level
        timerLabel = SKLabelNode(text: time?.description)
        timerLabel?.fontSize = 70
        timerLabel?.horizontalAlignmentMode = .center
        timerLabel?.verticalAlignmentMode = .center
        timerLabel?.fontColor = UIColor.black
        timerLabel?.zPosition = 40
        timerLabel?.position.x = CGFloat(Int(tileSize) * -2)
        timerLabel?.position.y = CGFloat(Int(tileSize) * 4)
        //adds the label to the scene
        addChild(timerLabel!)
        
        pauseLabel.position.x = 0
        pauseLabel.position.y = 0
        pauseLabel.horizontalAlignmentMode = .center
        pauseLabel.verticalAlignmentMode = .center
        pauseLabel.fontSize = 100
        pauseLabel.fontColor = UIColor.black
        pauseLabel.zPosition = 10
        addChild(pauseLabel)
        pauseLabel.run(SKAction.fadeOut(withDuration: 0))
        
        //starts the creepy music and sets it to a loop
        playMusic()
    }
    
    //the initializer for the game scene class that gives it the maze, where to start from, the tileSize, and the controller adress
    init(size: CGSize, tile: Double, controller: GameViewController, maze: [[UInt8]], level: Int, x: Int, y: Int) {
        self.maze = maze
        self.level = level
        tileSize = tile
        self.controller = controller
        tileX = x
        tileY = y
        positionX = Double(x)
        positionY = Double(y)
        super.init(size: size)
    }
    
    //boilerplate crap I wish I could delete
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //creates the gameloop and time left countdown timer
    
    //method that pauses the game
    func pause() {
        countLoop?.invalidate()
        gameIsPaused = true
        pauseLabel.run(SKAction.fadeIn(withDuration: 0.5))
    }
    
    //method that unpauses the game
    func unpause() {
        gameIsPaused = false
        pauseLabel.run(SKAction.fadeOut(withDuration: 0.5))
    }
    
    //called when a down swipe is detected and sets the direction to 2 (down)
    func inputDown() {
        if (!gameIsPaused) {
            direction = 2
        }
    }
    //called when a up swipe is detected and sets the direction to 0 (up)
    func inputUp() {
        if (!gameIsPaused) {
            direction = 0
        }
    }

    //called when a left swipe is detected and sets the direction to 3 (left)
    func inputLeft() {
        if (!gameIsPaused) {
            direction = 3
        }
    }

    //called when a right swipe is detected and sets the direction to 1 (right)
    func inputRight() {
        if (!gameIsPaused) {
            direction = 1
        }
    }

    //called when a tap gesture is detected pauses the game
    func inputPause() {
        direction = 4
        if (pauseIndex >= 3) {
            pauseIndex = 0
            if (gameIsPaused) {
                unpause()
            }
            else {
                pause()
            }
        }
        else {
            pauseIndex += 3
        }
    }
    
    //0 up, 1 right, 2 down, 3 left, 4 stop
    
    
    // stops the player FFR: do whatever you do when the player stops
    func stop() {
        direction = 4
    }
    
    //called three times a second that first checks if a move is viable and then executes the move
    func move() {
        if (pauseIndex > 0) {
            pauseIndex -= 1
        }
        if (gameIsPaused) {
            return
        }
        switch direction {
        case 0:
            if (checkMove(x: 0, y: 1)) {
                moveUp()
                monsters?.playerMove()
                break
            }
            stop()
        case 1:
            if (checkMove(x: 1, y: 0)) {
                moveRight()
                monsters?.playerMove()
                break
            }
            stop()
        case 2:
            if (checkMove(x: 0, y: -1)) {
                moveDown()
                monsters?.playerMove()
                break
            }
            stop()
        case 3:
            if (checkMove(x: -1, y: 0)) {
                moveLeft()
                monsters?.playerMove()
                break
            }
            stop()
        default:
            break
        }
        //adds a row of monsters in the direction the player is going
        monsters?.appendMonsterRow()
    }
    
    //checks whether any given move is viable and return either true or false
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
    
    //called when an upward motion needs to be carried out moves all tiles down
    func moveUp() {
        direction = 0;
        for tile: Tile in (map?.getMap())! {
            tile.moveY(amount: -1 * tileSize, duration: 1/3)
        }
        tileY += 1;
        //adds tiles in the direction you are going to keep the maze entirely visible
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    
    //called when an downwardward motion needs to be carried out moves all tiles up
    func moveDown() {
        direction = 2;
        for tile: Tile in (map?.getMap())! {
            tile.moveY(amount: tileSize, duration: 1/3)
        }
        tileY -= 1;
        //adds tiles in the direction you are going to keep the maze entirely visible
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    
    //called when an rigthward motion needs to be carried out moves all tiles left
    func moveRight() {
        direction = 1;
        for tile: Tile in (map?.getMap())! {
            tile.moveX(amount: -1 * tileSize, duration: 1/3)
        }
        tileX += 1;
        //adds tiles in the direction you are going to keep the maze entirely visible
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    
    //called when an leftward motion needs to be carried out moves all tiles rigth
    func moveLeft() {
        for tile: Tile in (map?.getMap())! {
            tile.moveX(amount: tileSize, duration: 1/3)
        }
        direction = 3;
        tileX -= 1;
        //adds tiles in the direction you are going to keep the maze entirely visible
        map?.appendTileRow(direction: Int(direction), tileX: tileX, tileY: tileY)
    }
    
    //gets the state 1 or 0 (wall or passage) of a particular tile in a maze return 1 (wall) if outside of maze bounds
    func getState(x: Int, y: Int) -> UInt8 {
        if (0 <= x && x < maze.count && 0 <= y && y < maze.count) {
            return maze[x][y]
        }
        else {
            return 1;
        }
    }
    
    //calls a 'move' method on all monsters
    func moveMonsters() {
        if (gameIsPaused) {
            return
        }
        monsters?.moveMonsters()
    }
    
    //called every second and moves down the timer and calls end if timer is at 0
    func countdown() {
        if (!gameIsPaused) {
            time! -= 1
            if (time! <= 0) {
                end()
            }
            timerLabel?.text = time?.description
        }
        
    }
    
    //plays the creepy music
    func playMusic() {
        let sound = NSDataAsset(name: "BackgroundMusic")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            mplayer = try AVAudioPlayer(data: (sound?.data)!, fileTypeHint: AVFileTypeWAVE)
            mplayer?.volume = 0.33
            mplayer!.play()
            mplayer?.numberOfLoops = -1
        } catch _ as NSError {
            fatalError("MUSIC NOT PLAY, IMA KILL YOU, THEN IMA KILL YOU TOO!")
        }
    }
    
    //completes the level and moves on to the next
    func end() {
        controller?.completeLevel(x: tileX, y: tileY)
    }
    
}
