//
//  FuliScrollViewTableViewCell.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FuliScrollViewTableViewCell: UITableViewCell {
    var scrollView: UIScrollView?
    var clickAdViewHanlder: ((_ index: Int)->())?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.scrollView = UIScrollView();
        self.scrollView?.showsHorizontalScrollIndicator = false;
        self.scrollView?.frame = CGRect(x: 15, y: 0, width: SCREEN_WIDTH-30, height: 140);
//        self.scrollView?.backgroundColor = COLOR_RED;
        self.contentView.addSubview(self.scrollView!);
    }
    
    func reloadCellWithData(arrData:Array<Advertisement>){
        for view in (self.scrollView?.subviews)! {
            view.removeFromSuperview();
        }
        self.scrollView?.contentSize = CGSize(width: 180 * arrData.count, height: 140);
        for (index,item) in arrData.enumerated() {
            let adView = FuliScrollContentView(frame: CGRect(x: 180 * index, y: 0, width: 165, height: 140));
            adView.bgImageView?.sd_setImage(with: CommonUtil.getURL(item.imageUrl ?? ""));
            adView.titleLabel?.text = item.title;
            adView.descripLabel?.text = item.subTitle;
            adView.touchView?.tag = 1111 + index;
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTouchViewAction));
            adView.touchView?.addGestureRecognizer(tapGesture);
            self.scrollView?.addSubview(adView);
        }
        
    }
    
    func tapTouchViewAction(action: UITapGestureRecognizer){
        let view = action.view;
        if self.clickAdViewHanlder != nil {
            self.clickAdViewHanlder!((view?.tag)! - 1111);
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
