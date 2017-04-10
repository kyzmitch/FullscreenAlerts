//
//  PCOopsViewsFactory.h
//
//  Created by Andrey Ermoshin on 18/01/17.
//

#import <Foundation/Foundation.h>
#import "FSAViewProtocol.h"
#import "FSAConstants.h"

@interface FSAViewsFactory : NSObject

+ (id<FSAViewProtocol>)createWithType:(OopsViewType)type;

@end
