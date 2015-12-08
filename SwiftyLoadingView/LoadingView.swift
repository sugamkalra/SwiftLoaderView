//
//  LoadingView.swift
//  Topcoder
//
//  Created by TCCODER on 10/30/15.
//  Modified by TCCODER on 11/11/15.
//  Copyright © 2015 topcoder. All rights reserved.
//

import UIKit

/**
 * LoadingView
 * View with activity indicator
 *
 * @author TCCODER
 * @version 1.1
 *
 * changes:
 * 1.1:
 * - change in show() method
 */
class LoadingView: UIView {
    
    /// the activity indicator
    var activityIndicator: UIActivityIndicatorView!
    
    /// parent view
    var parentView: UIView?
    
    /// is terminated
    var terminated = false
    
    /// is shown
    var shown = false
    
    /**
     Initialization
     
     - Parameters:
     - parentView: parent view
     - dimming: whether should be dimmed
     */
    init(_ parentView: UIView?, dimming: Bool = true) {
        // update parent view layout first
        if let parentView = parentView {
            parentView.layoutIfNeeded()
        }
        super.init(frame: parentView?.bounds ?? UIScreen.mainScreen().bounds)
        self.parentView = parentView
        setupView(dimming)
    }
    
    /**
     Initialization
     
     - Parameter coder: a decoder
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Setup the view
     
     - Parameter dimming: dimming state
     */
    func setupView(dimming: Bool) {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        
        if dimming {
            self.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
            activityIndicator.activityIndicatorViewStyle = .Gray
        }
        else {
            self.backgroundColor = UIColor.clearColor()
        }
        self.alpha = 0.0
    }
    
    /**
     Stopping the loading activity
     */
    func terminate() {
        terminated = true
        if !shown { return }
        UIView.animateWithDuration(0.25, animations: { _ in
            self.alpha = 0.0
            }) { success in
                self.activityIndicator.stopAnimating()
                self.removeFromSuperview()
        }
    }
    
    /**
     Starting the loading activity
     
     - returns: current view
     */
    func show() -> LoadingView {
        shown = true
        if !terminated {
            if let view = parentView {
                view.addSubview(self)
                return self
            }
            UIApplication.sharedApplication().delegate!.window!?.addSubview(self)
        }
        return self
    }
    
    /**
     start animating when the loading view moved to superview
     */
    override func didMoveToSuperview() {
        activityIndicator.startAnimating()
        UIView.animateWithDuration(0.25) {
            self.alpha = 0.75
        }
    }
}
