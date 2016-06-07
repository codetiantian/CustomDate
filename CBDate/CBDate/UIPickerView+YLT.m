//
//  UIPickerView+YLT.m
//  YLTDoctors
//
//  Created by 崔兵兵 on 16/5/5.
//  Copyright © 2016年 医联通. All rights reserved.
//

#import "UIPickerView+YLT.h"
#import <objc/runtime.h>

@implementation UIPickerView (YLT)


- (void)clearSpearatorLine
{
    if (!self.lineHiden)//该方法会被多次调用，加一个标示让它只调用一次
    {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.height < 1)
            {
                obj.backgroundColor = [UIColor clearColor];
            }
        }];
    }
    self.lineHiden = YES;
}

- (BOOL)lineHiden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLineHiden:(BOOL)lineHiden
{
   objc_setAssociatedObject(self, @selector(lineHiden), @(lineHiden), OBJC_ASSOCIATION_ASSIGN);
}



@end
