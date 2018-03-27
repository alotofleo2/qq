//
//  TJBannerCell.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/26.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "TJBannerCell.h"
#import "Masonry.h"

@interface TJBannerCell ()

@property (nonatomic, weak)UIImageView *contentImageView;

@end

@implementation TJBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setupUI {
    
}

#pragma mark - Setter
- (void)setImageUrlString:(NSString *)imageUrlString {
    
    _imageUrlString = imageUrlString;
    
    if ([imageUrlString hasPrefix:@"http"])
    {
        __weak typeof(self) weakSelf = self;
        // 网络图片
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image && cacheType == SDImageCacheTypeNone) {
                CATransition *transition = [CATransition animation];
                transition.type = kCATransitionFade;
                transition.duration = 0.3;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                [weakSelf.contentImageView.layer addAnimation:transition forKey:nil];
            }
        }] ;
        
    } else {
        
        UIImage * image = [UIImage imageNamed:imageUrlString];
        [self.contentImageView setImage:image];
        
    }
}


- (void)setAdvertString:(NSString *)advertString {
    _advertString = advertString;
}

#pragma mark - Getter
- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:imageView];
        
        self.contentView.clipsToBounds = YES;
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.contentView);
        }];
        
        _contentImageView = imageView;
        
    }
    return _contentImageView;
}

@end
