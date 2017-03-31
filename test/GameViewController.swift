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
        scene = GameScene(size: CGSize(width: 2048, height: 1536), level: 0, tile: UIDevice.current.width /*Double(UIScreen.main.bounds.width) / 2.5*/)
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        view.presentScene(scene)        
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
}
