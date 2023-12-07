//
//  FLDebugTableTextCell.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/29.
//

#import "FLDebugTableTextCell.h"
#import "FLDebugDefine.h"
#import "FLDebugCellItemText.h"
#import "UIImage+FLDebug.h"
#import "UIView+FLDebug.h"

@interface FLDebugTableTextCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) FLDebugCellItemText *targetItem;

@end

@implementation FLDebugTableTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_titleLabel];
   
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage fl_imageNamed:@"doraemon_more"]];
        [self.contentView addSubview:_arrowImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)renderCellWithItem:(FLDebugCellItem *)item
{
    self.targetItem = (FLDebugCellItemText *)item;
    self.textLabel.text = self.targetItem.title;
    self.titleLabel.text = self.targetItem.descriptionText;
    
//    CGFloat w = self.titleLabel.fl_width;
//    if (w > UIScreenW-karSizeFrom750_Landscape(120)) {
//        w = UIScreenW-karSizeFrom750_Landscape(120);
//    }
    if (self.targetItem.hasAction) {
        self.arrowImageView.hidden = NO;
    } else {
        self.arrowImageView.hidden = YES;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.arrowImageView.fl_centerY = self.contentView.fl_centerY;
    self.arrowImageView.fl_right = self.contentView.fl_right - 8;
    self.arrowImageView.fl_size = CGSizeMake(11, 11);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.fl_centerY = self.contentView.fl_centerY;
    if (self.arrowImageView.hidden) {
        self.titleLabel.fl_right = self.contentView.fl_right - self.textLabel.fl_x;
    } else {
        self.titleLabel.fl_right = self.arrowImageView.fl_left - 4;
    }
}

@end
