//
//  GameViewController.swift
//  Tetris
//
//  Created by Phuc .Ng on 12/15/15.
//  Copyright (c) 2015 Phuc .Ng. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, DieuKhienDelegate, UIGestureRecognizerDelegate {
    
    var scene: GameScene!
    var dieukhien:DieuKhien!
    var panPointReference:CGPoint?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.tick = didTick
        
        dieukhien = DieuKhien()
        dieukhien.delegate = self
        dieukhien.beginGame()
        
        // scene start
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    func didTick() {
        dieukhien.letShapeFall()
    }
    
    @IBAction func didPan(sender: AnyObject) {
        
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    dieukhien.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    dieukhien.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    
    
    @IBAction func didTap(sender: AnyObject) {
        
        dieukhien.rotateShape()
    }
    
    @IBAction func didSwipe(sender: AnyObject) {
        dieukhien.dropShape()
        
        
    }
    func nextShape() {
        let newShapes = dieukhien.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
        self.scene.movePreviewShape(fallingShape) {
            self.view.userInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(dieukhien: DieuKhien) {
        if dieukhien.nextShape != nil && dieukhien.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(dieukhien.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(dieukhien: DieuKhien) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(dieukhien: DieuKhien) {
        
    }
    
    func gameShapeDidDrop(dieukhien: DieuKhien) {
        
    }
    
    func gameShapeDidLand(dieukhien: DieuKhien) {
        scene.stopTicking()
        nextShape()
    }
    
    
    func gameShapeDidMove(dieukhien: DieuKhien) {
        scene.redrawShape(dieukhien.fallingShape!) {}
    }
}
