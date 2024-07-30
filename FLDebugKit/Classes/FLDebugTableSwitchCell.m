//
//  FLDebugTableSwitchCell.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "FLDebugTableSwitchCell.h"
#import "FLDebugCellItemSwitch.h"
#import "UIView+FLDebug.h"

@interface FLDebugTableSwitchCell ()

@property (nonatomic, strong) UISwitch *switchBtn;

@property (nonatomic, strong) FLDebugCellItemSwitch *targetItem;

@end

@implementation FLDebugTableSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(switchChange:)forControlEvents:UIControlEventValueChanged];
        _switchBtn.on = NO;
        [self.contentView addSubview:_switchBtn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)switchChange:(UISwitch *)sender
{
    BOOL on = sender.on;
    self.targetItem.isOn = on;
    if (self.targetItem.switchBlock) {
        self.targetItem.switchBlock(on);
    }
}

- (void)renderCellWithItem:(FLDebugCellItem *)item
{
    self.targetItem = (FLDebugCellItemSwitch *)item;
    self.textLabel.text = self.targetItem.title;
    self.switchBtn.on = self.targetItem.isOn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.switchBtn.fl_size = CGSizeMake(60, 30);
    self.switchBtn.fl_centerY = self.contentView.fl_centerY;
    self.switchBtn.fl_right = self.contentView.fl_right - 8;
}

@end
