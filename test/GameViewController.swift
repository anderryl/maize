//
//  GameViewController.swift
//  test
//
//  Created by Anderson, Todd W. on 2/11/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {

    var scene: SKScene? = nil;
    
    //called when the vuew loads (when the splash screen ends)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*//initializes the menu scene where you start
        scene = MenuScene(controller: self)
        (scene as? MenuScene)?.controller = self
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        //sets the menu scene as the actie scene
        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 1.0))*/
        
        //initiates the game scene and starts the game
        startLevel()

    }

    override var shouldAutorotate: Bool {
        return true
    }
    //the only supported orientation is portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    func startLevel() {
        //initiates game scene
        scene = GameScene(size: CGSize(width: 2048, height: 1536), tile: UIDevice.current.width /*Double(UIScreen.main.bounds.width) / 2.5*/, controller: self, maze: loadMaze(), level: loadInteger(key: "level"), x: loadInteger(key: "x"), y: loadInteger(key: "y"))
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        //sets game scene as the active scene
        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.black, duration: 1.0))
    }
    
    private func saveInteger(key: String, value: Int) {
        //saves an Intege in the system under a key that is used for retrieval
        UserDefaults.standard.set(value, forKey: key)
    }
    private func saveMaze(value: [[UInt8]]) {
        //saves the maze (only ever called once) under the key "maze"
        UserDefaults.standard.set(NSArray(array: value), forKey: "maze")
    }
    
    func loadMaze() -> [[UInt8]] {
        //checks if the maze has been created yet and loads it if it has or generates and saves it if it hasnt, returns the maze
        let maze: [[UInt8]]? = UserDefaults.standard.array(forKey: "maze") as? [[UInt8]]
        let count = maze?.count
        let _ = maze?.count
        if (count != nil) {
            return maze!
        }
        else {
            let maze = MazeGenerator.init().getMaze()
            saveMaze(value: maze)
            return maze
        }
        
    }
    
    func loadInteger(key: String) -> Int {
        //loads an integer from a key that said integer is stored under
        let int: Int? = UserDefaults.standard.integer(forKey: key)
        if (int != 0) {
            return int!
        }
        //if not found it return a default value determined by the key
        switch key {
            case "level": return 1
            case "x", "y": return 500
            default: return 1
            // put other default values here
        }
    }
    
    //called when a level has been completed ups the level and saves the players last location
    func completeLevel(x: Int, y: Int) {
        saveInteger(key: "level", value: loadInteger(key: "level") + 1)
        saveInteger(key: "x", value: x)
        saveInteger(key: "y", value: y)
        startLevel()
    }
    
    //called when the player fails a level, this starts the level over again
    func failLevel() {
        startLevel()
    }
}
