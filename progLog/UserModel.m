#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserModel ()

@end

@implementation UserModel

- (void) initWithDict:(NSDictionary *)dict {
    self.success = [dict valueForKey: @"success"];
    self.customer_name = [[dict valueForKey: @"customer"] valueForKey: @"customer_name"];
    self.password = [[dict valueForKey: @"customer"] valueForKey: @"password"];
};

@end
