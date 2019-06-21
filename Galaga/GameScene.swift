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
    var player = SKSpriteNode(imageNamed: "jet")
    // Enemy
    var ufos:[SKSpriteNode] = []
    var aircrafts:[SKSpriteNode] = []
    var shuttles:[SKSpriteNode] = []
    
    // Generating UFO
    func makeUfo() {
        // lets add some cats
        let ufo = SKSpriteNode(imageNamed: "ufo")
        
        ufo.position = CGPoint(x:0, y:self.size.height + 100)
        
        // add the cat to the scene
        addChild(ufo)
        
        // add the cat to the cats array
        self.ufos.append(ufo)
    }
    
    // Generting AirCraft
    func makeAirCraft() {
        // lets add some cats
        let airCraft = SKSpriteNode(imageNamed: "aircraft")
        
        airCraft.position = CGPoint(x:self.size.width, y:self.size.height + 100)
        
        // add the cat to the scene
        addChild(airCraft)
        
        // add the cat to the cats array
        self.aircrafts.append(airCraft)
    }
    
    // Generting Shuttles
    func makeShuttle() {
        // lets add some cats
        let shuttle = SKSpriteNode(imageNamed: "shuttle")
        
        shuttle.position = CGPoint(x:(self.size.width / 2), y:self.size.height + 100)
        
        // add the cat to the scene
        addChild(shuttle)
        
        // add the cat to the cats array
        self.shuttles.append(shuttle)
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
        
        // Create player
        self.player.position = CGPoint(x: 0, y: 100)
        self.player.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(self.player)
        
        // drawing UFO
        for _ in 0...3 {
            makeUfo()
        }
        
        // drawing AirCraft
        for _ in 0...5 {
            makeAirCraft()
        }
        
        // draw shuttle
        for _ in 0...9 {
            makeShuttle()
        }
    
    }
    
    // variable to keep track of how much time has passed
    var timeOfLastUpdate:TimeInterval?
    // variable to keep track of how many ufo are there on screen
    var trackUfoCount = 0
    // variable to keep the x position of the last ufo
    var ufoInitialPosition:CGFloat = 300
    // variable to keep track of how many aircraft are there on screen
    var trackAirCraftCount = 0
    // variable to keep the x position of the last aircraft
    var airCraftInitialPosition:CGFloat = 225
    // variable to keep track of how many shuttle are there on screen
    var trackShuttleCount = 0
    // variable to keep the x position of the last shuttle
    var shuttleInitialPosition:CGFloat = 100
    
    func makeUfoAppear() {
        
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
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
        
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
        let m2 = SKAction.move(to: CGPoint(x: airCraftInitialPosition, y: self.size.height * 0.8), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        if (trackAirCraftCount <= 5){
            print("You Can Move \(trackAirCraftCount)")
            aircrafts[trackAirCraftCount].run(sequence)
            trackAirCraftCount += 1
        }
        
        airCraftInitialPosition = airCraftInitialPosition + aircrafts[trackAirCraftCount-1].size.width
    }
    
    func makeShuttleAppear() {
        
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
        let m2 = SKAction.move(to: CGPoint(x: shuttleInitialPosition, y: self.size.height * 0.7), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        if (trackShuttleCount <= 9){
            print("You Can Move \(trackShuttleCount)")
            shuttles[trackShuttleCount].run(sequence)
            trackShuttleCount += 1
        }
        
        shuttleInitialPosition = shuttleInitialPosition + shuttles[trackShuttleCount-1].size.width
    }
    
    var isMovingRight = true
    
    func makePlayerMove() {
        if(isMovingRight == true){
            self.player.position.x += 20
        } else if(isMovingRight == false){
            self.player.position.x -= 20
        }
        
        if(self.player.position.x >= (self.size.width - self.player.size.width)){
            isMovingRight = false
        } else if(self.player.position.x <= 0) {
            isMovingRight = true
        }
    }
    
    var isUfoMovingRight = true
    func makeUfoMove() {
        for i in 0...(ufos.count - 1) {
        if(isUfoMovingRight == true){
            self.ufos[i].position.x += 15
        } else if(isUfoMovingRight == false){
            self.ufos[i].position.x -= 15
        }
        }
        
        if(self.ufos[ufos.count-1].position.x >= (self.size.width - self.ufos[0].size.width)){
            isUfoMovingRight = false
        } else if(self.ufos[0].position.x <= 0) {
            isUfoMovingRight = true
        }
    }
    
    func makeAirCraftMove() {
        if(isMovingRight == true){
            self.player.position.x += 20
        } else if(isMovingRight == false){
            self.player.position.x -= 20
        }
        
        if(self.player.position.x >= (self.size.width - self.player.size.width)){
            isMovingRight = false
        } else if(self.player.position.x <= 0) {
            isMovingRight = true
        }
    }
    
    func makePShuttleMove() {
        if(isMovingRight == true){
            self.player.position.x += 20
        } else if(isMovingRight == false){
            self.player.position.x -= 20
        }
        
        if(self.player.position.x >= (self.size.width - self.player.size.width)){
            isMovingRight = false
        } else if(self.player.position.x <= 0) {
            isMovingRight = true
        }
    }
    
    var bullets:[SKSpriteNode] = []
    
    func makeBullet(xPosition:CGFloat, yPosition:CGFloat) {
        // lets add some cats
        let bullet = SKSpriteNode(imageNamed: "bullet")
        
        bullet.position = CGPoint(x:xPosition, y:yPosition)
        bullet.zPosition = 100
        
        // add the cat to the scene
        addChild(bullet)
        
        // add the cat to the cats array
        self.bullets.append(bullet)
        
        print("Where is bullet? \(xPosition), \(yPosition)")
    }

    
    var isGridSet = false
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.moveBackground()
        
        // call player move
        self.makePlayerMove()
        
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        // print a message every 3 seconds
        let timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 2) {
            timeOfLastUpdate = currentTime
            //if(isGridSet == false){
            // Make Ufo Appear on screen
            makeUfoAppear()
            // Make airCraft Appear on screen
            makeAirCraftAppear()
            // Make Shuttle Appear on screen
            makeShuttleAppear()
          //  }
        }
        makeUfoMove()
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let mousePosition = touches.first?.location(in: self)
        let playerX = self.player.position.x
        let playerY = self.player.position.y
        
        makeBullet(xPosition: playerX, yPosition: playerY)
    }
    
}
