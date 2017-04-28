//
//  GameScene.swift
//  Final Project
//
//  Created by Ryan Freeman on 4/2/17.
//  Copyright © 2017 Ryan Freeman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var player: Player?
    var canMoveLeft = false
    var moveLeft = false
    var center = CGFloat()
    var playerCenter = CGFloat()

    var enemyController = controller()
    
    var score:SKLabelNode!
    var rocketCount:SKLabelNode!
    var rockets = 3
    var canFire = 0
    
    //var gameTimer:Timer!;
    //Add other enemy pngs
    //var enemy = ["astroid"];
    //Bit mask for enemy nodes and rocket nodes. collision detection
    //let enemyID:UInt32 = 0x1 << 1;
    //let rocketID:UInt32 = 0x1 << 0;

    override func didMove(to view: SKView) {
        initializeGame()
        //self.scene
    }
    
    override func update(_ currentTime: TimeInterval) {
        movePlayer()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var first = SKPhysicsBody()
        var second = SKPhysicsBody()
        if contact.bodyA.node?.name == "Player"
        {
            first = contact.bodyA
            second = contact.bodyB
        }
        else
        {
            first = contact.bodyB
            second = contact.bodyA
        }
        
        if first.node?.name == "Player" && second.node?.name == "rocket"
        {
            rockets += 1
            rocketCount?.text = String(rockets)
            first.node?.removeFromParent()
        }
        if first.node?.name == "Player" && second.node?.name == "astroid"
        {
            first.node?.removeFromParent()
            second.node?.removeFromParent()
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameScene.restart), userInfo: nil, repeats: false)
            
        }
    }
    func initializeGame() {
        
        physicsWorld.contactDelegate = self
        player = childNode(withName: "Player") as? Player!
        player?.playerPhysics()
        
        score = childNode(withName: "Score") as? SKLabelNode!
        score?.text = "0"
        rocketCount = childNode(withName: "Rockets") as? SKLabelNode!
        rocketCount?.text = "3"
        
        center = self.frame.size.width / self.frame.size.height
        //playerCenter = player?.size.width / (player?.size.height)!
        
        
        
        Timer.scheduledTimer(timeInterval: TimeInterval(enemyController.randNum(first: 1, second: 2)), target: self, selector: #selector(GameScene.spawnEnemy), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(GameScene.removeEnemyNodes), userInfo: nil, repeats: true)
        
        //Need to fix the score lable. need to add it to the game scene manually
        //scoreLabel = SKLabelNode(text: "Score: 0");
        //scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 100);
        //scoreLabel.zPosition = 5;
        //scoreLabel.fontSize = 25;
        //scoreLabel.fontColor = UIColor.white;
       // score = 0;
        //self.addChild(scoreLabel);
        //end of score board node
        
        //gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true);
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
    
}
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            if location.x
        }
    }*/
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMoveLeft = false;
    }
    
    func movePlayer() {
        if canMoveLeft {
            player?.move(left: moveLeft)
        }
    }
    
    func spawnEnemy() {
        self.scene?.addChild(enemyController.createEnemy())
    }
    
    func restart(){
        if let scene = GameScene(fileNamed: "Game")
        {
            scene.scaleMode = .aspectFill
             view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 2))
        }
    }
    
    func removeEnemyNodes(){
        for child in children {
            if child.name == "rocket" || child.name == "astroid"
            {
                if child.position.y < -self.scene!.frame.height - 100 {
                    child.removeFromParent()
                }
            }
        }
    }
    
    func canShoot() {
        if rockets > 0 {
            player?.fire(canFire: 1)
        }else {
            player?.fire(canFire: 0)
        }
    }
    
    /*func fire() {
        if rockets > 0
        {
            let laser
        }
    }*/
    
    /*func addEnemy() {
        
        //selects random enemy from the array
        enemy = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemy) as! [String]
        let enemys = SKSpriteNode(imageNamed: enemy[0])
        
        //gets random position for enemy node to start and initilizes the physics for it to fall
        let randomXPosition = GKRandomDistribution(lowestValue: 0, highestValue: 1334) //Highest value might have to be hard coded. Only puts nodes on half of the screen this way Int(self.frame.width)
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
        let timeDuration:TimeInterval = 6
        actions.append(SKAction.move(to: CGPoint(x: position, y: -enemys.size.height), duration: timeDuration))
        actions.append(SKAction.removeFromParent())
        enemys.run(SKAction.sequence(actions))
        
    }*/
    
    /*func rockets() {
        
        let rocketNode = SKSpriteNode(imageNamed: "Rocket");
        rocketNode.position = Player.
        
    }*/


}
