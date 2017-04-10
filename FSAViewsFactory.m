//
//  PCOopsViewsFactory.m
//
//  Created by Andrey Ermoshin on 18/01/17.
//

#import "FSAViewsFactory.h"
#import "BaseFullscreenAlertView.h"
#import "ErrorAlertView.h"

@implementation FSAViewsFactory

+ (id<FSAViewProtocol>)createWithType:(OopsViewType)type{
    id<FSAViewProtocol> resultView;
    
    switch (type) {
        case ErrorView:
            resultView = [ErrorAlertView new];
            break;
        default:
            resultView = [BaseFullscreenAlertView new];
            break;
    }
    return resultView;
}

@end
