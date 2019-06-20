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
    
    // Enemy 1
    var ufos:[SKSpriteNode] = []
    var aircrafts:[SKSpriteNode] = []
    func makeUfo() {
        // lets add some cats
        let ufo = SKSpriteNode(imageNamed: "ufo")
        
        ufo.position = CGPoint(x:0, y:self.size.height + 100)
        
        // add the cat to the scene
        addChild(ufo)
        
        // add the cat to the cats array
        self.ufos.append(ufo)
    }
    func makeAirCraft() {
        // lets add some cats
        let airCraft = SKSpriteNode(imageNamed: "aircraft")
        
        airCraft.position = CGPoint(x:self.size.width, y:self.size.height + 100)
        
        // add the cat to the scene
        addChild(airCraft)
        
        // add the cat to the cats array
        self.aircrafts.append(airCraft)
    }
    
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
        
        // set initial position of the UFO
        for _ in 0...3 {
            makeUfo()
        }
        
        for _ in 0...5 {
            makeAirCraft()
        }
    
    }
    
    // variable to keep track of how much time has passed
    var timeOfLastUpdate:TimeInterval?
    // variable to keep track of how many ufo are there on screen
    var trackUfoCount = 0
    // variable to keep the x position of the last ufo
    var ufoInitialPosition:CGFloat = 200
    // variable to keep track of how many ufo are there on screen
    var trackAirCraftCount = 0
    // variable to keep the x position of the last ufo
    var airCraftInitialPosition:CGFloat = 150
    
    func makeUfoAppear() {
        
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 5)
        let m2 = SKAction.move(to: CGPoint(x: ufoInitialPosition, y: self.size.height * 0.9), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        if (trackUfoCount <= 3){
            print("You Can Move \(trackUfoCount)")
            ufos[trackUfoCount].run(sequence)
            trackUfoCount += 1
        }
        
        ufoInitialPosition = ufoInitialPosition + ufos[trackUfoCount-1].size.width
    }
    
    func makeAirCraftAppear() {
        
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 5)
        let m2 = SKAction.move(to: CGPoint(x: airCraftInitialPosition, y: self.size.height * 0.8), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        if (trackAirCraftCount <= 5){
            print("You Can Move \(trackAirCraftCount)")
            aircrafts[trackAirCraftCount].run(sequence)
            trackAirCraftCount += 1
        }
        
        airCraftInitialPosition = airCraftInitialPosition + aircrafts[trackAirCraftCount-1].size.width
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.moveBackground()
        
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        // print a message every 3 seconds
        var timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 2) {
            timeOfLastUpdate = currentTime
            
            // Make Ufo Appear on screen
            makeUfoAppear()
            makeAirCraftAppear()
            
        }
        
        
    }
}
