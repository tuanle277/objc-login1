#import <UIKit/UIKit.h>
#import "UserModel.h"


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UITextField *usernameTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtFld;
@property (weak, nonatomic) IBOutlet UILabel *eLabel;

- (IBAction)signBtn:(UIButton *)sender;

@end

