//
//  CameraOverlayView.swift
//  AlwaysForget
//
//  Created by User on 9/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView {

    var squireWidthToFrameWidthRatio:CGFloat = 0.8
    var squireYToFrameWidthRatio:CGFloat = 0.4
    var squireXToFrameWidthRatio:CGFloat = 0.1
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let backgroundFrameUpper = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: self.squireYToFrameWidthRatio * frame.width))
        let backgroundFrameLeft = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y + (self.squireYToFrameWidthRatio * frame.width), width: (1 / 2 ) * (1 - self.squireWidthToFrameWidthRatio) * frame.width , height: frame.width))
        let backgroundFrameRight = UIView(frame: CGRect(x: frame.origin.x + (self.squireWidthToFrameWidthRatio + self.squireXToFrameWidthRatio ) * frame.width, y: frame.origin.y + (self.squireYToFrameWidthRatio) * frame.width, width: self.squireXToFrameWidthRatio * frame.width, height: frame.width))
        let backgroundFrameLower = UIView(frame: CGRect(x: frame.origin.x, y: (self.squireYToFrameWidthRatio + self.squireWidthToFrameWidthRatio) * frame.width, width: frame.width, height: frame.height))
        backgroundFrameUpper.backgroundColor = UIColor.blackColor()
        backgroundFrameLeft.backgroundColor = UIColor.blackColor()
        backgroundFrameRight.backgroundColor = UIColor.blackColor()
        backgroundFrameLower.backgroundColor = UIColor.blackColor()
        backgroundFrameUpper.alpha = 0.9
        backgroundFrameRight.alpha = 0.9
        backgroundFrameLower.alpha = 0.9
        backgroundFrameLeft.alpha = 0.9
        self.addSubview(backgroundFrameUpper)
        self.addSubview(backgroundFrameLeft)
        self.addSubview(backgroundFrameRight)
        self.addSubview(backgroundFrameLower)
        
        
        let photoFrame = UIView(frame: CGRect(x: frame.origin.x + (self.squireXToFrameWidthRatio * frame.width), y: frame.origin.y + (self.squireYToFrameWidthRatio * frame.width), width: self.squireWidthToFrameWidthRatio * frame.width , height: self.squireWidthToFrameWidthRatio * frame.width))

        self.addSubview(photoFrame)
        
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
