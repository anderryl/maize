//
//  MonsterLevels.swift
//  test
//
//  Created by Anderson, Todd W. on 4/23/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class MonsterLevel {
    //a class that represents spawning odds for a type of monster in a particular level
    class Index {
        let monster: Int
        let odds: Int
        init(monster: Int,  odds: Int) {
            self.monster = monster
            self.odds = odds
        }
    }
    let level: Int
    var monsters: [Index] = []
    var squibOdds: Int
    var scene: GameScene
    init(level: Int, scene: GameScene) {
        //sets attributes depending on arguments
        self.level = level
        squibOdds = 1000 - ((level)) - 5
        self.scene = scene
        //depending on the level will create harder and harder levels every ten levels is a crow level where there are ridiculous numbers of crows and hawks spawned; every 10th level offset by five a ridiculous number of ghosts and demons will spawn
        //others are mixed with pumpkins being introduced at level 6, crows at level 10, hawks at level 21, and scarecrows as default
        switch level {
        case 1...4: monsters = [Index(monster: MonsterType.SCARECROW, odds: 100)]; squibOdds = 900
            
        case 5: monsters = [Index(monster: MonsterType.GHOST, odds: 100)]
            
        case 6...9: monsters = [Index(monster: MonsterType.SCARECROW, odds: 50), Index(monster: MonsterType.PUMPKIN, odds: 50)]
            
        case 10: monsters = [Index(monster: MonsterType.CROW, odds: 100)]; squibOdds = 950
            
        case 11...14: monsters = [Index(monster: MonsterType.SCARECROW, odds: 50), Index(monster: MonsterType.PUMPKIN, odds: 40), Index(monster: MonsterType.CROW, odds: 10)]
        
        case 15: monsters = [Index(monster: MonsterType.GHOST, odds: 100)]
            
        case 16...19: monsters = [Index(monster: MonsterType.SCARECROW, odds: 50), Index(monster: MonsterType.PUMPKIN, odds: 40), Index(monster: MonsterType.CROW, odds: 10)]
            
        case 20: monsters = [Index(monster: MonsterType.CROW, odds: 100)]; squibOdds = 925
            
        case 21...24: monsters = [Index(monster: MonsterType.SCARECROW, odds: 40), Index(monster: MonsterType.PUMPKIN, odds: 40), Index(monster: MonsterType.CROW, odds: 15), Index(monster: MonsterType.HAWK, odds: 5), Index(monster: MonsterType.FLICKER, odds: 10)]
            
        case 25: monsters = [Index(monster: MonsterType.GHOST, odds: 100)]
            
        case 26...29: monsters = [Index(monster: MonsterType.SCARECROW, odds: 40), Index(monster: MonsterType.PUMPKIN, odds: 40), Index(monster: MonsterType.CROW, odds: 15), Index(monster: MonsterType.HAWK, odds: 5), Index(monster: MonsterType.FLICKER, odds: 10)]
            
        case 30: monsters = [Index(monster: MonsterType.HAWK, odds: 100)]; squibOdds = 975
            
        case 31...34: monsters = [Index(monster: MonsterType.SCARECROW, odds: 2), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 3), Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.FLICKER, odds: 10)]
            
        case 35: monsters = [Index(monster: MonsterType.GHOST, odds: 75), Index(monster: MonsterType.DEMON, odds: 25)]
        
        case 36...39: monsters = [Index(monster: MonsterType.SCARECROW, odds: 2), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 3), Index(monster: MonsterType.HAWK, odds: 1)]
            
        case 40: monsters = [Index(monster: MonsterType.HAWK, odds: 1)]; squibOdds = 960
            
        case 41...44: monsters = [Index(monster: MonsterType.SCARECROW, odds: 2), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 3), Index(monster: MonsterType.HAWK, odds: 1)]
            
        case 45: monsters = [Index(monster: MonsterType.GHOST, odds: 50), Index(monster: MonsterType.DEMON, odds: 50)]
            
        case 46...49: monsters = [Index(monster: MonsterType.SCARECROW, odds: 30), Index(monster: MonsterType.PUMPKIN, odds: 30), Index(monster: MonsterType.CROW, odds: 10), Index(monster: MonsterType.HAWK, odds: 10), Index(monster: MonsterType.GHOST, odds: 100), Index(monster: MonsterType.DEMON, odds: 100)]
            
        case 50: monsters = [Index(monster: MonsterType.HAWK, odds: 33), Index(monster: MonsterType.CROW, odds: 67)]; squibOdds = 900
            
        case 51...54: monsters = [Index(monster: MonsterType.SCARECROW, odds: 20), Index(monster: MonsterType.PUMPKIN, odds: 20), Index(monster: MonsterType.CROW, odds: 10), Index(monster: MonsterType.HAWK, odds: 10), Index(monster: MonsterType.GHOST, odds: 20), Index(monster: MonsterType.DEMON, odds: 20)]
        
        case 55: monsters = [Index(monster: MonsterType.GHOST, odds: 40), Index(monster: MonsterType.DEMON, odds: 60)]
        
        case 56...59: monsters = [Index(monster: MonsterType.SCARECROW, odds: 25), Index(monster: MonsterType.PUMPKIN, odds: 20), Index(monster: MonsterType.CROW, odds: 5), Index(monster: MonsterType.HAWK, odds: 15), Index(monster: MonsterType.GHOST, odds: 10), Index(monster: MonsterType.DEMON, odds: 25)]
            
        case 60: monsters = [Index(monster: MonsterType.HAWK, odds: 33), Index(monster: MonsterType.CROW, odds: 67)]; squibOdds = 875
            
        case 61...64: monsters = [Index(monster: MonsterType.SCARECROW, odds: 25), Index(monster: MonsterType.PUMPKIN, odds: 22), Index(monster: MonsterType.CROW, odds: 5), Index(monster: MonsterType.HAWK, odds: 15), Index(monster: MonsterType.GHOST, odds: 6), Index(monster: MonsterType.DEMON, odds: 27)]
            
        case 65: monsters = [Index(monster: MonsterType.GHOST, odds: 40), Index(monster: MonsterType.DEMON, odds: 60)]
            
        case 66...69: monsters = [Index(monster: MonsterType.SCARECROW, odds: 25), Index(monster: MonsterType.PUMPKIN, odds: 22), Index(monster: MonsterType.CROW, odds: 5), Index(monster: MonsterType.HAWK, odds: 15), Index(monster: MonsterType.GHOST, odds: 6), Index(monster: MonsterType.DEMON, odds: 27)]
            
        case 70: monsters = [Index(monster: MonsterType.HAWK, odds: 33), Index(monster: MonsterType.CROW, odds: 67)]; squibOdds = 825
        
        case 71...74: monsters = [Index(monster: MonsterType.SCARECROW, odds: 25), Index(monster: MonsterType.PUMPKIN, odds: 25), Index(monster: MonsterType.CROW, odds: 5), Index(monster: MonsterType.HAWK, odds: 15), Index(monster: MonsterType.DEMON, odds: 30)]
            
        case 75: monsters = [Index(monster: MonsterType.GHOST, odds: 35), Index(monster: MonsterType.DEMON, odds: 65)]
            
        case 76...79: monsters = [Index(monster: MonsterType.SCARECROW, odds: 25), Index(monster: MonsterType.PUMPKIN, odds: 25), Index(monster: MonsterType.CROW, odds: 5), Index(monster: MonsterType.HAWK, odds: 15), Index(monster: MonsterType.DEMON, odds: 30), Index(monster: MonsterType.FLICKER, odds: 10)]
            
        case 80: monsters = [Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.CROW, odds: 2)]; squibOdds = 800
            
        case 81...100: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 1), Index(monster: MonsterType.HAWK, odds: 3)]
            
        case 100...1000: monsters = [Index(monster: MonsterType.HAWK, odds: 50), Index(monster: MonsterType.DEMON, odds: 50)]
            
        default: monsters = [Index(monster: MonsterType.SCARECROW, odds: 100), Index(monster: MonsterType.DEMON, odds: 10)]
        }
    }
    
    //returns a monster depending on the index list
    func getMonster(x: Int, y: Int) -> Monster {
        var possible: [Int] = []
        for ind in monsters {
            var x = 0
            while x < ind.odds {
                possible.append(ind.monster)
                x += 1
            }
        }
        //returns monster from template with positions set depending to the arguments holograms are still not implemented
        switch possible[Int(arc4random_uniform(UInt32(possible.count)))] {
        case 1: return GroundMonster(x: Double(x), y: Double(y), speed: 1/2, ai: "smart", scene: scene) //scarecrow
        case 2: return GroundMonster(x: Double(x), y: Double(y), speed: 7/24, ai: "stupid", scene: scene) //pumpkin
        case 3: return AirMonster(x: Double(x), y: Double(y), speed: 1/3, scene: scene) //crow
        case 4: return AirMonster(x: Double(x), y: Double(y), speed: 1/6, scene: scene) //hawk
        case 5: return IncorporealMonster(x: Double(x), y: Double(y), speed: 1/3, ai: "stupid", scene: scene) //ghost
        case 6: return IncorporealMonster(x: Double(x), y: Double(y), speed: 1/2, ai: "smart", scene: scene) //demon
        case 7: return TeleportMonster(x: Double(x), y: Double(y), speed: 1/3, ai: "stupid", scene: scene) //flicker
        case 8: return TeleportMonster(x: Double(x), y: Double(y), speed: 1/3, ai: "smart", scene: scene) //shadow
        default: return HologramMonster(x: Double(x), y: Double(y), speed: 3/7, ai: "smart", scene: scene) //hologram
        }
    }
}
