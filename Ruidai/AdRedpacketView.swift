//
//  AdRedpacketView.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class WelfareAdRedpacket: AdRedpacketView{
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    override func tapRedPacketAction(){
        let urlContent = self.adModel?.link;
        self.removeFromSuperview();
        self.isHidden = true;
        
        if (urlContent != nil) {
            //红包广告统计
            AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "welfare_redpacket");
            LoanRoutes.routeURLString(urlContent!);
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class AdRedpacketView: UIView ,CAAnimationDelegate,UIGestureRecognizerDelegate{
    var imageView : UIImageView!
    var adModel : Advertisement?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60));
        self.imageView.contentMode = .scaleAspectFit;
        self.imageView.image = #imageLiteral(resourceName: "icon_redpacket");
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRedPacketAction));
        tapGesture.delegate = self;
        self.imageView.isUserInteractionEnabled = true;
        self.addSubview(self.imageView);
        self.addGestureRecognizer(tapGesture);
//        self.showAnimal();
    }
    
    func showAnimal(){
        let positionAnimal = CAKeyframeAnimation(keyPath: "position");
        let fromPosition = NSValue(cgRect: CGRect(x: SCREEN_WIDTH - 75, y: -75, width: 60, height: 60));
        let toPosition = NSValue(cgRect: CGRect(x: SCREEN_WIDTH - 75, y: SCREEN_HEIGHT - TABBARHEIGHT - 15 - 30, width: 60, height: 60));
        
        positionAnimal.values = [fromPosition,toPosition];
        positionAnimal.duration = 2.0;
        positionAnimal.timingFunction = CAMediaTimingFunction.init(name:kCAMediaTimingFunctionEaseOut);
//        positionAnimal.fillMode = kCAFillModeForwards;
//        positionAnimal.isRemovedOnCompletion = false;
        positionAnimal.delegate = self;
        self.layer.add(positionAnimal, forKey: "position");
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim.isMember(of: CAKeyframeAnimation.classForCoder()) {
            let shakeAnima = CAKeyframeAnimation(keyPath: "transform.rotation");
            let value1 = NSNumber.init(value: (-Double.pi/180*4));
            let value2 = NSNumber.init(value: (Double.pi/180*4));
            let value3 = NSNumber.init(value: (-Double.pi/180*4));
            shakeAnima.values = [value1,value2,value3];
            shakeAnima.repeatCount = MAXFLOAT;
            self.layer.add(shakeAnima, forKey: "shakeAnimal");
            
        }
    }
    
    func tapRedPacketAction(){
        let urlContent = self.adModel?.link;
        self.removeFromSuperview();
        self.isHidden = true;
        
        if (urlContent != nil) {
            //红包广告统计

            AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "home_redpacket");

            LoanRoutes.routeURLString(urlContent!);
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView") {
            //返回为NO则屏蔽手势事件
            return false;
        }
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
