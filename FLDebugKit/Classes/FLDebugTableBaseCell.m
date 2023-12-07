//
//  FLDebugTableBaseCell.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "FLDebugTableBaseCell.h"

@implementation FLDebugTableBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)renderCellWithItem:(FLDebugCellItem *)item
{
    self.textLabel.text = item.title;
}

@end
