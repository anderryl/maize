//
//  MenuScene.swift
//  test
//
//  Created by Anderson, Todd W. on 4/19/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    //not implemented because it doesn't work very well
    var playButton: SKLabelNode?
    var controller: GameViewController?
    var tapRecognizer: UITapGestureRecognizer?
    
    override func didMove(to view: SKView) {
        //
    }
    
    init(controller: GameViewController) {
        self.controller = controller
        
        
        
        playButton?.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeIn(withDuration: 1.0), SKAction.wait(forDuration: 1.0)])))
        super.init()
        scene?.backgroundColor = UIColor.yellow
        anchorPoint = (CGPoint.init(x: 0.5, y: 0.5))
        playButton = SKLabelNode(text: "tap to start")
        playButton?.fontColor = UIColor.brown
        playButton?.fontSize = 100
        playButton?.position.x = 0
        playButton?.position.y = 0
        playButton?.horizontalAlignmentMode = .center
        playButton?.verticalAlignmentMode = .center
        playButton?.zPosition = 10
        addChild(playButton!)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    //called when the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller!.startLevel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //called to cause the level to start
    func startLevel() {
        controller?.startLevel()
    }
}
