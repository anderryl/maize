//
//  MonsterRegister.swift
//  test
//
//  Created by Anderson, Todd W. on 4/18/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class MonsterRegister {
    var monsters: [Monster] = [Monster]()
    var level: Int
    var scene: GameScene
    
    init(level: Int, scene: GameScene) {
       self.level = level
       self.scene = scene
    }
    
    func appendMonsterRow() {
        var dir: (Int, Int) = (0, 1)
        switch scene.direction {
            case 1: dir = (1, 0)
            case 2: dir = (0, -1)
            case 3: dir = (-1, 0)
            default: dir = (0, 1)
        }
        var i = -10
        while (i < 11) {
            if (dir.0 == 0) {
                if (scene.getState(x: scene.tileX + i, y: scene.tileY + (dir.1 * 20)) == 0) {
                    if (arc4random_uniform(100) + 1 <= 1) {
                        monsters.append(getNewMonster(x: scene.tileX + i, y: scene.tileY + (dir.1 * 20)))
                    }
                }
            }
            else {
                if (scene.getState(x: scene.tileX + (dir.0 * 20), y: scene.tileY + i) == 0) {
                    if (arc4random_uniform(100) + 1 <= 1) {
                        monsters.append(getNewMonster(x: scene.tileX + (dir.0 * 20), y: scene.tileY + i))
                    }
                }
            }
            i += 1
        }
    }
    
    private func getNewMonster(x: Int, y: Int) -> Monster {
        return GroundMonster(x: Double(x), y: Double(y), speed: 1/3, scene: scene)
    }
    
    func moveMonsters() {
        for monster in monsters {
            monster.move()
        }
    }
    
    func playerMove() {
        for monster in monsters {
            monster.playerMove(direction: Int(scene.direction))
        }
    }
    
    func unloadFringeMonsters() {
        var newMonsters: [Monster] = [Monster]()
        for monster in monsters {
            if (abs(Int(monster.x) - scene.tileX) > 30) {
                monster.remove()
            }
            else {
                if (abs(Int(monster.y) - scene.tileY) > 30) {
                    monster.remove()
                }
                else {
                    newMonsters.append(monster)
                }
            }
            
        }
        monsters = newMonsters
    }
    
    
}
