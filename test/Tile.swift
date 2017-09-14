//
//  Tile.swift
//  test
//
//  Created by Anderson, Todd W. on 2/16/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

//represents a tile that is seen on the screen
class Tile {
    var ground: SKNode;
    var x: Int
    var y: Int
    
    //called to create the tile
    init(state: UInt8, size: CGRect, scene: SKScene, x: Int, y: Int) {
        //Initiates the sprite as a square with unrounded corners
        ground = SKShapeNode.init(rect: size, cornerRadius: 0);
        (ground as! SKShapeNode).fillColor = UIColor.brown;
        //sets the layer as two
        ground.zPosition = 2;
        //if the state is 1 it sets the color to yellow
        if (state == 1) {
            (ground as! SKShapeNode).fillColor = UIColor.yellow;
            ground.zPosition = 0;
        }
            //if the state is 0 it sets the color to brown
        else {
            (ground as! SKShapeNode).fillColor = UIColor.brown;
            ground.zPosition = 2;
        }
        //adds the node to the scene.
        scene.addChild(ground)
        self.x = x
        self.y = y
    }
    
    //deinitilizes the tile
    deinit {
        ground.removeFromParent()
    }
    
    //the tile moves when the player 'moves'
    func moveX(amount: Double, duration: TimeInterval) {
        ground.run(SKAction.moveBy(x: CGFloat(amount), y: CGFloat(0), duration: duration));
        if (amount > 0) {
            x += 1
        }
        else {
            x -= 1
        }
    }
    
    func moveY(amount: Double, duration: TimeInterval) {
        ground.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(amount), duration: duration));
        if (amount > 0) {
            y += 1
        }
        else {
            y -= 1
        }
    }
    
    //returns the node that this Tile helps represent
    func getGround() -> SKNode {
        return ground
    }
}
