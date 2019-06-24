//
//  lose.swift
//  Galaga
//
//  Created by Harsh Parikh on 2019-06-24.
//  Copyright © 2019 Pranav Patel. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class lose: SKScene {
	override func didMove(to view: SKView) {
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		//let touch = touches.first?.location(in: self)
		
		let scene = SKScene(fileNamed: "GameScene")
		scene!.scaleMode = .aspectFill
		
		let flipTransition = SKTransition.flipVertical(withDuration: 2)
		
		self.scene?.view?.presentScene(scene!, transition: flipTransition)
		
	}
}
