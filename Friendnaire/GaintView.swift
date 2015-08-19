//
//  GetView.swift
//  Friendnaire
//
//  Created by LiuBingchen on 15/8/18.
//  Copyright (c) 2015年 LiuBingchen. All rights reserved.
//

import UIKit

class GainView: UIView,PAGDelegate {
        
    var status = Status.Initial
        
    var initFrame:CGRect?
    var finalFrame:CGRect?
    var hiddenFrame:CGRect?
    
    var delegate:PAGDelegate?
    
    var gLabel:nameLabel?
    var aLabel:nameLabel?
    var iLabel:nameLabel?
    var nLabel:nameLabel?
        
    var nameLabelInitX = (screen.width/2-screen.height/6)/2
    var nameLabelInitWidth = screen.height/6
    
    var banner:UIView?
    
    var tap = UITapGestureRecognizer()
    var swipRight = UISwipeGestureRecognizer()
        
    func moveToFinal(){
        if(self.status != .Final){
            UIView.animateWithDuration(0.5, animations: {
                self.frame = self.finalFrame!
                self.banner?.alpha = 1
            })
            gLabel!.moveToFinal()
            aLabel!.moveToFinal()
            iLabel!.moveToFinal()
            nLabel!.moveToFinal()
            self.status = .Final
        }
    }
    
    func moveToInit(){
        //if(self.status )
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.initFrame!
            self.banner?.alpha = 0
        })
        gLabel!.moveToInit()
        aLabel!.moveToInit()
        iLabel!.moveToInit()
        nLabel!.moveToInit()
        self.status = .Initial
    }
    
    func moveToHidden() {
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.hiddenFrame!
            self.banner?.alpha = 0
        })
        gLabel?.moveToHidden()
        aLabel?.moveToHidden()
        iLabel?.moveToHidden()
        nLabel?.moveToHidden()
        self.status = .Hidden
    }
    
    func move(){
        self.superview?.bringSubviewToFront(self)
        switch self.status{
        case .Initial:
            self.moveToFinal()
            self.delegate?.moveToHidden()
        case .Hidden:
            self.moveToFinal()
            self.delegate?.moveToHidden()
            //case .Final:
        default:
            break
        }
        
    }
    
    init(){
        self.finalFrame = CGRectMake(30, 0, screen.width, screen.height)
        self.initFrame = CGRectMake(screen.width/2, 0, screen.width, screen.height)
        self.hiddenFrame = CGRectMake(screen.width-30, 0, screen.width, screen.height)
        
        super.init(frame: self.initFrame!)
        
        gLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(0, 20, screen.width/6, screen.width/6))
        aLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6*2, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(screen.width/6, 20, screen.width/6, screen.width/6))
        iLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6*3, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(screen.width/6*2, 20, screen.width/6, screen.width/6))
        nLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6*4, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(screen.width/6*3, 20, screen.width/6, screen.width/6))
        
        gLabel?.text = "G"
        aLabel?.text = "A"
        iLabel?.text = "I"
        nLabel?.text = "N"
        
        self.addSubview(gLabel!)
        self.addSubview(aLabel!)
        self.addSubview(iLabel!)
        self.addSubview(nLabel!)
        
        tap.addTarget(self, action: "move")
        self.addGestureRecognizer(tap)
        
        banner = UIView(frame: CGRectMake(0, 0, screen.width, screen.width/6+20))
        banner?.backgroundColor = UIColor.yellowColor()
        self.addSubview(banner!)
        self.sendSubviewToBack(banner!)
        banner?.alpha = 0
        
        self.backgroundColor = UIColor(red: 1, green: 0.27, blue: 0.39, alpha: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
