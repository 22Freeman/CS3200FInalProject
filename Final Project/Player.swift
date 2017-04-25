//
//  Player.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/2/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit
    
class Player: SKSpriteNode {
    
    var maxX = CGFloat(260)
    var minX = CGFloat(-260)
    
    func playerPhysics() {
        name = "Player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Collision.PLAYER
        physicsBody?.contactTestBitMask = Collision.ENEMY_AND_ROCKET
        
    }
    
    func move(left: Bool) {
        if left {
            
            position.x -= 15;
            
            if position.x < minX {
                position.x = minX
                
        }
        }
        else {
            position.x += 15;
                
                if position.x > maxX {
                    position.x = maxX
                }
        }
    }
}

    
