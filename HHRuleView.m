//
//  HHRuleView.m
//  RuleViewDemo
//
//  Created by 张豪豪 on 16/11/10.
//  Copyright © 2016年 zhh. All rights reserved.
//

#import "HHRuleView.h"


#define HBackGroundColor [UIColor whiteColor]
#define HHeight [UIScreen mainScreen].bounds.size.height
#define HWidth [UIScreen mainScreen].bounds.size.width
#define Hone [UIScreen mainScreen].bounds.size.width / 320.0
#define textLightColor [UIColor colorWithRed:0.824 green:0.824 blue:0.824 alpha:1]
#define textFiledTextColor [UIColor colorWithRed:0.004 green:0.690 blue:0.604 alpha:1];


@interface HHRuleView()<UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;//!< 刻度尺

@property (nonatomic, assign)NSInteger maxValue;//!< 最大值
@property (nonatomic, assign)NSInteger minValue;//!< 最小值
@property (nonatomic, assign)NSInteger scale;//!< 刻度比例 一大格十小格的
@property (nonatomic, assign)NSInteger pointValue;//!< 指针指向的值
@property (nonatomic, strong)UIView *pointView;//!< 指针
@property (nonatomic, strong)UILabel *descLabel;
@property (nonatomic, strong)NSString *unitStr;

@end

NSInteger ruleImageViewHeight = 20;//刻度尺图片高度
CGFloat scrollViewScaleForRuleView = 4.0; // 整个刻度尺高度占整个控件的比例
CGFloat topDistance = 5.0; //控件之间 垂直距离
CGFloat scrollViewHeight = 35;

@implementation HHRuleView

+(HHRuleView *)ruleViewWithMaxValue:(NSInteger)maxValue minValue:(NSInteger)minValue scale:(NSInteger)scale unitStr:(NSString *)unitStr frame:(CGRect)frame{
    HHRuleView *ruleView = [HHRuleView new];
    ruleView.backgroundColor = HBackGroundColor;
    ruleView.maxValue = maxValue;
    ruleView.minValue = minValue;
    ruleView.unitStr = unitStr ? unitStr : @"元";
    ruleView.scale = scale;
    ruleView.isRound = YES;
    ruleView.frame = frame;
    
    
    
    [ruleView setScrollView];
    [ruleView setPointView];
    [ruleView setChooseValueTF];
    //    [ruleView setIncomeLabel];
    
    return ruleView;
}

