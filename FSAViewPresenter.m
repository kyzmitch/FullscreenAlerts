//
//  PCOopsViewPresenter.m
//
//  Created by Andrey Ermoshin on 25/01/17.
//

#import "FSAViewPresenter.h"
#import "FSAViewsFactory.h"

@implementation FSAViewPresenter

+ (void)showAlertOfType:(OopsViewType)type animated:(BOOL)animated onClose:(AlertClosedBlock)onClose{
    [FSAViewPresenter showAlertOfType:type withText:nil animated:animated onClose:onClose];
}

+ (void)showAlertOfType:(OopsViewType)type withText:(NSString *)text animated:(BOOL)animated onClose:(AlertClosedBlock)onClose{
    [FSAViewPresenter showAlertOfType:type withText:text closeButtonTitle:nil animated:animated onClose:onClose onBack:nil];
}

+ (void)showAlertOfType:(OopsViewType)type
               withText:(NSString *)text
               animated:(BOOL)animated
                onClose:(AlertClosedBlock)onClose
                 onBack:(AlertBackBlock)onBack{
    [FSAViewPresenter showAlertOfType:type withText:text closeButtonTitle:nil animated:animated onClose:onClose onBack:onBack];
}

+ (void)showAlertOfType:(OopsViewType)type
               withText:(NSString *)text
       closeButtonTitle:(NSString *)closeButtonTitle
               animated:(BOOL)animated
                onClose:(AlertClosedBlock)onClose
                 onBack:(AlertBackBlock)onBack{
    
    id<FSAViewProtocol> imlementedView = [FSAViewsFactory createWithType:type];
    [imlementedView setOnCloseBlock:onClose];
    if ([imlementedView respondsToSelector:@selector(setOnBackBlock:)]) {
        [imlementedView setOnBackBlock:onBack];
    }
    if (text && [imlementedView respondsToSelector:@selector(setBigDescriptionNotFormattedText:)]){
        [imlementedView setBigDescriptionNotFormattedText:text];
    }
    if ([imlementedView respondsToSelector:@selector(setAnimatedClosing:)]) {
        [imlementedView setAnimatedClosing:animated];
    }
    
    if ([imlementedView isKindOfClass:[UIView class]] == NO) {
        return;
    }
    UIView *view = (UIView *)imlementedView;
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    if (animated) {
        view.alpha = 0;
    }
    
    [window addSubview:view];
    [window bringSubviewToFront:view];
    // to hide keyboard. Never call this method on a view that is not part of an active view hierarchy. 
    [view becomeFirstResponder];
    
    if (animated) {
        [UIView animateWithDuration:kAlertFullscreenViewAnimationShowingDuration animations:^{
            view.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
