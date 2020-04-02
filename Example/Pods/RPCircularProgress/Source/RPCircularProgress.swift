//
//  RPCircularProgress.swift
//  RPCircularProgress
//
//  Created by Rob Phillips on 4/5/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//
//  See LICENSE for full license agreement.
//

import UIKit

open class RPCircularProgress: UIView {

    // MARK: - Completion

    public typealias CompletionBlock = () -> Void

    // MARK: - Public API

    /**
      The color of the empty progress track (gets drawn over)
    */
    @IBInspectable open var trackTintColor: UIColor {
        get {
            return progressLayer.trackTintColor
        }
        set {
            progressLayer.trackTintColor = newValue
            progressLayer.setNeedsDisplay()
        }
    }

    /**
      The color of the progress bar
     */
    @IBInspectable open var progressTintColor: UIColor {
        get {
            return progressLayer.progressTintColor
        }
        set {
            progressLayer.progressTintColor = newValue
            progressLayer.setNeedsDisplay()
        }
    }

    /**
      The color the notched out circle within the progress area (if there is one)
     */
    @IBInspectable open var innerTintColor: UIColor? {
        get {
            return progressLayer.innerTintColor
        }
        set {
            progressLayer.innerTintColor = newValue
            progressLayer.setNeedsDisplay()
        }
    }

    /**
      Sets whether or not the corners of the progress bar should be rounded
     */
    @IBInspectable open var roundedCorners: Bool {
        get {
            return progressLayer.roundedCorners
        }
        set {
            progressLayer.roundedCorners = newValue
            progressLayer.setNeedsDisplay()
        }
    }

    /**
      Sets how thick the progress bar should be (pinned between `0.01` and `1`)
     */
    @IBInspectable open var thicknessRatio: CGFloat {
        get {
            return progressLayer.thicknessRatio
        }
        set {
            progressLayer.thicknessRatio = pin(newValue, minValue: 0.01, maxValue: 1)
            progressLayer.setNeedsDisplay()
        }
    }

    /**
      Sets whether or not the animation should be clockwise
     */
    @IBInspectable open var clockwiseProgress: Bool {
        get {
            return progressLayer.clockwiseProgress
        }
        set {
            progressLayer.clockwiseProgress = newValue
            progressLayer.setNeedsDisplay()
        }
    }

    /**
      A timing function defining the pacing of the animation. Defaults to ease in, ease out.
     */
    open var timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

    /**
      Getter for the current progress (not observed from any active animations)
     */
    @IBInspectable open var progress: CGFloat {
        get {
            return progressLayer.progress
        }
    }

    /**
      Sets how much of the progress bar should be filled during an indeterminate animation, pinned between `0.05` and `0.9`
     
      **Note:** This can be overriden / animated from by using updateProgress(...)
     */
    @IBInspectable open var indeterminateProgress: CGFloat {
        get {
            return progressLayer.indeterminateProgress
        }
        set {
            progressLayer.indeterminateProgress = pin(newValue, minValue: 0.05, maxValue: 0.9)
        }
    }

    /**
      Controls the speed at which the indeterminate progress bar animates
     */
    @IBInspectable open var indeterminateDuration: CFTimeInterval = Defaults.indeterminateDuration

    // MARK: - Custom Base Layer

    fileprivate var progressLayer: ProgressLayer! {
        get {
            return (layer as! ProgressLayer)
        }
    }

    open override class var layerClass : AnyClass {
        return ProgressLayer.self
    }

    // Lifecycle

    /**
     Default initializer for the class

     - returns: A configured instance of self
     */
    required public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

