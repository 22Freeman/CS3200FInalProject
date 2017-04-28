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
    var game = GameScene()
 
    
    func playerPhysics() {
        name = "Player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Collision.PLAYER
        physicsBody?.contactTestBitMask = Collision.ENEMY
        physicsBody?.contactTestBitMask = Collision.ROCKET
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
    func fire(canFire: Int) {
        if canFire == 1
        {
            let laser = SKSpriteNode(imageNamed: "rocket")
            laser.position.x = self.position.x
            laser.position.y = self.position.y + self.size.height/2
            scene?.addChild(laser)
            let moveLaser = SKAction.moveBy(x: self.position.x, y: (scene?.size.height)! + laser.size.height, duration: 1.0)
            let removeLaser = SKAction.removeFromParent()
            laser.run(SKAction.sequence([moveLaser, removeLaser]))
            
        }
        
    }
    
    
}

    
