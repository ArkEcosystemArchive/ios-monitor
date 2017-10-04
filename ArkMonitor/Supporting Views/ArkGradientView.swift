// Copyright (c) 2016 Ark
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

open class ArkGradientView: UIView {

    private struct Animation {
        static let keyPath = "colors"
        static let key = "ColorChange"
    }
    
    // Custom Direction
    open var startPoint : CGPoint = CGPoint(x: 0.0, y: 0.0)
    open var endPoint   : CGPoint = CGPoint(x: 1.0, y: 1.0)
    
    // Custom Duration
    open var animationDuration: TimeInterval = 5.0
    
    fileprivate let gradient = CAGradientLayer()
    private var currentGradient: Int = 0
    private var colors: [UIColor] = [UIColor(r: 0, g: 0, b: 0),
                                      UIColor(r: 35, g: 35, b: 35),
                                      UIColor(r: 0, g: 0, b: 0),
                                      UIColor(r: 35, g: 35, b: 35)]

    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
    public func startAnimation() {
        gradient.removeAllAnimations()
        setup()
        animateGradient()
    }
    
    fileprivate func setup() {
        gradient.frame = bounds
        gradient.colors = currentGradientSet()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.drawsAsynchronously = true
        
        layer.insertSublayer(gradient, at: 0)
    }

    fileprivate func currentGradientSet() -> [CGColor] {
        guard colors.count > 0 else { return [] }
        return [colors[currentGradient % colors.count].cgColor,
                colors[(currentGradient + 1) % colors.count].cgColor]
    }
    
    public func setColors(_ colors: [UIColor]) {
        guard colors.count > 0 else { return }
        self.colors = colors
    }
    
    public func addcolor(_ color: UIColor) {
        self.colors.append(color)
    }
    
    func animateGradient() {
        currentGradient += 1
        let animation = CABasicAnimation(keyPath: Animation.keyPath)
        animation.duration = animationDuration
        animation.toValue = currentGradientSet()
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradient.add(animation, forKey: Animation.key)
    }
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
    }
}

extension ArkGradientView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = currentGradientSet()
            animateGradient()
        }
    }
}
