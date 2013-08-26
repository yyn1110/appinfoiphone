//
//  YYRightCell.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-26.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYRightCell.h"

@implementation YYRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 13, 16, 15)];
        self.tagImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tagImageView];
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tagImageView.frame)+30, 7, 120, 25)];
        self.tagLabel.font = [UIFont systemFontOfSize:14];
        self.tagLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tagLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
