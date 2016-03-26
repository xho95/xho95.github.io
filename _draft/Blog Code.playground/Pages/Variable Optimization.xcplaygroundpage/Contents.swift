//: [Previous](@previous)

import UIKit

class ViewController: UIViewController {
    var touchCount: Int = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchCount = touches.count
        
        print("Touch Count: \(touchCount)")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchCount = touches.count
        
        print("Touch Count: \(touchCount)")
    }
}

// --------

class OtherViewController: UIViewController {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchCount = touches.count
        
        print("Touch Count: \(touchCount)")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchCount = touches.count
        
        print("Touch Count: \(touchCount)")
    }
}

//: [Next](@next)
