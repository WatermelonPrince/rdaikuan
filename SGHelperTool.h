//
//  SGHelperTool.h
//  SGHelperTool
//
//  Created by Sorgle on 15/7/13.
//  Copyright © 2015年 Sorgle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SGHelperTool : NSObject

/** 简单的图文混排 */
+ (NSMutableAttributedString *)SG_textAttachmentWithImageName:(NSString *)imageName imageSize:(CGSize)imageSize frontText:(NSString *)frontText frontTextColor:(UIColor *)frontTextColor behindText:(NSString *)behindText behindSecondPartText:(NSString *)behindSecondPartText behindTextColor:(UIColor *)behindTextColor behindSecondPartTextColor:(UIColor *)behindSecondPartTextColor;


@end