-(void)setScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    //刻度尺的位置
    self.scrollView.frame = CGRectMake(0, self.frame.size.height - scrollViewHeight, self.frame.size.width, scrollViewHeight);
    //    self.scrollView.backgroundColor = [UIColor cyanColor];
    UIImage *ruleImage =[UIImage imageNamed:@"rule"];
    //放几张刻度尺图
    NSInteger multiple = (self.maxValue-self.minValue)%self.scale == 0 ? (self.maxValue-self.minValue)/self.scale : (self.maxValue-self.minValue)/self.scale + 1;
    CGFloat contSizeWith = ruleImage.size.width*multiple+HWidth;
    CGFloat ratio = (CGFloat)(self.maxValue-self.minValue)/self.scale;
    
    self.scrollView.contentSize=CGSizeMake(contSizeWith, scrollViewHeight);
    self.scrollView.layer.masksToBounds = true;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.decelerationRate = 0;
    self.scrollView.bounces = NO;
    
    [self addSubview:self.scrollView];
    [self setImages];
    if ((self.maxValue-self.minValue)%self.scale != 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(ratio * ruleImage.size.width + HWidth/2+1, 13, contSizeWith - ratio * ruleImage.size.width - HWidth + 20, CGRectGetMaxY(self.scrollView.bounds) - 1 - 13)];
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
    }
    

    
}
-(void)setImages {
    NSInteger multiple = (self.maxValue-self.minValue)%self.scale == 0 ? (self.maxValue-self.minValue)/self.scale : (self.maxValue-self.minValue)/self.scale + 1;
    UIImage *ruleImage = [UIImage imageNamed:@"rule"];
    for (int a = 0; a < multiple; a++) {
        UIImageView *rule = [[UIImageView alloc] initWithImage:ruleImage];
        rule.frame = CGRectMake(HWidth/2+a*ruleImage.size.width, CGRectGetMaxY(self.scrollView.bounds)-ruleImageViewHeight, ruleImage.size.width, ruleImageViewHeight);
        rule.tag = 100+a;
        if (a == multiple-1) {
            [rule setImage:[UIImage imageNamed:@"ruleEnd"]];
        }
        [self.scrollView addSubview:rule];
        
        //放刻度尺标度
        [self setRuleImageValueWithIdx:a];
        
    }
    [self setRuleImageValueWithIdx:multiple];
    
    //刻度尺两边的线条
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-1, HWidth/2, 1)];
    lineImage.backgroundColor = textLightColor;
    [self.scrollView addSubview:lineImage];
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.contentSize.width-HWidth/2, self.scrollView.frame.size.height-1, HWidth/2, 1)];
    lineImage2.backgroundColor = textLightColor;
    [self.scrollView addSubview:lineImage2];
}
- (void)setRuleImageValueWithIdx:(NSInteger)idx {
    //    UIImageView *image = [UIImageView alloc]initWithFrame:<#(CGRect)#>;
    UIImage *image = [UIImage imageNamed:@"rule"];
    UILabel *label = [UILabel new];
    int labelX = HWidth/2 + image.size.width * idx - image.size.width/2;
    label.frame = CGRectMake(labelX, CGRectGetMaxY(self.scrollView.bounds)-ruleImageViewHeight-13, image.size.width, 10);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.824 green:0.824 blue:0.824 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    NSString * unistr = [self.unitStr  isEqual: @"元"] ? @"" : self.unitStr;
    if (self.minValue + idx*self.scale > self.maxValue) {
        label.text = [NSString stringWithFormat:@"%ld%@",  self.maxValue,unistr];
    }else{
        label.text = [NSString stringWithFormat:@"%ld%@",  self.minValue + idx*self.scale,unistr];
    }
     [self.scrollView addSubview:label];
}

- (void)setPointView {
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(HWidth/2.0-0.5, self.scrollView.frame.origin.y - 5, 1, self.scrollView.frame.size.height + 5)];
    pointView.backgroundColor = textFiledTextColor;
    [self addSubview:pointView];
}

- (void)setDefaultValue:(NSInteger)defaultValue {
    if (defaultValue > _maxValue) {
        _defaultValue = _maxValue;
    } else if (defaultValue < _minValue) {
        _defaultValue = _minValue;
    } else {
        _defaultValue = defaultValue;
    }
    self.chooseValueTF.text = [@(_defaultValue) stringValue];
    UIImage *ruleImage = [UIImage imageNamed:@"rule"];
    //刻度尺比例实际值
    CGFloat ruleLength = (CGFloat)self.scale/ruleImage.size.width;
    CGFloat transformX = (CGFloat)(_defaultValue-_minValue)/ruleLength;
    self.scrollView.contentOffset = CGPointMake(transformX, 0);
    [self scrollViewDidEndDecelerating:_scrollView];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(ruleViewDidScroll:pointValue:)]) {
        UIImage *ruleImage = [UIImage imageNamed:@"rule"];
        //刻度尺比例实际值
        CGFloat ruleLength = (CGFloat)self.scale/ruleImage.size.width;
        //指针指向的刻度
        CGFloat value=0;
        //滑动的刻度值
        CGFloat scrollValue=0;
        
        CGFloat contentOffSetX =0;
        contentOffSetX  = scrollView.contentOffset.x;
        
        scrollValue= ruleLength*contentOffSetX;
        if (self.isRound) {
            value=[self changeHundredValueWithValue:scrollValue];
        }else{
            value=self.minValue+scrollValue;
        }
        value = value < self.minValue ? self.minValue : value;
        value = value > self.maxValue ? self.maxValue : value;
        self.pointValue = value;
        self.chooseValueTF.text = [NSString stringWithFormat:@"%d", (int)self.pointValue];
        self.incomeLabel.text = [NSString stringWithFormat:@"%.2f", [self.chooseValueTF.text integerValue]*self.incomeRate];
        [self.delegate ruleViewDidScroll:self pointValue:self.pointValue];
    }
    
}



