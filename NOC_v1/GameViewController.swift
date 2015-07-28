//
//  GameViewController.swift
//  NOC_v1
//
//  Created by Aaron Brown on 7/27/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    
    // override this because the bounds of the view will be correct!
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if skView.scene == nil {
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.ignoresSiblingOrder = true

                let scene = GameScene(size: skView.bounds.size)
                scene.scaleMode = SKSceneScaleMode.ResizeFill // we just want the entire area to be active for simulation
                skView.presentScene(scene)
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}