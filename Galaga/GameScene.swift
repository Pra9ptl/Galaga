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
    var timeBomb:SKSpriteNode?
    
    // Enemy
    var ufos:[SKSpriteNode] = []
    var aircrafts:[SKSpriteNode] = []
    var shuttles:[SKSpriteNode] = []
    
    // Generating UFO
    func makeUfo() {
        // lets add some cats
        let ufo = SKSpriteNode(imageNamed: "ufo")
        
        ufo.position = CGPoint(x:0, y:self.size.height + 100)
        ufo.anchorPoint = CGPoint(x: 0, y: 0)
        
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
        airCraft.anchorPoint = CGPoint(x: 0, y: 0)
        
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
        shuttle.anchorPoint = CGPoint(x: 0, y: 0)
        // add the cat to the scene
        addChild(shuttle)
        
        // add the cat to the cats array
        self.shuttles.append(shuttle)
    }
    
    //creating long background
    func createBackground(){
        //setting images vertically at the end of one image, just to create one long image
        
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
    
        //time bomb
        timeBomb = SKSpriteNode(imageNamed: "bomb")
        timeBomb?.position.x = 0
        timeBomb?.position.y = 0
        timeBomb?.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(timeBomb!)
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
    
    
    // Grid Animation for UFO
    func makeUfoAppear() {
        
        // Action Sequencing
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
        let m2 = SKAction.move(to: CGPoint(x: ufoInitialPosition, y: self.size.height * 0.9), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        // running animation for each ufo individually
        if (trackUfoCount <= 3){
            ufos[trackUfoCount].run(sequence)
            trackUfoCount += 1
        }
        
        // getting initial position of ufo, for setting each ufo exactly beside the previous ufo on grid
        ufoInitialPosition = ufoInitialPosition + ufos[trackUfoCount-1].size.width
    }
    
    // Grid Animation for Air Craft
    func makeAirCraftAppear() {
        
        // Action Sequencing
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
        let m2 = SKAction.move(to: CGPoint(x: airCraftInitialPosition, y: self.size.height * 0.8), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        // running animation for each Air Craft individually
        if (trackAirCraftCount <= 5){
            aircrafts[trackAirCraftCount].run(sequence)
            trackAirCraftCount += 1
        }
        
        // getting initial position of aircraft, for setting each aircraft exactly beside the previous aircraft on grid
        airCraftInitialPosition = airCraftInitialPosition + aircrafts[trackAirCraftCount-1].size.width
    }
    
    // Grid Animation for Shuttle
    func makeShuttleAppear() {
        
        // Action Sequencing
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
        let m2 = SKAction.move(to: CGPoint(x: shuttleInitialPosition, y: self.size.height * 0.7), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1, m2])
        
        // running animation for each shuttle individually
        if (trackShuttleCount <= 9){
            shuttles[trackShuttleCount].run(sequence)
            trackShuttleCount += 1
        }
        
        // getting initial position of shuttle, for setting each shuttle exactly beside the previous shuttle on grid
        shuttleInitialPosition = shuttleInitialPosition + shuttles[trackShuttleCount-1].size.width
    }
    
    
    // -------------------
    // Player Movement Starts
    // -------------------
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
    // -------------------
    // Player Movement Ends
    // -------------------
    
    
    // -------------------
    // Ufo Movement Starts
    // -------------------
    var isUfoMovingRight = true
    func makeUfoMove() {
        
        for i in 0...(ufos.count - 1) {
        if(isUfoMovingRight == true){
            self.ufos[i].position.x += 10
        } else if(isUfoMovingRight == false){
            self.ufos[i].position.x -= 10
        }
        }
        
        // rebouncing of ufo from left to right on basis of first and last ufo in the array list
        if((ufos.last?.position.x)! >= (self.size.width - (self.ufos.first?.size.width)!)){
            isUfoMovingRight = false
        } else if((ufos.first?.position.x)! <= 0) {
            isUfoMovingRight = true
        }
    }
    // -------------------
    // Ufo Movement Ends
    // -------------------
    
    // -------------------
    // AirCraft Movement Starts
    // -------------------
    var isAirCraftMovingRight = false
    func makeAirCraftMove() {
        for i in 0...(aircrafts.count - 1) {
            if(isAirCraftMovingRight == true){
                self.aircrafts[i].position.x += 10
            } else if(isAirCraftMovingRight == false){
                self.aircrafts[i].position.x -= 10
            }
        }
        
        // rebouncing of aircraft from left to right on basis of first and last aircraft in the array list
        if((aircrafts.last?.position.x)! >= (self.size.width - (self.aircrafts.first?.size.width)!)){
            isAirCraftMovingRight = false
        } else if((aircrafts.first?.position.x)! <= 0) {
            isAirCraftMovingRight = true
        }
    }
    // -------------------
    // AirCraft Movement Ends
    // -------------------
    
    // -------------------
    // Shuttle Movement Starts
    // -------------------
    var isShuttleMovingRight = true
    func makeShuttleMove() {
        for i in 0...(shuttles.count - 1) {
            if(isShuttleMovingRight == true){
                self.shuttles[i].position.x += 10
            } else if(isShuttleMovingRight == false){
                self.shuttles[i].position.x -= 10
            }
        }
        
        // rebouncing of shuttle from left to right on basis of first and last shuttl in the array list
        if((shuttles.last?.position.x)! >= (self.size.width - (self.shuttles.first?.size.width)!)){
            isShuttleMovingRight = false
        } else if((shuttles.first?.position.x)! <= 0) {
            isShuttleMovingRight = true
        }
    }
    // -------------------
    // Shuttle Movement Ends
    // -------------------
    
    // -------------------
    // Player Bullet Starts
    // -------------------
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
    }
    
    // moving all bullets in the array by 30
    func moveBullet() {
        if(bullets.count != 0){
        for i in 0...(bullets.count - 1) {
            self.bullets[i].position.y = self.bullets[i].position.y + 30
        }
        }
    }
    // -------------------
    // Player Bullet Ends
    // -------------------
    
    // -------------------
    // AirCraft Bullet Starts
    // -------------------
    var airCraftbullets:[SKSpriteNode] = []
    func makeAirCraftBullet() {
        // randomly generate where the chopstick
        let randomAirBullet = Int.random(in: 0...(aircrafts.count - 1))
        
        // lets add some cats
        let airBullet = SKSpriteNode(imageNamed: "fireball")
        
        airBullet.position = CGPoint(x:(aircrafts[randomAirBullet].position.x + (aircrafts[randomAirBullet].size.width / 2)), y:aircrafts[randomAirBullet].position.y)
        
        // add the cat to the scene
        addChild(airBullet)
        
        // add the cat to the cats array
        self.airCraftbullets.append(airBullet)
    }
    
    // moving aircraft bullet by 20
    func moveAirCraftBullet() {
        if(airCraftbullets.count != 0){
            for i in 0...(airCraftbullets.count - 1) {
                self.airCraftbullets[i].position.y = self.airCraftbullets[i].position.y - 20
            }
        }
    }
    // -------------------
    // AirCraft Bullet Ends
    // -------------------
    
    // Variables to set grids and firing aricraft bullet at random time
    var isGridSet = false
    var isGridSetTimer:TimeInterval?
    var bulletTime:TimeInterval?
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
            // Make Ufo Appear on screen
            makeUfoAppear()
            // Make airCraft Appear on screen
            makeAirCraftAppear()
            // Make Shuttle Appear on screen
            makeShuttleAppear()
            
           
        }

        
        // gird setting flag
        if(trackUfoCount == 4 && trackAirCraftCount == 6 && trackShuttleCount == 10){
            if (isGridSetTimer == nil) {
                isGridSetTimer = currentTime
            }
            let gridTimePassed = (currentTime - isGridSetTimer!)
            if(gridTimePassed >= 5) {
                print("hgjkhgjnk")
                isGridSet = true
                isGridSetTimer = currentTime
            }
        }
        
        // calling functions to make enemies start moving
        if(isGridSet == true){
            makeUfoMove()
            makeAirCraftMove()
            makeShuttleMove()
            
        }
        
        
        if (bulletTime == nil) {
            bulletTime = currentTime
        }
        
        let bulletTimePassed = (currentTime - bulletTime!)
        if(bulletTimePassed >= 5 && isGridSet == true) {
            print("hgjkhgjnk")
            makeAirCraftBullet()
            bulletTime = currentTime
        }

        moveAirCraftBullet()
        moveBullet()

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let mousePosition = touches.first?.location(in: self)
        var playerX = self.player.position.x + (self.player.size.width / 2)
        var playerY = self.player.position.y + (self.player.size.height / 2)
        
        
        // generating player bullet on tap
        makeBullet(xPosition: playerX, yPosition: playerY)
        
    }
    

    
}
