//
//  Tile.swift
//  test
//
//  Created by Anderson, Todd W. on 2/16/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class Tile {
    var ground: SKNode;
    
    init(state: UInt8, size: CGRect, scene: SKScene) {
        ground = SKShapeNode.init(rect: size, cornerRadius: 0);
        //self.scene = scene;
        (ground as! SKShapeNode).fillColor = UIColor.brown;
        ground.zPosition = 2;
        if (state == 1) {
            (ground as! SKShapeNode).fillColor = UIColor.yellow;
            ground.zPosition = 0;
        }
        else {
            (ground as! SKShapeNode).fillColor = UIColor.brown;
            ground.zPosition = 2;
        }
        scene.addChild(ground)
        
    }
    
    deinit {
        ground.removeFromParent()
    }
    
    func moveX(amount: Double, duration: TimeInterval) {
        ground.run(SKAction.moveBy(x: CGFloat(amount), y: CGFloat(0), duration: duration));
    }
    
    func moveY(amount: Double, duration: TimeInterval) {
        ground.run(SKAction.moveBy(x: CGFloat(0), y: CGFloat(amount), duration: duration));
    }
    func getGround() -> SKNode {
        return ground
    }
}
