//
//  CG+Extensions.swift
//  Steering_1
//
//  Created by Aaron Brown on 7/25/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import Foundation
import UIKit

// MARK: Int

public extension Int {
    
    /**
    * Returns a random integer between 0 and n-1.
    */
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    /**
    * Returns a random integer in the range min...max, inclusive.
    */
    public static func random(#min: Int, max: Int) -> Int {
        assert(min < max)
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}


// MARK: CGPoint
public extension CGPoint {
    public func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }

    public func distanceTo(point: CGPoint) -> CGFloat {
        return (self - point).length()
    }
}

public func + (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

public func += (inout left: CGPoint, right: CGVector) {
    left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -= (inout left: CGPoint, right: CGPoint) {
    left = left - right
}


public func - (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

public func -= (inout left: CGPoint, right: CGVector) {
    left = left - right
}


// MARK: CGVector
public extension CGVector {
    public func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    public func lengthSquared() -> CGFloat {
        return dx*dx + dy*dy
    }
    
    public mutating func normalize() -> CGVector {
        self = normalized()
        return self
    }
    
    func normalized() -> CGVector {
        let len = length()
        return len>0 ? self / len : CGVector.zeroVector
    }
    
    public func perp() -> CGVector {
        if (dx == 0 && dy == 0) {
            return self
        } else {
            return CGVector(dx: dy * -1, dy: dx)
        }
    }
    
    public mutating func clamp(upperBound: CGFloat) -> CGVector {
        self.dx = max(-upperBound, min(upperBound, dx))
        self.dy = max(-upperBound, min(upperBound, dy))
        return self
    }
}

public func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

public func += (inout left: CGVector, right: CGVector) {
    left = left + right
}

public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

public func *= (inout vector: CGVector, scalar: CGFloat) {
    vector = vector * scalar
}

public func * (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

public func *= (inout left: CGVector, right: CGVector) {
    left = left * right
}

public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}






