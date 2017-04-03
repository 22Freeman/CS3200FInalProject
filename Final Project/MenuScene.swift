//
//  MenuScene.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/2/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Play" {
                if let scene = GameScene(fileNamed: "Game") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 2))
                }
            }
            if atPoint(location).name == "High Score" {
                if let scene = GameScene(fileNamed: "HighScore") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: 2))
                }
            }

    }
}
}
