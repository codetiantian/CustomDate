//
//  PickerCell.m
//  CBDate
//
//  Created by 崔兵兵 on 16/6/7.
//  Copyright © 2016年 医联通. All rights reserved.
//

#import "PickerCell.h"

@interface PickerCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation PickerCell

+ (PickerCell *)cellWithName:(NSString *)strName
{
    PickerCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PickerCell" owner:nil options:nil] firstObject];
    cell.titleLabel.text = strName;
    
    return cell;
}

@end
