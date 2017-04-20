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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*scene = MenuScene(controller: self)
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 1.0))*/
        startLevel()
    }

    override var shouldAutorotate: Bool {
        return true
    }

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
        scene = GameScene(size: CGSize(width: 2048, height: 1536), tile: UIDevice.current.width /*Double(UIScreen.main.bounds.width) / 2.5*/, controller: self, maze: loadMaze(), level: loadInteger(key: "level"), x: loadInteger(key: "x"), y: loadInteger(key: "y"))
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 1.0))
    }
    
    private func saveInteger(key: String, value: Int) {
        UserDefaults.standard.set(value, forKey: key)
    }
    private func saveMaze(value: [[UInt8]]) {
        UserDefaults.standard.set(NSArray(array: value), forKey: "maze")
    }
    
    func loadMaze() -> [[UInt8]] {
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
        let int: Int? = UserDefaults.standard.integer(forKey: key)
        if (int != 0) {
            return int!
        }
        switch key {
            case "level": return 1
            case "x", "y": return 500
            default: return 1
            // put other default values here
        }
    }
    
    func completeLevel(x: Int, y: Int) {
        saveInteger(key: "level", value: loadInteger(key: "level") + 1)
        saveInteger(key: "x", value: x)
        saveInteger(key: "y", value: y)
    }
    
    func failLevel() {
        startLevel()
    }
}