        setupDefaults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDefaults()
    }

    open override func didMoveToWindow() {
        super.didMoveToWindow()

        if let window = window {
            progressLayer.contentsScale = window.screen.scale
            progressLayer.setNeedsDisplay()
        }
    }

    // MARK: - Indeterminate

    /**
     Enables or disables the indeterminate (spinning) animation

     - parameter enabled:    Whether or not to enable the animation (defaults to `true`)
     - parameter completion: An optional closure to execute after the animation completes
     */
    open func enableIndeterminate(_ enabled: Bool = true, completion: CompletionBlock? = nil) {
        if let animation = progressLayer.animation(forKey: AnimationKeys.indeterminate) {
            // Check if there are any closures to execute on the existing animation
            if let block = animation.value(forKey: AnimationKeys.completionBlock) as? CompletionBlockObject {
                block.action()
            }
            progressLayer.removeAnimation(forKey: AnimationKeys.indeterminate)

            // And notify of disabling completion
            completion?()
        }

        guard enabled else { return }

        addIndeterminateAnimation(completion)
    }

    // MARK: - Progress

    /**
     Updates the progress bar to the given value with the optional properties

     - parameter progress:     The progress to update to, pinned between `0` and `1`
     - parameter animated:     Whether or not the update should be animated (defaults to `true`)
     - parameter initialDelay: Sets an initial delay before the animation begins
     - parameter duration:     Sets the overal duration that the animation should complete within
     - parameter completion:   An optional closure to execute after the animation completes
     */
    open func updateProgress(_ progress: CGFloat, animated: Bool = true, initialDelay: CFTimeInterval = 0, duration: CFTimeInterval? = nil, completion: CompletionBlock? = nil) {
        let pinnedProgress = pin(progress)
        if animated {

            // Get duration
            let animationDuration: CFTimeInterval
            if let duration = duration, duration != 0 {
                animationDuration = duration
            } else {
                // Same duration as UIProgressView animation
                animationDuration = CFTimeInterval(fabsf(Float(self.progress) - Float(pinnedProgress)))
            }

            // Get current progress (to avoid jumpy behavior)
            // Basic animations have their value reset to the original once the animation is finished
            // since only the presentation layer is animating
            var currentProgress: CGFloat = 0
            if let presentationLayer = progressLayer.presentation() {
                currentProgress = presentationLayer.progress
            }
            progressLayer.progress = currentProgress

            progressLayer.removeAnimation(forKey: AnimationKeys.progress)
            animate(progress, currentProgress: currentProgress, initialDelay: initialDelay, duration: animationDuration, completion: completion)
        } else {
            progressLayer.removeAnimation(forKey: AnimationKeys.progress)

            progressLayer.progress = pinnedProgress
            progressLayer.setNeedsDisplay()

            completion?()
        }
    }
}

// MARK: - Private API

private extension RPCircularProgress {

    // MARK: - Defaults

    func setupDefaults() {
        progressLayer.trackTintColor = Defaults.trackTintColor
        progressLayer.progressTintColor = Defaults.progressTintColor
        progressLayer.innerTintColor = nil
        backgroundColor = Defaults.backgroundColor
        progressLayer.thicknessRatio = Defaults.thicknessRatio
        progressLayer.roundedCorners = Defaults.roundedCorners
        progressLayer.clockwiseProgress = Defaults.clockwiseProgress
        indeterminateDuration = Defaults.indeterminateDuration
        progressLayer.indeterminateProgress = Defaults.indeterminateProgress
    }

    // MARK: - Progress

    // Pin certain values between 0.0 and 1.0
    func pin(_ value: CGFloat, minValue: CGFloat = 0, maxValue: CGFloat = 1) -> CGFloat {
        return min(max(value, minValue), maxValue)
    }

    func animate(_ pinnedProgress: CGFloat, currentProgress: CGFloat, initialDelay: CFTimeInterval, duration: CFTimeInterval, completion: CompletionBlock?) {
        let animation = CABasicAnimation(keyPath: AnimationKeys.progress)
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.fromValue = currentProgress
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.toValue = pinnedProgress
        animation.beginTime = CACurrentMediaTime() + initialDelay
        animation.delegate = self
        if let completion = completion {
            let completionObject = CompletionBlockObject(action: completion)
            animation.setValue(completionObject, forKey: AnimationKeys.completionBlock)
        }
        progressLayer.add(animation, forKey: AnimationKeys.progress)
    }

    // MARK: - Indeterminate 

    func addIndeterminateAnimation(_ completion: CompletionBlock?) {
        guard progressLayer.animation(forKey: AnimationKeys.indeterminate) == nil else { return }

        let animation = CABasicAnimation(keyPath: AnimationKeys.transformRotation)
        animation.byValue = clockwiseProgress ? 2 * Double.pi : -2 * Double.pi
        animation.duration = indeterminateDuration
        animation.repeatCount = Float.infinity
        animation.isRemovedOnCompletion = false
        progressLayer.progress = indeterminateProgress
        if let completion = completion {
            let completionObject = CompletionBlockObject(action: completion)
            animation.setValue(completionObject, forKey: AnimationKeys.completionBlock)
        }
        progressLayer.add(animation, forKey: AnimationKeys.indeterminate)
    }

    // Completion

    class CompletionBlockObject: NSObject {
        var action: CompletionBlock

        required init(action: @escaping CompletionBlock) {
            self.action = action
        }
    }

    // MARK: - Private Classes / Structs

    class ProgressLayer: CALayer {
        @NSManaged var trackTintColor: UIColor
        @NSManaged var progressTintColor: UIColor
        @NSManaged var innerTintColor: UIColor?

        @NSManaged var roundedCorners: Bool
        @NSManaged var clockwiseProgress: Bool
        @NSManaged var thicknessRatio: CGFloat

