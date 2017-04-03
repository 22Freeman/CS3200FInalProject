//
//  Player.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/2/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit
    
class Player: SKSpriteNode {
    
    func move(left: Bool) {
        if left {
            
            position.x -= 15;
        }
        else {
            position.x += 15;
        }
    }
    
    func move(forward: Bool) {
        if forward {
            position.y += 15;
        }else {
            position.y -= 15;
        }
    }
    
}

