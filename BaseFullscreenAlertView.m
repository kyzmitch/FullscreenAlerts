//
//  BaseFullscreenAlertView.m
//
//  Created by Andrey Ermoshin on 25/01/17.
//

#import "BaseFullscreenAlertView.h"

@interface BaseFullscreenAlertView ()
{
@private
    AlertClosedBlock _onCloseBlock;
    BOOL _animatedClosing;
    NSString *_mainButtonText;
}

@end

@implementation BaseFullscreenAlertView

@synthesize backgroundImageView = _backgroundImageView, iconImageView = _iconImageView, bigDescriptionLabel = _bigDescriptionLabel, mainButton = _mainButton;

- (instancetype)init{
    self = [super init];
    
    if (self == nil) {
        return nil;
    }
    
    _animatedClosing = NO;
    self.backgroundColor = [UIColor blackColor];
    CGRect rect = [UIScreen mainScreen].bounds;
    self.frame = rect;
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:rect];
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_backgroundImageView];
    // constraints can be added only after adding to superview
    NSDictionary *backgroundViews = NSDictionaryOfVariableBindings(_backgroundImageView);
    NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0.0-[_backgroundImageView]-0.0-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:backgroundViews];
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.0-[_backgroundImageView]-0.0-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:backgroundViews];
    [NSLayoutConstraint activateConstraints:horizontal];
    [NSLayoutConstraint activateConstraints:vertical];
    _backgroundImageView.image = [self backgroundImage];
    
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_iconImageView];
    _iconImageView.image = [self iconImage];
    
    _bigDescriptionLabel = [[UILabel alloc] init];
    _bigDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bigDescriptionLabel.numberOfLines = 5;
    [self addSubview:_bigDescriptionLabel];
    _bigDescriptionLabel.attributedText = [self bigDescriptionText];
    
    _mainButton = [[UIButton alloc] init];
    [_mainButton addTarget:self
                    action:@selector(mainButtonTouched)
          forControlEvents:UIControlEventTouchUpInside];
    _mainButton.translatesAutoresizingMaskIntoConstraints = NO;
    _mainButton.backgroundColor = [self mainButtonBackgroundColor];
    [_mainButton setAttributedTitle:[self mainButtonConfiguredTitle] forState:UIControlStateNormal];
    [self addSubview:_mainButton];
    
    return self;
}

- (void)setIconConstraints{
    // Icon
    
    NSDictionary *iconMetrics   = [self iconMetrics];
    NSDictionary *iconViews = NSDictionaryOfVariableBindings(_iconImageView, self);
    NSArray *horizontalIconConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[_iconImageView]"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:iconMetrics
                                                                                   views:iconViews];
    NSArray *verticalIconConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100.0-[_iconImageView(height)]"
                                                                               options:0
                                                                               metrics:iconMetrics
                                                                                 views:iconViews];
    [NSLayoutConstraint activateConstraints:horizontalIconConstraints];
    [NSLayoutConstraint activateConstraints:verticalIconConstraints];
}

- (void)layoutSubviews{
    NSLog(@"BaseFullscreenAlertView: layoutSubviews");
    
    [self setIconConstraints];
    
    // Description
    NSDictionary *labelViews = NSDictionaryOfVariableBindings(_iconImageView, _bigDescriptionLabel, _mainButton);
    NSArray *horizontalLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-54.0-[_bigDescriptionLabel]-54.0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:labelViews];
    NSArray *verticalLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_iconImageView]-20.0-[_bigDescriptionLabel]-20.0-[_mainButton]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:labelViews];
    [NSLayoutConstraint activateConstraints:horizontalLabelConstraints];
    [NSLayoutConstraint activateConstraints:verticalLabelConstraints];
    
    // Button
    
    NSDictionary *mainBtnMetrics   = @{@"height": @(kMainButtonHeight)};
    NSDictionary *mainBtnViews = NSDictionaryOfVariableBindings(_mainButton);
    NSArray *horizontalBtnConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20.0-[_mainButton]-20.0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:mainBtnViews];
    NSArray *verticalBtnConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mainButton(height)]-90.0-|"
                                                                               options:0
                                                                               metrics:mainBtnMetrics
                                                                                 views:mainBtnViews];
    [NSLayoutConstraint activateConstraints:horizontalBtnConstraints];
    [NSLayoutConstraint activateConstraints:verticalBtnConstraints];
    
    _mainButton.layer.cornerRadius = kMainButtonHeight / 2.0;
    _mainButton.layer.masksToBounds = YES;
}

- (void)setOnCloseBlock:(AlertClosedBlock)block{
    _onCloseBlock = block;
}

- (void)mainButtonTouched{
    if (_onCloseBlock){
        _onCloseBlock();
    }
    if (_animatedClosing) {
        [UIView animateWithDuration:kAlertFullscreenViewAnimationShowingDuration animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
    else{
        [self removeFromSuperview];
    }
}

- (NSDictionary *)iconMetrics{
    return @{@"width": @(88.0), @"height": @(88.0)};
}

- (UIImage *)backgroundImage{
    UIImage *image = [UIImage imageNamed:@""];
    return image;
}

- (UIImage *)iconImage{
    UIImage *image = [UIImage imageNamed:@""];
    return image;
}

- (NSAttributedString *)bigDescriptionText{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 2.0;
    style.paragraphSpacing = 5.0;
    style.alignment = NSTextAlignmentCenter;
    NSString *rawText = [self bigDescriptionNotFormattedText];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSParagraphStyleAttributeName: style};
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:rawText attributes:attributes];
    return text;
}

- (NSString *)bigDescriptionNotFormattedText{
    return @"Lorem Ipsum\n\n is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
}

- (NSAttributedString *)mainButtonConfiguredTitle{
    UIColor *textColor = [self mainButtonTitleColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor,
                                 NSFontAttributeName: [UIFont systemFontOfSize:13.0f]};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[self mainButtonText] attributes:attributes];
    return attrText;
}

- (UIColor *)mainButtonTitleColor{
    return [UIColor colorWithRed:11/255.0 green:11/255.0 blue:11/255.0 alpha:1];
}

- (NSString *)mainButtonText{
    if (_mainButtonText == nil) {
        _mainButtonText =  @"Close";
    }
    
    return _mainButtonText;
}

- (void)setMainButtonText:(NSString *)text{
    _mainButtonText = text;
}

- (UIColor *)mainButtonBackgroundColor{
    return [UIColor whiteColor];
}

- (void)setAnimatedClosing:(BOOL)animated{
    _animatedClosing = animated;
}

- (BOOL)animatedClosing{
    return _animatedClosing;
}

@end