        @NSManaged var indeterminateProgress: CGFloat
        // This needs to have a setter/getter for it to work with CoreAnimation
        @NSManaged var progress: CGFloat

        override class func needsDisplay(forKey key: String) -> Bool {
            return key == AnimationKeys.progress ? true : super.needsDisplay(forKey: key)
        }

        override func draw(in ctx: CGContext) {
            let rect = bounds
            let centerPoint = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
            let radius = min(rect.size.height, rect.size.width) / 2

            let progress: CGFloat = min(self.progress, CGFloat(1 - Float.ulpOfOne))
            var radians: CGFloat = 0
            if clockwiseProgress {
                radians = CGFloat((Double(progress) * 2 * Double.pi) - (Double.pi / 2))
            } else {
                radians = CGFloat(3 * (Double.pi / 2) - (Double(progress) * 2 * Double.pi))
            }

            func fillTrack() {
                ctx.setFillColor(trackTintColor.cgColor)
                let trackPath = CGMutablePath()
                trackPath.move(to: centerPoint)
                trackPath.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(2 * Double.pi), endAngle: 0, clockwise: true)
                trackPath.closeSubpath()
                ctx.addPath(trackPath)
                ctx.fillPath()
            }

            func fillProgressIfNecessary() {
                if progress == 0.0 {
                    return
                }

                func fillProgress() {
                    ctx.setFillColor(progressTintColor.cgColor)
                    let progressPath = CGMutablePath()
                    progressPath.move(to: centerPoint)
                    progressPath.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(3 * (Double.pi / 2)), endAngle: radians, clockwise: !clockwiseProgress)
                    progressPath.closeSubpath()
                    ctx.addPath(progressPath)
                    ctx.fillPath()
                }

                func roundCornersIfNecessary() {
                    if !roundedCorners {
                        return
                    }

                    let pathWidth = radius * thicknessRatio
                    let xOffset = radius * (1 + ((1 - (thicknessRatio / 2)) * CGFloat(cosf(Float(radians)))))
                    let yOffset = radius * (1 + ((1 - (thicknessRatio / 2)) * CGFloat(sinf(Float(radians)))))
                    let endpoint = CGPoint(x: xOffset, y: yOffset)

                    let startEllipseRect = CGRect(x: centerPoint.x - pathWidth / 2, y: 0, width: pathWidth, height: pathWidth)
                    ctx.addEllipse(in: startEllipseRect)
                    ctx.fillPath()

                    let endEllipseRect = CGRect(x: endpoint.x - pathWidth / 2, y: endpoint.y - pathWidth / 2, width: pathWidth, height: pathWidth)
                    ctx.addEllipse(in: endEllipseRect)
                    ctx.fillPath()
                }

                fillProgress()
                roundCornersIfNecessary()
            }

            func notchCenterCircle() {
                ctx.setBlendMode(.clear)
                let innerRadius = radius * (1 - thicknessRatio)
                let clearRect = CGRect(x: centerPoint.x - innerRadius, y: centerPoint.y - innerRadius, width: innerRadius * 2, height: innerRadius * 2)
                ctx.addEllipse(in: clearRect)
                ctx.fillPath()

                func fillInnerTintIfNecessary() {
                    if let innerTintColor = innerTintColor {
                        ctx.setBlendMode(.normal)
                        ctx.setFillColor(innerTintColor.cgColor)
                        ctx.addEllipse(in: clearRect)
                        ctx.fillPath()
                    }
                }

                fillInnerTintIfNecessary()
            }

            fillTrack()
            fillProgressIfNecessary()
            notchCenterCircle()
        }
    }

    struct Defaults {
        static let trackTintColor = UIColor(white: 1.0, alpha: 0.3)
        static let progressTintColor = UIColor.white
        static let backgroundColor = UIColor.clear

        static let progress: CGFloat = 0
        static let thicknessRatio: CGFloat = 0.3
        static let roundedCorners = true
        static let clockwiseProgress = true
        static let indeterminateDuration: CFTimeInterval = 1.0
        static let indeterminateProgress: CGFloat = 0.3
    }

    struct AnimationKeys {
        static let indeterminate = "indeterminateAnimation"
        static let progress = "progress"
        static let transformRotation = "transform.rotation"
        static let completionBlock = "completionBlock"
        static let toValue = "toValue"
    }

}

// MARK: - Animation Delegate

extension RPCircularProgress: CAAnimationDelegate {

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let completedValue = anim.value(forKey: AnimationKeys.toValue)
        if let completedValue = completedValue as? CGFloat {
            progressLayer.progress = completedValue
        }

        if let block = anim.value(forKey: AnimationKeys.completionBlock) as? CompletionBlockObject {
            block.action()
        }
    }

}

