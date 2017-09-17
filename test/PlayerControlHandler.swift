//
//  PlayerControlHandler.swift
//  test
//
//  Created by Rylie Anderson on 9/15/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class PlayerControlHandler {
    var swipeDown: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    var swipeLeft: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var tapPause: UITapGestureRecognizer?

    var scene: GameScene
    
    init(view: SKView, scene: GameScene) {
        swipeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(PlayerControlHandler.inputDown))
        swipeDown?.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDown!)
        
        swipeUp = UISwipeGestureRecognizer.init(target: self, action: #selector(PlayerControlHandler.inputUp))
        swipeUp?.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeUp!)
        
        swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(GameScene.inputLeft))
        swipeLeft?.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft!)
        
        swipeRight = UISwipeGestureRecognizer.init(target: self, action: #selector(GameScene.inputRight))
        swipeRight?.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight!)
        
        tapPause = UITapGestureRecognizer.init(target: self, action: #selector(GameScene.inputPause))
        view.addGestureRecognizer(tapPause!)
        
        self.scene = scene
    }
    
    func inputDown() {
        if (!scene.gameIsPaused) {
            scene.direction = 2
        }
    }
    //called when a up swipe is detected and sets the direction to 0 (up)
    func inputUp() {
        if (!scene.gameIsPaused) {
            scene.direction = 0
        }
    }
    
    //called when a left swipe is detected and sets the direction to 3 (left)
    func inputLeft() {
        if (!scene.gameIsPaused) {
            scene.direction = 3
        }
    }
    
    //called when a right swipe is detected and sets the direction to 1 (right)
    func inputRight() {
        if (!scene.gameIsPaused) {
            scene.direction = 1
        }
    }
    
    //called when a tap gesture is detected pauses the game
    func inputPause() {
        scene.direction = 4
        if (scene.pauseIndex >= 3) {
            scene.pauseIndex = 0
            if (scene.gameIsPaused) {
                scene.unpause()
            }
            else {
                scene.pause()
            }
        }
        else {
            scene.pauseIndex += 3
        }
    }
}