//调控偏移的距离
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self controlScrollViewContentOffSet:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self controlScrollViewContentOffSet:scrollView];
}
- (void)controlScrollViewContentOffSet:(UIScrollView *)scrollView {
    if (self.isRound) {
        UIImage *ruleImage = [UIImage imageNamed:@"rule"];
        //刻度尺比例实际值
        CGFloat ruleLength = self.scale/ruleImage.size.width;
        CGFloat resultContentX = (self.pointValue-self.minValue)/ruleLength;
        scrollView.contentOffset = CGPointMake(resultContentX, 0);
    }
}




- (NSInteger)changeHundredValueWithValue:(CGFloat)value {
    NSInteger result = 0;
    NSInteger oneTenth = self.scale/10;
    
    
    
    if ((int)value % oneTenth > oneTenth/2) {
        result = ((int)value/oneTenth+1)*oneTenth;
    } else {
        result = ((int)value/oneTenth)*oneTenth;
    }
    
    if (result > self.maxValue) {
        return self.maxValue;
    }
    
    return result + self.minValue;
}


#pragma mark - TF&Label&Image 控件排放
- (void)setChooseValueTF {
//    self.backgroundColor = [UIColor redColor];
    self.chooseValueTF = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/2-85, 10, 170, 40)];
//    self.chooseValueTF.backgroundColor = [UIColor blueColor];
    self.chooseValueTF.text = [@(self.minValue) stringValue];
    self.chooseValueTF.textAlignment = NSTextAlignmentCenter;
    self.chooseValueTF.font = [UIFont systemFontOfSize:35];
    self.chooseValueTF.adjustsFontSizeToFitWidth = YES;
    self.chooseValueTF.keyboardType = UIKeyboardTypeNumberPad;
    self.chooseValueTF.textColor = textFiledTextColor;
    self.chooseValueTF.delegate = self;
    [self addSubview:self.chooseValueTF];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-50, 50, 100, 1)];
    [lineView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_xuxian"]]];
    [self addSubview:lineView];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-50, lineView.frame.origin.y + 3, 100, 25)];
    self.descLabel.textColor = textLightColor;
    self.descLabel.font = [UIFont systemFontOfSize:13];
    self.descLabel.text = [NSString stringWithFormat:@"%ld~%ld%@",(long)self.minValue,(long)self.maxValue,self.unitStr];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    if ([self.unitStr  isEqual: @"元"]) {
        [self addSubview:self.descLabel];
    }
}


- (void)setIncomeLabel {
    UIImageView *incomeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"income"]];
    incomeImage.frame = CGRectMake(HWidth/2-16, CGRectGetMaxY(self.scrollView.frame)+topDistance, 32, 32);
    [self addSubview:incomeImage];
    
    self.incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(HWidth/2-40, CGRectGetMaxY(incomeImage.frame)+topDistance-5, 80, 20)];
    self.incomeLabel.font = [UIFont systemFontOfSize:16];
    self.incomeLabel.textAlignment = NSTextAlignmentCenter;
    self.incomeLabel.textColor = self.chooseValueTF.textColor;
    self.incomeLabel.text = [NSString stringWithFormat:@"%.2f", [self.chooseValueTF.text integerValue]*self.incomeRate];
    [self addSubview:self.incomeLabel];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(HWidth/2-70, CGRectGetMaxY(self.incomeLabel.frame)+topDistance-2, 140, 13)];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:10];
    messageLabel.text = @"据历史结算利率每天可赚(元)";
    messageLabel.textColor = [UIColor grayColor];
    [self addSubview:messageLabel];
    
    
}



#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger value = [textField.text integerValue];
    NSString *message;
    if (value > self.maxValue) {
        message = [NSString stringWithFormat:@"您输入的值已超过最大值%ld", self.maxValue];
        self.defaultValue = self.maxValue;
    } else if (value < self.minValue){
        message = [NSString stringWithFormat:@"您输入的值低于最小值%ld", self.minValue];
        self.defaultValue = self.minValue;
    } else {
        self.defaultValue = value;
    }
    if (message.length > 0) {
        textField.text = [@(self.pointValue) stringValue];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
    
    if ([self.delegate respondsToSelector:@selector(ruleViewDidScroll:pointValue:)]) {
        [self.delegate ruleViewDidScroll:self pointValue:self.pointValue];
    }
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}



@end
