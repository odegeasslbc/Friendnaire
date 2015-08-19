//
//  PostView.swift
//  Friendnaire
//
//  Created by LiuBingchen on 15/8/18.
//  Copyright (c) 2015年 LiuBingchen. All rights reserved.
//

import UIKit

class nameLabel:UILabel{
    var initFrame:CGRect?
    var finalFrame:CGRect?
    var hiddenFrame:CGRect?
    
    func moveToFinal(){
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.finalFrame!
            self.font = UIFont(name: "Arial", size: 50)

        })
    }
    
    func moveToInit(){
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.initFrame!
            self.font = UIFont(name: "Arial", size: 50)
        })
    }
    
    func moveToHidden(){
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.hiddenFrame!
            self.font = UIFont(name: "Arial", size: 20)
        })
    }
    
    init(initFrame: CGRect,finalFrame:CGRect) {
        super.init(frame: initFrame)
        
        self.initFrame = initFrame
        self.finalFrame = finalFrame
        if(initFrame.minX>screen.width/2){
            self.hiddenFrame = CGRectMake(screen.width-30, initFrame.minY, 30, initFrame.height)
        }else{
            self.hiddenFrame = CGRectMake(0, initFrame.minY, 30, initFrame.height)
        }
        
        self.textAlignment = NSTextAlignment.Center
        self.font = UIFont(name: "Arial", size: 50)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol PAGDelegate{
    func moveToHidden()
}

enum Status{
    case Hidden
    case Initial
    case Final
}

class PostView: UIView,PAGDelegate {

    var status = Status.Initial
    
    var initFrame:CGRect?
    var finalFrame:CGRect?
    var hiddenFrame:CGRect?
    
    var delegate:PAGDelegate?
    
    var pLabel:nameLabel?
    var oLabel:nameLabel?
    var sLabel:nameLabel?
    var tLabel:nameLabel?
    
    var nameLabelInitX = screen.width/2 + (screen.width/2-screen.height/6)/2
    var nameLabelInitWidth = screen.height/6
    
    var banner:UIView?
    
    var tap = UITapGestureRecognizer()
    
    func moveToHidden() {
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.hiddenFrame!
            self.banner?.alpha = 0
        })
        pLabel?.moveToHidden()
        oLabel?.moveToHidden()
        sLabel?.moveToHidden()
        tLabel?.moveToHidden()
        self.status = .Hidden
    }
    
    func moveToFinal(){
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.finalFrame!
            self.banner?.alpha = 1
        })
        pLabel!.moveToFinal()
        oLabel!.moveToFinal()
        sLabel!.moveToFinal()
        tLabel!.moveToFinal()
        self.status = .Final
    }
    
    func moveToInit(){
        UIView.animateWithDuration(0.5, animations: {
            self.frame = self.initFrame!
            self.banner?.alpha = 0
        })
        pLabel!.moveToInit()
        oLabel!.moveToInit()
        sLabel!.moveToInit()
        tLabel!.moveToInit()
        self.status = .Initial
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
        self.finalFrame = CGRectMake(-30, 0, screen.width, screen.height)
        self.initFrame = CGRectMake(-screen.width/2, 0, screen.width, screen.height)
        self.hiddenFrame = CGRectMake(-screen.width+30, 0, screen.width, screen.height)
        
        super.init(frame: self.initFrame!)
        
        pLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(30, 20, screen.width/6, screen.width/6))
        oLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6*2, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(screen.width/6+30, 20, screen.width/6, screen.width/6))
        sLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6*3, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(screen.width/6*2+30, 20, screen.width/6, screen.width/6))
        tLabel = nameLabel(initFrame: CGRectMake(nameLabelInitX, screen.height/6*4, nameLabelInitWidth, nameLabelInitWidth),finalFrame:CGRectMake(screen.width/6*3+30, 20, screen.width/6, screen.width/6))
        
        pLabel?.text = "P"
        oLabel?.text = "O"
        sLabel?.text = "S"
        tLabel?.text = "T"
        
        self.addSubview(pLabel!)
        self.addSubview(oLabel!)
        self.addSubview(sLabel!)
        self.addSubview(tLabel!)
        
        tap.addTarget(self, action: "move")
        self.addGestureRecognizer(tap)

        banner = UIView(frame: CGRectMake(0, 0, screen.width, screen.width/6+20))
        banner?.backgroundColor = UIColor.yellowColor()
        self.addSubview(banner!)
        self.sendSubviewToBack(banner!)
        banner?.alpha = 0
        
        self.backgroundColor = UIColor(red: 0, green: 0.9, blue: 0.9, alpha: 1)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
