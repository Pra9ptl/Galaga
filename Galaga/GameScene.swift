
//
//  GameScene.swift
//  Galaga
//
//  Created by Harsh Parikh on 2019-06-19.
//  Copyright © 2019 Pranav Patel. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	// Variables for images
	let background = SKSpriteNode(imageNamed: "background")
	let background2 = SKSpriteNode(imageNamed: "background")
	var player = SKSpriteNode(imageNamed: "jet")
	
	var playerShield = SKSpriteNode(imageNamed: "shield")
	var moveUFO:SKSpriteNode!
	var timeBomb:SKSpriteNode?
	var deployBomb: SKSpriteNode?
	
	var scoreLabel: SKLabelNode!
	var timeLabel: SKLabelNode!
	var remainingLife = 3
	var UFODown = 0
	var playerScore = 0;
	var playershoot:AVAudioPlayer!
	var playerdie:AVAudioPlayer!
	var ufocoming:AVAudioPlayer!
	var ufodie:AVAudioPlayer!
	var bgmusic:AVAudioPlayer!
	var remainingLifeNode:[SKSpriteNode] = []
	var decreaseLivescount:Bool = false;
	var timeLeft = 119
	
	var canActivateShield = false
	var canLaunchBomb = false
	
	var playerShieldHit = 3
	
	// variable to store scores
	var socreCount:Int = 0;
	var PLspeed: CGFloat = 0
	var isShieldActive = false
	var timeForShieldActive:TimeInterval?
	// Enemy
	var ufos:[SKSpriteNode] = []
	var aircrafts:[SKSpriteNode] = []
	var shuttles:[SKSpriteNode] = []
	
	var ufos2:[SKSpriteNode] = []
	var aircrafts2:[SKSpriteNode] = []
	var shuttles2:[SKSpriteNode] = []
	
	//showing remaining live on bottom right of screen
	func makeremainingLife(imgWidth:CGFloat) {
		// lets add some cats
		let life = SKSpriteNode(imageNamed: "jet")
		life.anchorPoint = CGPoint(x: 0, y: 0)
		life.position = CGPoint(x:(self.size.width - (life.size.width * imgWidth)), y:0)
		life.anchorPoint = CGPoint(x: 0, y: 0)
		
		// add the cat to the scene
		addChild(life)
		
		// add the cat to the cats array
		self.remainingLifeNode.append(life)
		print("Life Count = \(remainingLifeNode.count)")
	}
	
	// Generating UFO
	func makeUfo() {
		// lets add some cats
		let ufo = SKSpriteNode(imageNamed: "ufo")
		
		
		ufo.position = CGPoint(x:0, y:self.size.height + 100)
		ufo.anchorPoint = CGPoint(x: 0, y: 0)
		
		// add the cat to the scene
		addChild(ufo)
		//---------------------------
		//CREATING PHYSICS AND MASKS
		//---------------------------
		ufo.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: ufo.size.width, height: ufo.size.height))
		ufo.name = "ufo"
		ufo.physicsBody?.affectedByGravity = false
		ufo.physicsBody?.affectedByGravity = false
		ufo.physicsBody?.allowsRotation = false
		ufo.physicsBody?.isDynamic = false
		ufo.physicsBody?.categoryBitMask = 2
		ufo.physicsBody?.collisionBitMask = 1
		ufo.physicsBody?.contactTestBitMask = 1
		
		//---------------------------
		//END CREATING PHYSICS AND MASKS
		//---------------------------
		// add the cat to the cats array
		self.ufos.append(ufo)
	}
	
	// Generating UFO2
	func makeUfo2() {
		// lets add some cats
		let ufo2 = SKSpriteNode(imageNamed: "ufo")
		
		
		ufo2.position = CGPoint(x:0, y: -(ufo2.size.height))
		ufo2.anchorPoint = CGPoint(x: 0, y: 0)
		
		// add the cat to the scene
		addChild(ufo2)
		//---------------------------
		//CREATING PHYSICS AND MASKS
		//---------------------------
		ufo2.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: ufo2.size.width, height: ufo2.size.height))
		ufo2.name = "ufo"
		ufo2.physicsBody?.affectedByGravity = false
		ufo2.physicsBody?.affectedByGravity = false
		ufo2.physicsBody?.allowsRotation = false
		ufo2.physicsBody?.isDynamic = false
		ufo2.physicsBody?.categoryBitMask = 2
		ufo2.physicsBody?.collisionBitMask = 1
		ufo2.physicsBody?.contactTestBitMask = 1
		
		//---------------------------
		//END CREATING PHYSICS AND MASKS
		//---------------------------
		// add the cat to the cats array
		self.ufos2.append(ufo2)
	}
	
	// Generting AirCraft
	func makeAirCraft() {
		// lets add some cats
		let airCraft = SKSpriteNode(imageNamed: "aircraft")
		
		airCraft.position = CGPoint(x:self.size.width, y:self.size.height + 100)
		airCraft.anchorPoint = CGPoint(x: 0, y: 0)
		
		// add the cat to the scene
		addChild(airCraft)
		//---------------------------
		//CREATING PHYSICS AND MASKS
		//---------------------------
		airCraft.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: airCraft.size.width, height: airCraft.size.height))
		airCraft.name = "aircraft"
		airCraft.physicsBody?.affectedByGravity = false
		airCraft.physicsBody?.affectedByGravity = false
		airCraft.physicsBody?.allowsRotation = false
		airCraft.physicsBody?.isDynamic = false
		airCraft.physicsBody?.categoryBitMask = 2
		airCraft.physicsBody?.collisionBitMask = 1
		airCraft.physicsBody?.contactTestBitMask = 1
		
		//---------------------------
		//END CREATING PHYSICS AND MASKS
		//---------------------------
		
		// add the cat to the cats array
		self.aircrafts.append(airCraft)
	}
	
	// Generting AirCraft2
	func makeAirCraft2() {
		// lets add some cats
		let airCraft2 = SKSpriteNode(imageNamed: "aircraft")
		
		airCraft2.position = CGPoint(x:self.size.width, y: -(airCraft2.size.height))
		airCraft2.anchorPoint = CGPoint(x: 0, y: 0)
		
		// add the cat to the scene
		addChild(airCraft2)
		//---------------------------
		//CREATING PHYSICS AND MASKS
		//---------------------------
		airCraft2.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: airCraft2.size.width, height: airCraft2.size.height))
		airCraft2.name = "aircraft"
		airCraft2.physicsBody?.affectedByGravity = false
		airCraft2.physicsBody?.affectedByGravity = false
		airCraft2.physicsBody?.allowsRotation = false
		airCraft2.physicsBody?.isDynamic = false
		airCraft2.physicsBody?.categoryBitMask = 2
		airCraft2.physicsBody?.collisionBitMask = 1
		airCraft2.physicsBody?.contactTestBitMask = 1
		
		//---------------------------
		//END CREATING PHYSICS AND MASKS
		//---------------------------
		
		// add the cat to the cats array
		self.aircrafts2.append(airCraft2)
	}
	
	// Generting Shuttles
	func makeShuttle() {
		// lets add some cats
		let shuttle = SKSpriteNode(imageNamed: "shuttle")
		
		shuttle.position = CGPoint(x:(self.size.width / 2), y:self.size.height + 100)
		shuttle.anchorPoint = CGPoint(x: 0, y: 0)
		// add the cat to the scene
		addChild(shuttle)
		shuttle.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: shuttle.size.width, height: shuttle.size.height))
		shuttle.name = "shuttle"
		shuttle.physicsBody?.affectedByGravity = false
		shuttle.physicsBody?.affectedByGravity = false
		shuttle.physicsBody?.allowsRotation = false
		shuttle.physicsBody?.isDynamic = false
		shuttle.physicsBody?.categoryBitMask = 2
		shuttle.physicsBody?.collisionBitMask = 1
		shuttle.physicsBody?.contactTestBitMask = 1
		
		// add the cat to the cats array
		self.shuttles.append(shuttle)
	}
	
	// Generting Shuttles2
	func makeShuttle2() {
		// lets add some cats
		let shuttle2 = SKSpriteNode(imageNamed: "shuttle")
		
		shuttle2.position = CGPoint(x:(self.size.width / 2), y:-(shuttle2.size.height))
		shuttle2.anchorPoint = CGPoint(x: 0, y: 0)
		// add the cat to the scene
		addChild(shuttle2)
		shuttle2.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: shuttle2.size.width, height: shuttle2.size.height))
		shuttle2.name = "shuttle"
		shuttle2.physicsBody?.affectedByGravity = false
		shuttle2.physicsBody?.affectedByGravity = false
		shuttle2.physicsBody?.allowsRotation = false
		shuttle2.physicsBody?.isDynamic = false
		shuttle2.physicsBody?.categoryBitMask = 2
		shuttle2.physicsBody?.collisionBitMask = 1
		shuttle2.physicsBody?.contactTestBitMask = 1
		
		// add the cat to the cats array
		self.shuttles2.append(shuttle2)
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
		background.position = CGPoint(x: 0, y: background.position.y - 10)
		background2.position = CGPoint(x: 0, y: background2.position.y - 10)
		
		// resetting background 1 position to top
		if(background.position.y < -(background.size.height)){
			background.position = CGPoint(x: 0, y: background2.position.y + background2.size.height)
		}
		
		// resetting background 2 position to top
		if(background2.position.y < -(background2.size.height)){
			background2.position = CGPoint(x: background2.position.x, y: background.position.y + background.size.height)
		}
	}
	var minutes = 0
	var seconds = 59
	@objc func updateTime() {
		
		if(timeLeft >= 0){
			minutes = (timeLeft / 60)
			seconds = (timeLeft % 60)
			if(seconds <= 9){
				timeLabel.text = "Time Left: " + String(minutes) + ":0" + String(seconds)
			} else {
				timeLabel.text = "Time Left: " + String(minutes) + ":" + String(seconds)
			}
			timeLeft -= 1
		}
		
		if(timeLeft <= -1) {
			timer.invalidate()
		}
		
	}
	
	var timer = Timer()
	override func didMove(to view: SKView) {
		
		//SOUNDS
		
		let ul1 = Bundle.main.url(forResource: "playershoot", withExtension: "wav")
		let ul2 = Bundle.main.url(forResource: "playerdie", withExtension: "wav")
		let ul3 = Bundle.main.url(forResource: "ufocoming", withExtension: "wav")
		let ul4 = Bundle.main.url(forResource: "ufodie", withExtension: "wav")
		let ul5 = Bundle.main.url(forResource: "stars", withExtension: "mp3")
		do{
			playershoot =
				try AVAudioPlayer(contentsOf: ul1!)
			playerdie =
				try  AVAudioPlayer(contentsOf: ul2!)
			ufocoming =
				try AVAudioPlayer(contentsOf: ul3!)
			ufodie =
				try  AVAudioPlayer(contentsOf: ul4!)
			bgmusic =
				try AVAudioPlayer(contentsOf: ul5!)
			playershoot.prepareToPlay()
			playerdie.prepareToPlay()
			ufocoming.prepareToPlay()
			ufodie.prepareToPlay()
			bgmusic.prepareToPlay()
		}
		catch{
			print("error")
		}
		///-END SOUNDS
		
		bgmusic.play()
		self.physicsWorld.contactDelegate = self
		self.createBackground()
		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTime), userInfo: nil, repeats: true)
		// Create player
		self.player.position = CGPoint(x: 0, y: 100)
		self.player.anchorPoint = CGPoint(x: 0, y: 0)
		player.name = "jet"
		
		addChild(self.player)
		
		self.player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width
			, height: player.size.height))
		self.player.physicsBody?.affectedByGravity = false
		self.player.physicsBody?.allowsRotation = false
		self.player.physicsBody?.isDynamic = false
		self.player.physicsBody?.categoryBitMask = 4
		self.player.physicsBody?.collisionBitMask = 8
		self.player.physicsBody?.contactTestBitMask = 8
		
		
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
		
		// generate group 2 of enemy
		for _ in 0...3 {
			makeUfo2()
		}
		
		// drawing AirCraft
		for _ in 0...5 {
			makeAirCraft2()
		}
		
		// draw shuttle
		for _ in 0...9 {
			makeShuttle2()
		}
		//time bomb
		timeBomb = SKSpriteNode(imageNamed: "bomb")
		timeBomb?.position.x = 0
		timeBomb?.position.y = 0
		timeBomb?.anchorPoint = CGPoint(x: 0, y: 0)
		addChild(timeBomb!)
		
		//Shield
		playerShield.anchorPoint = CGPoint(x: 0.5, y: 0)
		playerShield.position = CGPoint(x: (self.size.width / 2), y: 0)
		playerShield.size = CGSize(width: 64, height: 64)
		playerShield.name = "shield"
		addChild(playerShield)
		
		// Label for score
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.fontSize = 50
		scoreLabel.fontColor = UIColor.yellow
		scoreLabel.text = "Score: 0"
		scoreLabel.horizontalAlignmentMode = .left
		scoreLabel.verticalAlignmentMode = .top
		scoreLabel.position = CGPoint(x: 0, y: self.size.height)
		addChild(scoreLabel)
		
		// Label for time
		timeLabel = SKLabelNode(fontNamed: "Chalkduster")
		timeLabel.fontSize = 50
		timeLabel.fontColor = UIColor.yellow
		timeLabel.text = "Time Left: 2:00"
		timeLabel.horizontalAlignmentMode = .right
		timeLabel.verticalAlignmentMode = .top
		timeLabel.position = CGPoint(x: self.size.width, y: self.size.height)
		addChild(timeLabel)
		
		// add life to screen
		for i in 0...remainingLife - 1 {
			makeremainingLife(imgWidth: CGFloat(i+1))
		}
	}
	
	// variable to keep track of how much time has passed
	var timeOfLastUpdate:TimeInterval?
	// variable to keep track of how many ufo are there on screen
	var trackUfoCount = 0
	// variable to keep the x position of the last ufo
	var ufoInitialPosition:CGFloat = 225
	// variable to keep track of how many aircraft are there on screen
	var trackAirCraftCount = 0
	// variable to keep the x position of the last aircraft
	var airCraftInitialPosition:CGFloat = 175
	// variable to keep track of how many shuttle are there on screen
	var trackShuttleCount = 0
	// variable to keep the x position of the last shuttle
	var shuttleInitialPosition:CGFloat = 65
	
	// variable to keep track of how many ufo are there on screen
	var trackUfoCount2 = 0
	// variable to keep the x position of the last ufo
	var ufoInitialPosition2:CGFloat = 225
	// variable to keep track of how many aircraft are there on screen
	var trackAirCraftCount2 = 0
	// variable to keep the x position of the last aircraft
	var airCraftInitialPosition2:CGFloat = 175
	// variable to keep track of how many shuttle are there on screen
	var trackShuttleCount2 = 0
	// variable to keep the x position of the last shuttle
	var shuttleInitialPosition2:CGFloat = 65
	
	
	// Grid Animation for UFO
	func makeUfoAppear(heightPercent: CGFloat) {
		
		// Action Sequencing
		let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
		let m2 = SKAction.move(to: CGPoint(x: ufoInitialPosition, y: self.size.height * heightPercent), duration: 2)
		let sequence:SKAction = SKAction.sequence([m1, m2])
		
		// running animation for each ufo individually
		if (trackUfoCount <= 3){
			ufos[trackUfoCount].run(sequence)
			trackUfoCount += 1
			// getting initial position of ufo, for setting each ufo exactly beside the previous ufo on grid
			ufoInitialPosition = ufoInitialPosition + ufos[trackUfoCount-1].size.width
		}
	}
	
	// Grid Animation for UFO2
	func makeUfoAppear2(heightPercent: CGFloat) {
		
		// Action Sequencing
		let m2 = SKAction.move(to: CGPoint(x: ufoInitialPosition2, y: self.size.height * heightPercent), duration: 2)
		let sequence:SKAction = SKAction.sequence([m2])
		
		// running animation for each ufo individually
		if (trackUfoCount2 <= 3){
			ufos2[trackUfoCount2].run(sequence)
			trackUfoCount2 += 1
			// getting initial position of ufo, for setting each ufo exactly beside the previous ufo on grid
			ufoInitialPosition2 = ufoInitialPosition2 + ufos2[trackUfoCount2-1].size.width
		}
	}
	
	// Grid Animation for Air Craft
	func makeAirCraftAppear(heightPercent: CGFloat) {
		
		// Action Sequencing
		let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
		let m2 = SKAction.move(to: CGPoint(x: airCraftInitialPosition, y: self.size.height * heightPercent), duration: 2)
		let sequence:SKAction = SKAction.sequence([m1, m2])
		
		// running animation for each Air Craft individually
		if (trackAirCraftCount <= 5){
			aircrafts[trackAirCraftCount].run(sequence)
			trackAirCraftCount += 1
		}
		
		// getting initial position of aircraft, for setting each aircraft exactly beside the previous aircraft on grid
		airCraftInitialPosition = airCraftInitialPosition + aircrafts[trackAirCraftCount-1].size.width
	}
	
	// Grid Animation for Air Craft2
	func makeAirCraftAppear2(heightPercent: CGFloat) {
		
		// Action Sequencing
		let m2 = SKAction.move(to: CGPoint(x: airCraftInitialPosition2, y: self.size.height * heightPercent), duration: 2)
		let sequence:SKAction = SKAction.sequence([m2])
		
		// running animation for each Air Craft individually
		if (trackAirCraftCount2 <= 5){
			aircrafts2[trackAirCraftCount2].run(sequence)
			trackAirCraftCount2 += 1
		}
		
		// getting initial position of aircraft, for setting each aircraft exactly beside the previous aircraft on grid
		airCraftInitialPosition2 = airCraftInitialPosition2 + aircrafts2[trackAirCraftCount2-1].size.width
	}
	
	// Grid Animation for Shuttle
	func makeShuttleAppear(heightPercent: CGFloat) {
		
		// Action Sequencing
		let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: self.size.height / 2), duration: 2)
		let m2 = SKAction.move(to: CGPoint(x: shuttleInitialPosition, y: self.size.height * heightPercent), duration: 2)
		let sequence:SKAction = SKAction.sequence([m1, m2])
		
		// running animation for each shuttle individually
		if (trackShuttleCount <= 9){
			shuttles[trackShuttleCount].run(sequence)
			trackShuttleCount += 1
		}
		
		// getting initial position of shuttle, for setting each shuttle exactly beside the previous shuttle on grid
		shuttleInitialPosition = shuttleInitialPosition + shuttles[trackShuttleCount-1].size.width
	}
	
	// Grid Animation for Shuttle2
	func makeShuttleAppear2(heightPercent: CGFloat) {
		
		// Action Sequencing
		let m2 = SKAction.move(to: CGPoint(x: shuttleInitialPosition2, y: self.size.height * heightPercent), duration: 2)
		let sequence:SKAction = SKAction.sequence([m2])
		
		// running animation for each shuttle individually
		if (trackShuttleCount2 <= 9){
			shuttles2[trackShuttleCount2].run(sequence)
			trackShuttleCount2 += 1
		}
		
		// getting initial position of shuttle, for setting each shuttle exactly beside the previous shuttle on grid
		shuttleInitialPosition2 = shuttleInitialPosition2 + shuttles2[trackShuttleCount2-1].size.width
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
	
	var isUfoMovingRight2 = true
	func makeUfoMove2() {
		
		for i in 0...(ufos2.count - 1) {
			if(isUfoMovingRight2 == true){
				self.ufos2[i].position.x += 10
			} else if(isUfoMovingRight2 == false){
				self.ufos2[i].position.x -= 10
			}
		}
		
		// rebouncing of ufo from left to right on basis of first and last ufo in the array list
		if((ufos2.last?.position.x)! >= (self.size.width - (self.ufos2.first?.size.width)!)){
			isUfoMovingRight2 = false
		} else if((ufos2.first?.position.x)! <= 0) {
			isUfoMovingRight2 = true
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
	
	var isAirCraftMovingRight2 = false
	func makeAirCraftMove2() {
		for i in 0...(aircrafts2.count - 1) {
			if(isAirCraftMovingRight2 == true){
				self.aircrafts2[i].position.x += 10
			} else if(isAirCraftMovingRight2 == false){
				self.aircrafts2[i].position.x -= 10
			}
		}
		
		// rebouncing of aircraft from left to right on basis of first and last aircraft in the array list
		if((aircrafts2.last?.position.x)! >= (self.size.width - (self.aircrafts2.first?.size.width)!)){
			isAirCraftMovingRight2 = false
		} else if((aircrafts2.first?.position.x)! <= 0) {
			isAirCraftMovingRight2 = true
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
	
	var isShuttleMovingRight2 = true
	func makeShuttleMove2() {
		for i in 0...(shuttles2.count - 1) {
			if(isShuttleMovingRight2 == true){
				self.shuttles2[i].position.x += 10
			} else if(isShuttleMovingRight2 == false){
				self.shuttles2[i].position.x -= 10
			}
		}
		
		// rebouncing of shuttle from left to right on basis of first and last shuttl in the array list
		if((shuttles2.last?.position.x)! >= (self.size.width - (self.shuttles2.first?.size.width)!)){
			isShuttleMovingRight2 = false
		} else if((shuttles2.first?.position.x)! <= 0) {
			isShuttleMovingRight2 = true
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
		bullet.name = "bullet"
		bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bullet.size.width,height: bullet.size.height))
		bullet.physicsBody?.affectedByGravity = false
		bullet.physicsBody?.allowsRotation = false
		bullet.physicsBody?.categoryBitMask = 1
		bullet.physicsBody?.collisionBitMask = 2
		bullet.physicsBody?.contactTestBitMask = 2
		// add the cat to the cats array
		self.bullets.append(bullet)
	}
	
	// moving all bullets in the array by 30
	func moveBullet() {
		if(bullets.count != 0){
			for i in 0...(bullets.count - 1) {
				self.bullets[i].position.y = self.bullets[i].position.y + 30
				//remove bullet from scene
				if(bullets[i].position.y > self.size.height)
				{
					bullets[i].removeFromParent()
				}
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
		
		// lets add some bullets
		let airBullet = SKSpriteNode(imageNamed: "fireball")
		
		airBullet.position = CGPoint(x:(aircrafts[randomAirBullet].position.x + (aircrafts[randomAirBullet].size.width / 2)), y:aircrafts[randomAirBullet].position.y)
		
		// add the bullets to the scene
		addChild(airBullet)
		//---------------------------
		//CREATING PHYSICS AND MASKS
		//---------------------------
		airBullet.physicsBody = SKPhysicsBody(
			rectangleOf: CGSize(width: airBullet.size.width, height: airBullet.size.height))
		airBullet.name = "airbullet"
		airBullet.physicsBody?.affectedByGravity = false
		// airBullet.physicsBody?.allowsRotation = false
		//airBullet.physicsBody?.isDynamic = false
		airBullet.physicsBody?.categoryBitMask = 8
		//        airBullet.physicsBody?.collisionBitMask = 4
		//        airBullet.physicsBody?.contactTestBitMask = 4
		
		//---------------------------
		//END CREATING PHYSICS AND MASKS
		//---------------------------
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
	
	
	// -------------------
	// Making UFO move towards the player
	// -------------------
	var xd:CGFloat = 0
	var yd:CGFloat = 0
	var UFOremoveCount = 0
	var pastTime:TimeInterval?
	var isUfoInParent = true
	func enemyTowardsPlayer(time:TimeInterval){
		
		if (pastTime == nil) {
			pastTime = time
		}
		
		let timePassed = (time - pastTime!)
		if (timePassed >= 10 && ufos.count > 1) {
			
			let randomUFOMove = Int.random(in: 0...(ufos.count - 1))
			moveUFO = ufos[randomUFOMove]
			moveUFO.name = "coming"
			moveUFO.physicsBody?.categoryBitMask = 2
			moveUFO.physicsBody?.collisionBitMask = 1
			moveUFO.physicsBody?.contactTestBitMask = 1
			UFODown = 0
			ufocoming.play()
			ufos.remove(at: randomUFOMove)
			pastTime = time
			
			
		}
		
		for i in 0...ufos.count-1 {
			if(ufos[i].parent == nil){
				isUfoInParent = false
			} else if (ufos[i].parent != nil){
				isUfoInParent = true
			}
		}
		
		for i in 0...ufos2.count-1 {
			if(ufos2[i].parent == nil){
				isUfoInParent = false
			} else if (ufos2[i].parent != nil){
				isUfoInParent = true
			}
		}
		
		
		if(moveUFO != nil){
			let a = player.position.x - moveUFO.position.x
			// (y2-y1)
			let b = player.position.y - moveUFO.position.y
			// d
			let d = sqrt( (a*a) + (b*b))
			
			self.xd = a/d
			self.yd = b/d
			moveUFO.position.x = moveUFO.position.x + self.xd * 10
			moveUFO.position.y = moveUFO.position.y + (self.yd - 1.5) * 6}
		
	}
	
	//MOVING PLAYER ON TAP
	func movePlayerOnTap(speed:CGFloat,mousePos:CGPoint)
	{
		//  self.player.position.x += speed
		
		let a =  mousePos.x - player.position.x
		// (y2-y1)
		let b = mousePos.y - player.position.y
		// d
		let d = sqrt( (a*a) + (b*b))
		
		self.xd = a/d
		self.yd = b/d
		player.position.x = player.position.x + self.xd * speed
		player.position.x = (player.position.x + self.yd * speed)
		//        if(self.player.position.x >= (self.size.width - self.player.size.width)){
		//            PLspeed = 0
		//        } else if(self.player.position.x <= 0) {
		//            PLspeed = 0
		//        }
	}
	func didBegin(_ contact: SKPhysicsContact) {
		let objectA = contact.bodyA.node!
		let objectB = contact.bodyB.node!
		// COLLISION WITH UFO
		if (objectA.name == "bullet" && objectB.name == "ufo") {
			// print("GAME OVER!")
			objectB.removeFromParent()
			objectA.removeFromParent()
			playerScore += 100
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
			
		}
		else if (objectA.name == "ufo" && objectB.name == "bullet") {
			//print("GAME OVER!")
			objectA.removeFromParent()
			objectB.removeFromParent()
			playerScore += 100
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
			
		}
		if (objectA.name == "bullet" && objectB.name == "coming") {
			print("DEAD OVER!")
			objectB.removeFromParent()
			objectA.removeFromParent()
			moveUFO.physicsBody = nil
			playerScore += 200
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
			
		}
		else if (objectA.name == "coming" && objectB.name == "bullet") {
			print("DEAD OVER!")
			objectA.removeFromParent()
			objectB.removeFromParent()
			moveUFO.physicsBody = nil
			playerScore += 200
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
			
		}
		// COLLISION WITH AIRCRAFT
		if (objectA.name == "bullet" && objectB.name == "aircraft") {
			// print("GAME OVER!")
			objectB.removeFromParent()
			objectA.removeFromParent()
			playerScore += 50
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
			
		}
		else if (objectA.name == "aircraft" && objectB.name == "bullet") {
			// print("GAME OVER!")
			objectA.removeFromParent()
			objectB.removeFromParent()
			playerScore += 50
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
			
		}
		
		// COLLISION WITH SHUTTLE
		if (objectA.name == "bullet" && objectB.name == "shuttle") {
			// print("GAME OVER!")
			objectB.removeFromParent()
			objectA.removeFromParent()
			playerScore += 20
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
		}
		else if (objectA.name == "shuttle" && objectB.name == "bullet") {
			// print("GAME OVER!")
			objectA.removeFromParent()
			objectB.removeFromParent()
			playerScore += 20
			scoreLabel.text = ("\(playerScore)")
			ufodie.play()
		}
		
		
		//        // ENEMY BULLET WITH PLAYER
		//         if (objectA.name == "airbullet" && objectB.name == "jet") {
		//            print("PLAYER DIE")
		//          //  objectB.removeFromParent()
		//          // objectA.removeFromParent()
		//            //decrease player life
		//        }
		//        else if (objectA.name == "jet" && objectB.name == "airbullet") {
		//            print("PLAYER DIE")
		//         // objectA.removeFromParent()
		//       //   objectB.removeFromParent()
		//
		//        }
		
		
		//        else if (objectA.name == "cat" && objectB.name == "bed") {
		//            print("YOU WIN")
		//            // stop moving the cat when game wins
		//            objectA.physicsBody?.isDynamic = false
		//        }
		//        else if (objectA.name == "bed" && objectB.name == "cat") {
		//            print("YOU WIN")
		//            // stop moving the cat when game wins
		//            objectB.physicsBody?.isDynamic = false;
		//        }
		// GAME WIN RULES
	}
	
	//FUNCTION TO REMOVE THE PLAYER FROM SCENE AND DECREASE THE LIVES
	func decreasePlayerLifeCount(live:Bool){
		if(decreaseLivescount == true ){
			//removing from scene
			remainingLifeNode.last?.removeFromParent()
			
			//removing from array
			self.remainingLifeNode.remove(at: self.remainingLifeNode.count - 1)
			print(" show \(self.remainingLifeNode.count)")
			print(" flag before \(decreaseLivescount) ")
			playerdie.play()
			player.position = CGPoint(x: 400, y: 100)
			addChild(self.player)
			//RESTARTING THE SCENE IF PLAYER LIVES ARE OVER
			if(remainingLifeNode.count == 0)
			{
				//ADD A GAME OVER SCENE
				let scene = SKScene(fileNamed: "lose")
				scene!.scaleMode = .aspectFill
				
				let flipTransition = SKTransition.flipVertical(withDuration: 2)
				
				self.scene?.view?.presentScene(scene!, transition: flipTransition)
			}
			decreaseLivescount = false;
			print(" flag after \(decreaseLivescount) ")
		}
	}
	
	
	
	// Variables to set grids and firing aricraft bullet at random time
	var isGridSet = false
	var isGridSetTimer:TimeInterval?
	
	var isGridSet2 = false
	var isGridSetTimer2:TimeInterval?
	
	var bulletTime:TimeInterval?
	var playerBulletTime:TimeInterval?
	var ufoCollideTime:TimeInterval?
	
	var onDeploy: TimeInterval?
	var canDeployerBomb = false
	
	var gameTime: TimeInterval?
	var shieldActivateTime: TimeInterval?
	var blastTime: TimeInterval?
	var blastCountDown = 6
	// ---------------------
	// UPDATE FUNCTION
	//--------------------
	
	override func update(_ currentTime: TimeInterval) {
		
		//CHECKING GAME WIN CONDITION
		if((self.childNode(withName: "aircraft")) == nil
			&&
			(self.childNode(withName: "ufo") == nil)
			&&
			(self.childNode(withName: "shuttle") == nil)
			&&
			(self.childNode(withName: "aircraft2")) == nil
			&&
			(self.childNode(withName: "ufo2") == nil)
			&&
			(self.childNode(withName: "shuttle2") == nil))
		{
			//ADD THE GAME WON SCENE
			print("WON")
			
			let scene = SKScene(fileNamed: "win")
			scene!.scaleMode = .aspectFill
			
			let flipTransition = SKTransition.flipVertical(withDuration: 2)
			
			self.scene?.view?.presentScene(scene!, transition: flipTransition)
			
		}
		if (ufoCollideTime == nil) {
			ufoCollideTime = currentTime
		}
		// Called before each frame is rendered
		self.moveBackground()
		
		// call player move
		//self.makePlayerMove()
		
		if (timeOfLastUpdate == nil) {
			timeOfLastUpdate = currentTime
		}
		// print a message every 3 seconds
		let timePassed = (currentTime - timeOfLastUpdate!)
		
		if (timePassed >= 2) {
			timeOfLastUpdate = currentTime
			// Make Ufo Appear on screen
			makeUfoAppear(heightPercent: 0.9)
			// Make airCraft Appear on screen
			makeAirCraftAppear(heightPercent: 0.8)
			// Make Shuttle Appear on screen
			makeShuttleAppear(heightPercent: 0.7)
		}
		
		
		if (gameTime == nil) {
			gameTime = currentTime
		}
		// print a message every 3 seconds
		let gameTimePassed = (currentTime - gameTime!)
		
		if (gameTimePassed >= 60) {
			
			// Make Ufo Appear on screen
			makeUfoAppear2(heightPercent: 0.85)
			// Make airCraft Appear on screen
			makeAirCraftAppear2(heightPercent: 0.75)
			// Make Shuttle Appear on screen
			makeShuttleAppear2(heightPercent: 0.65)
		}
		
		
		if(isShieldActive == true && canActivateShield == true){
			if(timeForShieldActive == nil){
				timeForShieldActive = currentTime
			}
			
			let activeShieldTimePassed = (currentTime - timeForShieldActive!)
			
			if(activeShieldTimePassed >= 10){
				timeForShieldActive = currentTime
				self.player.removeAllChildren()
				isShieldActive = false
			}
		} else if (isShieldActive == false) {
			timeForShieldActive = nil
			canActivateShield = false
		}
		
		
		
		if(shieldActivateTime == nil){
			shieldActivateTime = currentTime
		}
		
		let activeShieldTime = (currentTime - shieldActivateTime!)
		
		if(activeShieldTime > 10){
			if(canActivateShield == true){
				canActivateShield = false
			}
			else if(canActivateShield == false){
				canActivateShield = true
			}
			//print("\(activeShieldTime) : \(canActivateShield) : \(isShieldActive)")
		}
		
		
		
		// gird setting flag
		if(trackUfoCount == 4 && trackAirCraftCount == 6  && trackShuttleCount == 10){
			if (isGridSetTimer == nil) {
				isGridSetTimer = currentTime
			}
			let gridTimePassed = (currentTime - isGridSetTimer!)
			if(gridTimePassed >= 5) {
				isGridSet = true
				isGridSetTimer = currentTime
			}
		}
		
		// calling functions to make enemies start moving
		if(isGridSet == true){
			makeUfoMove()
			makeAirCraftMove()
			makeShuttleMove()
			moveBullet()
			moveAirCraftBullet()
			
			//calling the enemy move functon
			enemyTowardsPlayer(time: currentTime)
			
		}
		
		
		// gird setting flag
		if(trackUfoCount2 == 4 && trackAirCraftCount2 == 6  && trackShuttleCount2 == 10){
			if (isGridSetTimer2 == nil) {
				isGridSetTimer2 = currentTime
			}
			let gridTimePassed2 = (currentTime - isGridSetTimer2!)
			if(gridTimePassed2 >= 5) {
				isGridSet2 = true
				isGridSetTimer2 = currentTime
			}
		}
		
		// calling functions to make enemies start moving
		if(isGridSet2 == true){
			makeUfoMove2()
			makeAirCraftMove2()
			makeShuttleMove2()
			
			//calling the enemy move functon
			// enemyTowardsPlayer(time: currentTime)
			
		}
	
		//PLAYER AUTOMATIC BULLET
		if (playerBulletTime == nil) {
			playerBulletTime = currentTime
		}
		let PLbulletTimePassed = (currentTime - playerBulletTime!)
		if(PLbulletTimePassed >= 0.5 && isGridSet == true) {
			
			//AUTOMATIC BULLETS
			let playerX = self.player.position.x + (self.player.size.width / 2)
			let playerY = self.player.position.y + (self.player.size.height / 2)
			//making bullets only if player lives are left
			if(remainingLifeNode.count != 0){
				makeBullet(xPosition: playerX, yPosition: playerY)
				playershoot.play()
				
			}
			playerBulletTime = currentTime
		}
		//END PLAYER AUTOMATIC BULLET ------------------
	
		if (bulletTime == nil) {
			bulletTime = currentTime
		}
		
		let bulletTimePassed = (currentTime - bulletTime!)
		if(bulletTimePassed >= 5 && isGridSet == true) {
			//makeAirCraftBullet()
			
			bulletTime = currentTime
		}
		
		//PLAYER MOVEMENT
		if(mousePosition != nil){
			movePlayerOnTap(speed: PLspeed,mousePos: mousePosition!)
		}
		//Detecting intersection with ufo
		if(moveUFO != nil){
			
			// print a message every 3 seconds
			let collidehapped = (currentTime - ufoCollideTime!)
			
			
			
			if (self.player.intersects(moveUFO) == true && (moveUFO.physicsBody != nil)){
				// ufo die
				if (collidehapped >= 5) {
					moveUFO.removeFromParent()
					//    moveUFO.physicsBody = nil
					//player die
					player.removeFromParent()
					//live decrease
					//UFOCount += 1
					decreaseLivescount = true
					ufoCollideTime = currentTime
				}
			}
			
		}
		
		//taking count because it collides too many times
		decreasePlayerLifeCount(live:decreaseLivescount)
		
		if (onDeploy == nil) {
			onDeploy = currentTime
		}
		let beforeDeployTime = (currentTime - onDeploy!)
		if(beforeDeployTime >= 5) {
			canDeployerBomb = true
			onDeploy = nil
			print("Can Deploy Bomb")
		}
		
		if(isdeployed == true){
			if (blastTime == nil) {
				blastTime = currentTime
			}
			let afterDeployTime = (currentTime - blastTime!)
			if(afterDeployTime >= 1) {
				blastTime = currentTime
				blastCountDown -= 1
				//print("\(blastCountDown)")
			}
			
			if(blastCountDown == 0){
				print("BOOM!!!")
				if(randomEnemy != nil){
					if(randomEnemy == 0){
						//print("\(ufocnt / 2)")
						if(ufocnt <= 4){
						for i in 0...ufos.count-1{
							if(i%2 == 0){
								if(ufos[i].parent != nil){
									ufos[i].removeFromParent()
									//ufos.remove(at: i)
									//trackUfoCount -= 1
								}
							}
							ufocnt -= 1
						}
						} else {
							if(ufocnt >= ufocnt / 2){
							for i in 0...ufos.count-1{
								if(i%2 == 0){
									if(ufos[i].parent != nil){
										ufos[i].removeFromParent()
										//ufos.remove(at: i)
										//trackUfoCount -= 1
									}
								}
								ufocnt -= 1
							}
							} else {
								for i in 0...ufos2.count-1{
									if(i%2 == 0){
										if(ufos2[i].parent != nil){
											ufos2[i].removeFromParent()
//ufos2.remove(at: i)
											///trackUfoCount2 -= 1
										}
									}
									ufocnt -= 1
								}
							}
						}
					} else if(randomEnemy == 1){
						//print("\(aircnt / 2)")
						if(aircnt <= 6){
							for i in 0...aircrafts.count-1{
								if(i%2 == 0){
									if(aircrafts[i].parent != nil){
										aircrafts[i].removeFromParent()
										//aircrafts.remove(at: i)
										//trackAirCraftCount -= 1
									}
								}
								aircnt -= 1
							}
						} else {
							if(aircnt >= aircnt / 2){
								for i in 0...aircrafts.count-1{
									if(i%2 == 0){
										if(aircrafts[i].parent != nil){
											aircrafts[i].removeFromParent()
											//aircrafts.remove(at: i)
											//trackAirCraftCount -= 1
										}
									}
									aircnt -= 1
								}
							} else {
								for i in 0...aircrafts2.count-1{
									if(i%2 == 0){
										if(aircrafts2[i].parent != nil){
											aircrafts2[i].removeFromParent()
											//aircrafts2.remove(at: i)
											//trackAirCraftCount2 -= 1
										}
									}
									aircnt -= 1
								}
							}
						}
					} else if(randomEnemy == 2) {
					//	print("\(shuttlecnt / 2)")
						if(shuttlecnt <= 10){
							for i in 0...shuttles.count-1{
								if(i%2 == 0){
									if(shuttles[i].parent != nil){
										shuttles[i].removeFromParent()
										//shuttles.remove(at: i)
										//trackShuttleCount -= 1
									}
								}
								shuttlecnt -= 1
							}
						} else {
							if(shuttlecnt >= shuttlecnt / 2){
								for i in 0...shuttles.count-1{
									if(i%2 == 0){
										if(shuttles[i].parent != nil){
											shuttles[i].removeFromParent()
											//shuttles.remove(at: i)
											//trackShuttleCount -= 1
										}
									}
									shuttlecnt -= 1
								}
							} else {
								for i in 0...shuttles2.count-1{
									if(i%2 == 0){
										if(shuttles2[i].parent != nil){
											shuttles2[i].removeFromParent()
											//shuttles2.remove(at: i)
											//trackShuttleCount2 -= 1
										}
									}
									shuttlecnt -= 1
								}
							}
						}
					}
				}
			}
		}
		
		
		if(remainingLife == 0){
			print("Lose1")
			let scene = SKScene(fileNamed: "lose")
			scene!.scaleMode = .aspectFill
			
			let flipTransition = SKTransition.flipVertical(withDuration: 2)
			
			self.scene?.view?.presentScene(scene!, transition: flipTransition)
		}
		
		if(timeLeft <= 0){
			print("Lose2")
			var ufore = 0
			var aircraftre = 0
			var shuttlere = 0
			
			for i in 0...ufos.count-1 {
				if(ufos[i].parent != nil){
					ufore += 1
				}
			}
			
			for i in 0...ufos2.count-1 {
				if(ufos2[i].parent != nil){
					ufore += 1
				}
			}
			
			for i in 0...aircrafts.count-1 {
				if(aircrafts[i].parent != nil){
					aircraftre += 1
				}
			}
			
			for i in 0...aircrafts2.count-1 {
				if(aircrafts2[i].parent != nil){
					aircraftre += 1
				}
			}
			
			for i in 0...shuttles.count-1 {
				if(shuttles[i].parent != nil){
					shuttlere += 1
				}
			}
			
			for i in 0...shuttles2.count-1 {
				if(shuttles2[i].parent != nil){
					shuttlere += 1
				}
			}
			
			if (ufore > 0 ||  aircraftre > 0 || shuttlere > 0) {
				print ("you lose1234")
			let scene = SKScene(fileNamed: "lose")
			scene!.scaleMode = .aspectFill
			
			let flipTransition = SKTransition.flipVertical(withDuration: 2)
			
			self.scene?.view?.presentScene(scene!, transition: flipTransition)
			} else if (ufore == 0 &&  aircraftre == 0 && shuttlere == 0) {
				//print ("you Win")
				let scene = SKScene(fileNamed: "win")
				scene!.scaleMode = .aspectFill
				
				let flipTransition = SKTransition.flipVertical(withDuration: 2)
				
				self.scene?.view?.presentScene(scene!, transition: flipTransition)
			}
		}
		
	}
	
	
	var mousePosition:CGPoint?
	
	
	// Generating Shield Sprite
	func makePlayerShield() {
		let onPlayerShield = SKSpriteNode(imageNamed: "shield")
		onPlayerShield.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		onPlayerShield.position = CGPoint(x: (self.player.size.width / 2), y: (self.player.size.height / 2))
		onPlayerShield.size = CGSize(width: 100, height: 100)
		onPlayerShield.name = "onPlayerShield"
		onPlayerShield.physicsBody = SKPhysicsBody(circleOfRadius: onPlayerShield.size.width / 2)
		onPlayerShield.physicsBody?.affectedByGravity = false
		onPlayerShield.physicsBody?.isDynamic = false
		onPlayerShield.physicsBody?.allowsRotation = false
		onPlayerShield.physicsBody?.contactTestBitMask = 0
		onPlayerShield.physicsBody?.collisionBitMask = 0
		// addChild(onPlayerShield)
		self.player.addChild(onPlayerShield)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		mousePosition = touches.first?.location(in: self)
		
		//PLspeed = 20
		
		let center = self.size.width / 2
		if(mousePosition!.x < center) {
			// MOve Left
			if(self.player.position.x >= 0) {
			self.player.position.x -= 40
			}
		} else if (mousePosition!.x > center) {
			// Move right
			if((self.player.position.x) <= (self.size.width - self.player.size.width)) {
				self.player.position.x += 40
			}
		}
		
		
		
		// 1. Dectect what sprit was touched
		let spriteTouched = self.atPoint(mousePosition!)
		
		// 2. check if he touched tree
		if(spriteTouched.name == "shield")
		{
			isShieldActive = true
			if(canActivateShield == true){
				makePlayerShield()
				canActivateShield = false
			}
		}
	}
	
	
	// getting if user moved the tap or not
	var isTouchMOved = false
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		isTouchMOved = true
	}
	
	// mass destruction weapon
	func makeBomb() {
		//time bomb
		deployBomb = SKSpriteNode(imageNamed: "bomb")
		deployBomb?.position.x = self.size.width / 2
		deployBomb?.position.y = -((deployBomb?.size.height)!)
		deployBomb?.anchorPoint = CGPoint(x: 0.5, y: 0)
		addChild(deployBomb!)
	}
	
	// deploying the MDW
	func moveBombToTop() {
		// Action Sequencing
		if(bombcnt < 1){
		let m2 = SKAction.move(to: CGPoint(x: (self.size.width / 2), y: self.size.height * 0.95), duration: 2)
		let sequence:SKAction = SKAction.sequence([m2])
		isdeployed = true
		deployBomb!.run(sequence)
		} else {
			deployBomb?.removeFromParent()
		}
	}
	
	// counters for remaining sprites on the screen
	var ufocnt = 0
	var aircnt = 0
	var shuttlecnt = 0
	var isdeployed = false
	
	// randomly pick either of the enemy to kill with MDW
	var bombcnt = 0
	var randomEnemy: Int?
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if(isTouchMOved == true){
			if(canDeployerBomb == true && bombcnt < 1){
				
				// randomm number generator
				randomEnemy = Int.random(in: 0...2)
				makeBomb()
				moveBombToTop()
				
				//print("Bomb Deployed")
				if (randomEnemy == 0) {
					//print("\(ufos.count) :: \(ufos2.count)")
					for i in 0...ufos.count-1{
						if (ufos[i].parent != nil){
							ufocnt += 1
						}
					}
					if(minutes <= 1 && seconds <= 0){
					for i in 0...ufos2.count-1{
						if (ufos2[i].parent != nil){
							ufocnt += 1
						}
					}
					}
					//print("ufo cnt = \(ufocnt)")
				} else if (randomEnemy == 1) {
					//print("\(aircrafts.count) :: \(aircrafts2.count)")
					for i in 0...aircrafts.count-1{
						if (aircrafts[i].parent != nil){
							aircnt += 1
						}
					}
					if(minutes <= 1 && seconds <= 0){
					for i in 0...aircrafts2.count-1{
						if (aircrafts2[i].parent != nil){
							aircnt += 1
						}
					}
					}
				//	print("Air Craft cnt = \(aircnt)")
				} else if (randomEnemy == 2) {
				//	print("\(shuttles.count) :: \(shuttles2.count)")
					for i in 0...shuttles.count-1{
						if (shuttles[i].parent != nil){
							shuttlecnt += 1
						}
					}
					if(minutes <= 1 && seconds <= 0){
					for i in 0...shuttles2.count-1{
						if (shuttles2[i].parent != nil){
							shuttlecnt += 1
						}
					}
					}
					//print("Shuttle cnt = \(shuttlecnt)")
				}
				bombcnt += 1
				canDeployerBomb = false
			}
		}
	}
}
