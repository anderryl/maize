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
    var monsterIndex: Int
    var levelMonsters: MonsterLevel
    
    //called to create the monster register
    init(level: Int, scene: GameScene, index: Int) {
       //sets all attributes accrodance with the arguments
       self.level = level
       self.scene = scene
       self.monsterIndex = index
        //creates the levelMonsters which dictate what monsters are spawned
       levelMonsters = MonsterLevel(level: level, scene: scene)
    }
    
    //creates a new row f monsters in maze passages
    func appendMonsterRow() {
        var dir: (Int, Int) = (0, 1)
        switch scene.direction {
            case 1: dir = (1, 0)
            case 2: dir = (0, -1)
            case 3: dir = (-1, 0)
            default: dir = (0, 1)
        }
        //adds monsters around a 20 tile perimeter
        var i = -10
        while (i < 11) {
            if (dir.0 == 0) {
                if (scene.getState(x: scene.tileX + i, y: scene.tileY + (dir.1 * 20)) == 0) {
                    if (Int(arc4random_uniform(1000)) + 1 >= levelMonsters.squibOdds - 1) {
                        monsters.append(getNewMonster(x: scene.tileX + i, y: scene.tileY + (dir.1 * 20)))
                    }
                }
            }
            else {
                if (scene.getState(x: scene.tileX + (dir.0 * 20), y: scene.tileY + i) == 0) {
                    if (Int(arc4random_uniform(1000)) + 1 >= levelMonsters.squibOdds - 1) {
                        monsters.append(getNewMonster(x: scene.tileX + (dir.0 * 20), y: scene.tileY + i))
                    }
                }
            }
            i += 1
        }
    }
    
    //creates a new monster at a specified point and adds it to the register
    private func getNewMonster(x: Int, y: Int) -> Monster {
        return levelMonsters.getMonster(x: x, y: y)
    }
    //calls the move method on every monster
    func moveMonsters() {
        for monster in monsters {
            monster.move()
        }
    }
    //moves the monsters when the player 'moves'
    func playerMove() {
        for monster in monsters {
            monster.playerMove(direction: Int(scene.direction))
        }
    }
    //removes monsters that are too far away from the player (a threshhold of 30)
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
                else if (monster is HologramMonster) {
                    let g = (monster as! HologramMonster)
                    if (g.count > g.cap) {
                        monster.remove()
                    }
                }
                else {
                    newMonsters.append(monster)
                }
            }
            
        }
        monsters = newMonsters
    }
    
    
}
