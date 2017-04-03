//
//  GameScene.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/2/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: Player?;
    var canMoveLeft = false;
    var moveLeft = false;
    var center = CGFloat();
    var moveForward = false;
    var canMoveForward = false;

    override func didMove(to view: SKView) {
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
        movePlayer();
    }
    
    func initializeGame() {
        player = childNode(withName: "Player") as? Player!;
        
        center = self.frame.size.width / self.frame.size.height;
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self);
            
            if location.x > center {
                moveLeft = false;
            }
            else {
                moveLeft = true;
            }
            
    }
        canMoveLeft = true;
    
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.y > center {
                moveForward = true
            }
            else {
                moveForward = false;
            }
        }
        canMoveForward = true;
}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMoveLeft = false;
        canMoveForward = false;
    }
    
    func movePlayer() {
        if canMoveLeft {
            player?.move(left: moveLeft);
        }
        else if canMoveForward {
            player?.move(forward: moveForward)
        }
    }


}
