//
//  GameScene.swift
//  NOC_v1
//
//  Created by Aaron Brown on 7/27/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let NumVehicles = 20
    let worldNode = SKNode()
    var vehicles = [Vehicle]()
    
    override func didMoveToView(view: SKView) {

        
        backgroundColor = SKColor.whiteColor()

        addChild(worldNode)

        for var index = 0; index < NumVehicles; index++ {
            let xPos = Int.random( min: 0, max: Int(size.width) )
            let yPos = Int.random( min: 0, max: Int(size.height) )
            let mass = CGFloat(Int.random(min: 1, max: 5)) / CGFloat(Int.random(min: 2, max: 5))
            var vehicle = Vehicle(scene: self, mass: mass, x: xPos, y: yPos)

            println(mass)
            vehicles.append(vehicle)
            worldNode.addChild(vehicle)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for vehicle in vehicles {
            vehicle.cycleBoundaryInteraction()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        for vehicle in vehicles {
            vehicle.applyForce(CGVector(dx: 10, dy: 0))
            vehicle.applyForce(CGVector(dx: 0, dy: -100.0 * vehicle.mass ))
            vehicle.update(currentTime)
        }
    }
    
    func leftEdge() -> CGFloat {
        return frame.minX
    }
    
    func rightEdge() -> CGFloat {
        return frame.maxX
    }
    
    func topEdge() -> CGFloat {
        return frame.maxY
    }
    
    func bottomEdge() -> CGFloat {
        return frame.minY
    }

}
