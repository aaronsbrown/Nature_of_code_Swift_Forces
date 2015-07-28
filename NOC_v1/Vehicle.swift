//
//  Vehicle.swift
//  Steering_1
//
//  Created by Aaron Brown on 7/25/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import Foundation
import SpriteKit

enum BoundaryInteraction {
    case Bounce
    case WrapAround
}

class Vehicle:SKNode {
    
    let MaxAcceleration: CGFloat = 1000
    let MaxVelocity: CGFloat = 300
    
    let sprite = SKSpriteNode(imageNamed: "dot")
    var boundaryInteraction: BoundaryInteraction = .Bounce
    var gameWorld: GameScene!
    
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
    var mass: CGFloat!
    var acceleration: CGVector = CGVector()
    var velocity: CGVector = CGVector()
    var heading: CGVector = CGVector()
    var side: CGVector = CGVector()
    
    var size: CGSize {
        get {
            return sprite.size
        }
    }
    
    convenience init(scene: GameScene) {
        let startX = Int.random( min: 0, max: Int(scene.size.width) )
        let startY = Int.random( min: 0, max: Int(scene.size.height) )
        self.init(scene: scene, mass: 1, x: startX, y: startY)
    }
    
    init(scene: GameScene, mass: CGFloat, x: Int, y: Int) {
        super.init()
        
        self.gameWorld = scene
        self.mass = mass
        self.position = CGPoint(x: x, y: y)
    
        sprite.size.width *= mass
        sprite.size.height *= mass
        addChild(sprite)
    }

    func applyForce(force: CGVector) {
        acceleration += force / mass
        acceleration.clamp(MaxAcceleration)
    }
    
    func update(currentTime: CFTimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }
        lastUpdateTime = currentTime
        
        velocity += acceleration * CGFloat(dt)
        velocity.clamp(MaxVelocity)

        position += velocity * CGFloat(dt)
        acceleration *= 0
        
        // ensure heading vector is updated if possible, if value is 0, we can normalize
        // if value is extremely small erractic movement may result
        if (velocity.lengthSquared() > 0.00000001) {
            heading = velocity.normalized()
            side = heading.perp()
        }
        
        switch boundaryInteraction {
            case .Bounce:
                bounce()
                break
            case .WrapAround:
                wrapAround()
                break
        }
    }
    
    func cycleBoundaryInteraction() {
        if boundaryInteraction == .Bounce {
            boundaryInteraction = .WrapAround
        } else {
            boundaryInteraction = .Bounce
        }
    }
    
    func bounce() {
        
        if rightSide() > gameWorld.rightEdge() {
            velocity.dx *= -1
            position.x = gameWorld.rightEdge() - size.width / 2
        } else if leftSide() < gameWorld.leftEdge() {
            velocity.dx *= -1
            position.x = gameWorld.leftEdge() + size.width / 2
        }
        
        if topSide() > gameWorld.topEdge() {
            velocity.dy *= -1
            position.y  = gameWorld.topEdge() - size.height / 2
        } else if bottomSide() < gameWorld.bottomEdge() {
            velocity.dy *= -1
            position.y = gameWorld.bottomEdge() + size.height / 2
        }
    }
    
    func wrapAround() {
        
        if leftSide() > gameWorld.rightEdge() {
            position.x = gameWorld.leftEdge() - size.width / 2
        } else if rightSide() < gameWorld.leftEdge() {
            position.x = gameWorld.rightEdge() + size.width / 2
        }
        
        if bottomSide() > gameWorld.topEdge() {
            position.y = gameWorld.bottomEdge() - size.height / 2
        } else if topSide() < gameWorld.bottomEdge() {
            position.y = gameWorld.topEdge() + size.height / 2
        }
    }
    
    func leftSide() -> CGFloat {
        return position.x - size.width / 2
    }
    
    func rightSide() -> CGFloat {
        return position.x + size.width / 2
    }
    
    func bottomSide() -> CGFloat {
        return position.y - size.height / 2
    }
    
    func topSide() -> CGFloat {
        return position.y + size.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
