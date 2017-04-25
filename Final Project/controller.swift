//
//  controller.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/24/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit

struct Collision {
    static let PLAYER: UInt32 = 0
    static let ENEMY_AND_ROCKET: UInt32 = 1
}

class controller {
    
    var maxX = CGFloat(260)
    var minX = CGFloat(-260)
    
    func createEnemy() -> SKSpriteNode {
        
        let enemy: SKSpriteNode?
        
        if Int(randNum(first: 0, second: 10)) >= 6
        {
            enemy = SKSpriteNode(imageNamed: "astroid")
            enemy!.name = "astroid"
            enemy!.setScale(0.13)
            enemy!.physicsBody = SKPhysicsBody(circleOfRadius: enemy!.size.height/2)
        }
        else
        {
            enemy = SKSpriteNode(imageNamed: "rocket")
            enemy!.name = "rocket"
            enemy!.setScale(0.10)
            enemy!.physicsBody = SKPhysicsBody(circleOfRadius: enemy!.size.height / 2)
        }
        
        enemy!.physicsBody?.categoryBitMask = Collision.ENEMY_AND_ROCKET
        enemy!.zPosition = 5
        enemy!.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        enemy!.position.x = randNum(first: minX, second: maxX)
        enemy!.position.y = 1334 + 50
        
        
        return SKSpriteNode()
    }

    
    func randNum(first: CGFloat, second: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs (first - second) + min(first, second)
    }






}
