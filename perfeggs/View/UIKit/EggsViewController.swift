//
//  EggsViewController.swift
//  perfeggs
//
//  Created by Martin Bjeld on 17/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

import UIKit
import UIKit.UIGestureRecognizerSubclass


class ForceTouchGestureRecognizer: UIGestureRecognizer {
    
    private(set) var forceValue: CGFloat? // value between 0.0 - 1.0
    
    var minimumValue: CGFloat = 0 // Value between 0.0 - 1.0 that needs to be reached before gesture begins
    var tolerance: CGFloat = 1 // Once force drops below maxValue - tolerance, the gesture ends
    
    
    
    override func reset() {
        super.reset()
        forceValue = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        
        super.touchesBegan(touches, with: event)
        
        if #available(iOS 9.0, *) {
            if touches.count != 1 {
                state = .failed
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if #available(iOS 9.0, *) {
            
            let touch = touches.first!
            let value = touch.force / touch.maximumPossibleForce
            
            if state == .possible {
                if value > minimumValue {
                    state = .began
                }
            } else {
                let norm = min(value.normalize(min: 0, max: 0.20, from: 0.5, to: 1),1)
                self.forceValue = norm
                state = .changed
            }
        }
    }
    
 
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        if state == .began || state == .changed {
            state = .cancelled
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        if state == .began || state == .changed {
            self.forceValue = 0
            state = .ended
        }
    }
}

       
struct EggsViewController:UIViewControllerRepresentable {
    
    var forceValue:Binding<CGFloat>
    var wasOver = false
    
    class Coordinator:NSObject {
        var parent:EggsViewController
        
        @objc func triggerTouchAction(gestureReconizer: ForceTouchGestureRecognizer) {
            if let value = gestureReconizer.forceValue {
                parent.forceValue.wrappedValue = value
                
                if(parent.wasOver && value < 0.1) {
                    parent.wasOver = false
                }
                
                if !parent.wasOver && value > 0.60 {
                    parent.wasOver = true
                }
            }
        }
        
        init(_ parent:EggsViewController) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<EggsViewController>) -> UIViewController {
        let uiViewController = UIViewController()
        //uiViewController.view.backgroundColor = .white
        
        let forceTouchGesture = ForceTouchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.triggerTouchAction(gestureReconizer:)))
        forceTouchGesture.minimumValue = 0.0     // Minimum force value before touch is recognised
        forceTouchGesture.tolerance = 1        // Allows the pressure to be lifted slightly without the gesture ending
        uiViewController.view.addGestureRecognizer(forceTouchGesture)
        
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<EggsViewController>) {
        
    }
    
    
}

extension CGFloat {
    
    func normalize(min: CGFloat, max: CGFloat, from a: CGFloat = 0, to b: CGFloat = 1) -> CGFloat {
        return (b - a) * ((self - min) / (max - min)) + a
    }
    
}
