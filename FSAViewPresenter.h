//
//  PCOopsViewPresenter.h
//
//  Created by Andrey Ermoshin on 25/01/17.
//

#import <Foundation/Foundation.h>
#import "FSAConstants.h"

@interface FSAViewPresenter : NSObject

+ (void)showAlertOfType:(OopsViewType)type animated:(BOOL)animated onClose:(AlertClosedBlock)onClose;
+ (void)showAlertOfType:(OopsViewType)type withText:(NSString *)text animated:(BOOL)animated onClose:(AlertClosedBlock)onClose;

+ (void)showAlertOfType:(OopsViewType)type
               withText:(NSString *)text
               animated:(BOOL)animated
                onClose:(AlertClosedBlock)onClose
                 onBack:(AlertBackBlock)onBack;

+ (void)showAlertOfType:(OopsViewType)type
               withText:(NSString *)text
       closeButtonTitle:(NSString *)closeButtonTitle
               animated:(BOOL)animated
                onClose:(AlertClosedBlock)onClose
                 onBack:(AlertBackBlock)onBack;

@end
