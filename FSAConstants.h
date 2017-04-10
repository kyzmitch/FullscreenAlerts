//
//  FSAConstants.h
//
//  Created by Andrey Ermoshin on 25/01/17.
//

#import <Foundation/Foundation.h>

typedef void(^AlertClosedBlock)(void);
typedef void(^AlertBackBlock)(void);

typedef NS_ENUM(NSUInteger, OopsViewType) {
    ErrorView = 100
};

extern float const kMainButtonHeight;
extern float const kAlertFullscreenViewAnimationShowingDuration;
