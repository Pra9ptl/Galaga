//
//  GameScene.swift
//  Galaga
//
//  Created by Harsh Parikh on 2019-06-19.
//  Copyright © 2019 Pranav Patel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Variables for images
    let background = SKSpriteNode(imageNamed: "background")
    let background2 = SKSpriteNode(imageNamed: "background")
    
    //creating long background
    func createBackground(){
        backgroundColor = SKColor.white
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        addChild(background)
        
        
        background2.size = CGSize(width: self.size.width, height: self.size.height)
        background2.anchorPoint = CGPoint(x: 0, y: 0)
        background2.position = CGPoint(x: 0, y: (background2.size.height - 1))
        background2.zPosition = -1
        addChild(background2)
    }
    
    // to give parallax effect
    func moveBackground(){
        
        // speed of image movement is 20
        background.position = CGPoint(x: 0, y: background.position.y - 20)
        background2.position = CGPoint(x: 0, y: background2.position.y - 20)
        
        // resetting background 1 position to top
        if(background.position.y < -(background.size.height)){
            background.position = CGPoint(x: 0, y: background2.position.y + background2.size.height)
        }
        
        // resetting background 2 position to top
        if(background2.position.y < -(background2.size.height)){
            background2.position = CGPoint(x: background2.position.x, y: background.position.y + background.size.height)
        }
    }
    override func didMove(to view: SKView) {
        self.createBackground()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.moveBackground()
    }
}
