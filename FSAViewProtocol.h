//
//  FSAViewProtocol.h
//
//  Created by Andrey Ermoshin on 25/01/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FSAConstants.h"

@protocol FSAViewProtocol <NSObject>

@required
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *bigDescriptionLabel;
@property (strong, nonatomic) UIButton *mainButton;

- (UIImage *)backgroundImage;
- (UIImage *)iconImage;
- (NSAttributedString *)bigDescriptionText;
- (NSString *)bigDescriptionNotFormattedText;
- (NSAttributedString *)mainButtonConfiguredTitle;
- (NSString *)mainButtonText;
- (void)setMainButtonText:(NSString *)text;
- (UIColor *)mainButtonBackgroundColor;
- (UIColor *)mainButtonTitleColor;
- (NSDictionary *)iconMetrics;
- (void)setIconConstraints;
- (void)setAnimatedClosing:(BOOL)animated;
- (BOOL)animatedClosing;

@optional
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIImageView *brandLogoImageView;

- (UIImage *)backButtonImage;
- (void)setBigDescriptionNotFormattedText:(NSString *)text;
- (UIImage *)logoImage;

- (void)setOnCloseBlock:(AlertClosedBlock)block;
- (void)setOnBackBlock:(AlertBackBlock)block;

@end
