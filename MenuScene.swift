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
    
    var playButton: UIButton?
    var controller: GameViewController?
    
    override func didMove(to view: SKView) {
        anchorPoint = (CGPoint.init(x: 0.5, y: 0.5))
        playButton = UIButton(frame: CGRect(x: -50, y: 50, width: 100, height: 100))
        playButton?.setTitle("Play", for: UIControlState.application)
        playButton?.target(forAction: #selector(MenuScene.startLevel), withSender: self)
        playButton?.titleLabel?.text = "Play"
        playButton?.titleLabel?.backgroundColor = UIColor.blue
        view.addSubview(playButton!)
    }
    
    init(controller: GameViewController) {
        self.controller = controller
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLevel() {
        controller?.startLevel()
    }
}
