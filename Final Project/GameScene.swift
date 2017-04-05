//
//  GameScene.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/2/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: Player?;
    var canMoveLeft = false;
    var moveLeft = false;
    var center = CGFloat();
    var moveForward = false;
    var canMoveForward = false;
    var scoreLabel:SKLabelNode!;
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)";
        }
    }
    
    var gameTimer:Timer!;
    //Add other enemy pngs
    var enemy = ["astroid"];
    //Bit mask for enemy nodes and rocket nodes. collision detection
    let enemyID:UInt32 = 0x1 << 1;
    let rocketID:UInt32 = 0x1 << 0;

    override func didMove(to view: SKView) {
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
        movePlayer();
    }
    
    func initializeGame() {
        
        player = childNode(withName: "Player") as? Player!;
        
        center = self.frame.size.width / self.frame.size.height;
        //Need to fix the score lable. need to add it to the game scene manually
        scoreLabel = SKLabelNode(text: "Score: 0");
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 100);
        scoreLabel.zPosition = 5;
        scoreLabel.fontSize = 25;
        scoreLabel.fontColor = UIColor.white;
        score = 0;
        self.addChild(scoreLabel);
        //end of score board node
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true);
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
        if canMoveLeft || canMoveForward {
            player?.move(left: moveLeft)
            player?.move(forward: moveForward)
        }
        else if canMoveForward {
            player?.move(forward: moveForward)
        }
    }
    
    func addEnemy() {
        
        //selects random enemy from the array
        enemy = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemy) as! [String]
        let enemys = SKSpriteNode(imageNamed: enemy[0])
        
        //gets random position for enemy node to start and initilizes the physics for it to fall
        let randomXPosition = GKRandomDistribution(lowestValue: 0, highestValue: 144) //Highest value might have to be hard coded. Only puts nodes on half of the screen this way Int(self.frame.width)
        let position = CGFloat(randomXPosition.nextInt())
        enemys.position = CGPoint(x: position, y: self.frame.height + enemys.size.height)
        enemys.physicsBody = SKPhysicsBody(rectangleOf: enemys.size)
        enemys.physicsBody?.isDynamic = true
        
        //Bit mask for collision detection
        enemys.physicsBody?.categoryBitMask = enemyID
        enemys.physicsBody?.contactTestBitMask = rocketID
        enemys.physicsBody?.collisionBitMask = 0
        
        //Adds enemy nodes to the screen and removes them
        self.addChild(enemys)
        var actions = [SKAction]()
        let timeDuration:TimeInterval = 10
        actions.append(SKAction.move(to: CGPoint(x: position, y: -enemys.size.height), duration: timeDuration))
        actions.append(SKAction.removeFromParent())
        enemys.run(SKAction.sequence(actions))
        
    }
    
    func rockets() {
        
        //let rocketNode = SKSpriteNode(imageNamed: "Rocket");
        //rocketNode.position = Player.
        
    }


}
