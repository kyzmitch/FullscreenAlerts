//
//  ErrorAlertView.m
//
//  Created by Andrey Ermoshin on 26/01/17.
//

#import "ErrorAlertView.h"

@interface ErrorAlertView ()
{
@private
    NSString *_bigDescriptionText;
}
@end

@implementation ErrorAlertView

- (UIImage *)backgroundImage{
    UIImage *image = [UIImage imageNamed:@""];
    return image;
}

- (UIImage *)iconImage{
    UIImage *image = [UIImage imageNamed:@""];
    return image;
}

- (NSString *)bigDescriptionNotFormattedText{
    if (_bigDescriptionText == nil){
        _bigDescriptionText = @"We apologize, application ran into an unexpected problem";
    }
    return _bigDescriptionText;
}

- (void)setBigDescriptionNotFormattedText:(NSString *)text{
    _bigDescriptionText = text;
    self.bigDescriptionLabel.attributedText = [self bigDescriptionText];
}

- (UIColor *)mainButtonTitleColor{
    return [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:1];
}

- (NSString *)mainButtonText{
    return @"Close";
}

- (UIColor *)mainButtonBackgroundColor{
    return [UIColor whiteColor];
}

@end
