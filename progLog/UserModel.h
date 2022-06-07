
#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//@property *success;
@property (nonatomic, strong)NSNumber *success;
@property (nonatomic, strong)NSString *customer_name;
@property (nonatomic, strong)NSString *password;

- (void) initWithDict: (NSDictionary *) dict;

@end
