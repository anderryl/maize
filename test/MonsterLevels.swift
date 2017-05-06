//
//  MonsterLevels.swift
//  test
//
//  Created by Anderson, Todd W. on 4/23/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import Foundation

class MonsterLevel {
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
        self.level = level
        squibOdds = 1000 - ((level) * 3/2) - 50
        self.scene = scene
        switch level {
        case 1...5: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1)]
            
        case 6...9: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 1)]
            
        case 10: monsters = [Index(monster: MonsterType.CROW, odds: 1)]; squibOdds = 850
            
        case 11...19: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 1), Index(monster: MonsterType.CROW, odds: 1)]
            
        case 20: monsters = [Index(monster: MonsterType.CROW, odds: 1)]; squibOdds = 850
            
        case 21...29: monsters = [Index(monster: MonsterType.SCARECROW, odds: 2), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 3), Index(monster: MonsterType.HAWK, odds: 1)]
            
        case 30: monsters = [Index(monster: MonsterType.HAWK, odds: 1)]; squibOdds = 900
            
        case 31...39: monsters = [Index(monster: MonsterType.SCARECROW, odds: 2), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 3), Index(monster: MonsterType.HAWK, odds: 1)]
            
        case 40: monsters = [Index(monster: MonsterType.HAWK, odds: 1)]; squibOdds = 850
            
        case 41...49: monsters = [Index(monster: MonsterType.SCARECROW, odds: 2), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 3), Index(monster: MonsterType.HAWK, odds: 1)]
            
        case 50: monsters = [Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.CROW, odds: 2)]; squibOdds = 750
            
        case 51...59: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 1), Index(monster: MonsterType.HAWK, odds: 3)]
            
        case 60: monsters = [Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.CROW, odds: 2)]; squibOdds = 700
            
        case 61...69: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 1), Index(monster: MonsterType.HAWK, odds: 3)]
            
        case 70: monsters = [Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.CROW, odds: 2)]; squibOdds = 680
        
        case 71...79: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 1), Index(monster: MonsterType.HAWK, odds: 3)]
            
        case 80: monsters = [Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.CROW, odds: 2)]; squibOdds = 650
            
        case 81...100: monsters = [Index(monster: MonsterType.SCARECROW, odds: 1), Index(monster: MonsterType.PUMPKIN, odds: 5), Index(monster: MonsterType.CROW, odds: 1), Index(monster: MonsterType.HAWK, odds: 3)]
            
        case 100...1000: monsters = [Index(monster: MonsterType.HAWK, odds: 1), Index(monster: MonsterType.CROW, odds: 2)]; squibOdds = 500
        default: break
        }
    }
    
    func getMonster(x: Int, y: Int) -> Monster {
        var possible: [Int] = []
        for ind in monsters {
            var x = 0
            while x < ind.odds {
                possible.append(ind.monster)
                x += 1
            }
        }
        switch possible[Int(arc4random_uniform(UInt32(possible.count)))] {
        case 1: return GroundMonster(x: Double(x), y: Double(y), speed: 1/2, scene: scene)
        case 2: return GroundMonster(x: Double(x), y: Double(y), speed: 1/4, scene: scene)
        case 3: return AirMonster(x: Double(x), y: Double(y), speed: 1/3, scene: scene)
        default: return AirMonster(x: Double(x), y: Double(y), speed: 1/10, scene: scene)
        }
    }
}
