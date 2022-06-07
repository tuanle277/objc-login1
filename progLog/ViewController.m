#import "ViewController.h"
#import "Foundation/Foundation.h"
#import "UserModel.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSHTTPURLResponse *httpResponse;
    NSDictionary *responseDictionary; // -> response dictionary
    NSString *username;
    NSString *password;
    UserModel *customer;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.eLabel.numberOfLines = 0;

    //background image
    UIImage *img = [UIImage imageNamed:@"wallpaper.jpeg"];
    self.background.image = img;
}


- (IBAction)signBtn:(UIButton *)sender {
    NSString *sUsername = self.usernameTxtFld.text;
    NSString *sPassword = self.passwordTxtFld.text;
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://101.99.45.5:8140/%0A%0A/authCustomerController/login"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"application/json;charset=UTF-8",
      @"sessionId": @"71D0278994859FEE0DC59B8DD869F2AD",
      @"Authorization": @"bearer 9daa6535-760f-4c57-b281-225ad4ca3d03",
      @"Cookie": @"JSESSIONID=FA0A7041A4C069BED8A5904A0964D0B1"
    };

    [request setAllHTTPHeaderFields:headers];
    
    NSString *post = [NSString stringWithFormat: @"{\r\n    \"userName\": \"%@\",\r\n    \"password\": \"%@\",\r\n    \"deviceId\": \"3\",\r\n    \"deviceIMEI\": \"123456\",\r\n    \"deviceToken\": \"58077cd9-88fc-40f8-8fdf-69b41be8f1b8\"\r\n}", sUsername, sPassword];
    
    NSData *postData = [[NSData alloc] initWithData:[post dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];

    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
        dispatch_semaphore_signal(sema);
      } else {
        self->httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        self->responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                      
    //get username and password from response
    [customer initWithDict:responseDictionary];
    
    NSLog(@"after username: %@, password: %@, success: %@", [NSString stringWithFormat:@"%@", [responseDictionary valueForKey: @"customer_name"]], [NSString stringWithFormat:@"%@", [responseDictionary valueForKey: @"password"]],[NSString stringWithFormat:@"%@", [responseDictionary valueForKey: @"success"]]);
                      
    NSLog (@"username: %@, password: %@, success: %@", customer.customer_name, customer.password, customer.success);
    
    if ([[NSString stringWithFormat:@"%@", [responseDictionary valueForKey: @"success"]] isEqualToString:@
         "0"]){
        NSLog(@"incorrect");
        self.eLabel.textColor = [UIColor redColor];
        self.eLabel.text = @"username or password incorrect!";
    }
    else {
        NSLog(@"correct");
        self.eLabel.textColor = [UIColor greenColor];
        self.eLabel.text = @"username and password correct!";
    }
}

@end
