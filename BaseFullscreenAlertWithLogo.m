//
//  BaseFullscreenAlertWithLogo.m
//
//  Created by Andrey Ermoshin on 01/02/17.
//

#import "BaseFullscreenAlertWithLogo.h"

@implementation BaseFullscreenAlertWithLogo

@synthesize brandLogoImageView = _brandLogoImageView;

- (instancetype)init{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _brandLogoImageView = [[UIImageView alloc] init];
    _brandLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_brandLogoImageView];
    _brandLogoImageView.image = [self logoImage];
    
    return self;
}

- (void)setIconConstraints{
    // logo
    NSDictionary *logoMetrics   = @{@"width": @(161.0), @"height": @(48.0)};
    UIImageView *icon = self.iconImageView;
    NSDictionary *iconViews = NSDictionaryOfVariableBindings(_brandLogoImageView, icon, self);
    NSArray *horizontalLogoConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[_brandLogoImageView]"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:logoMetrics
                                                                                   views:iconViews];
    NSArray *verticalLogoConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-48.0-[_brandLogoImageView(height)]"
                                                                               options:0
                                                                               metrics:logoMetrics
                                                                                 views:iconViews];
    [NSLayoutConstraint activateConstraints:horizontalLogoConstraints];
    [NSLayoutConstraint activateConstraints:verticalLogoConstraints];
    
    // Icon reinit
    // Icon
    
    NSArray *horizontalIconConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[icon]"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:[self iconMetrics]
                                                                                   views:iconViews];
    NSArray *verticalIconConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_brandLogoImageView]-98.0-[icon(height)]"
                                                                               options:0
                                                                               metrics:[self iconMetrics]
                                                                                 views:iconViews];
    [NSLayoutConstraint activateConstraints:horizontalIconConstraints];
    [NSLayoutConstraint activateConstraints:verticalIconConstraints];
}

- (void)layoutSubviews{
    NSLog(@"BaseFullscreenAlertWithLogo: layoutSubviews");
    [self setIconConstraints];
    // need to call after internal constraints adding
    [super layoutSubviews];
}

- (UIImage *)logoImage{
    NSLog(@"BaseFullscreenAlertWithLogo: logoImage not implemented - need to subclass");
    return nil;
}

@end
