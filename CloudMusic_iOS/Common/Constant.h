#pragma mark - font
#define FONT_HELVETICALNEUE_BOLD_SETTING(__s__)         [UIFont fontWithName:@"HelveticaNeue-Bold" size:__s__]
#define FONT_HELVETICALNEUE_SETTING(__s__)              [UIFont fontWithName:@"HelveticaNeue" size:__s__]

#define MRScreenWidth                                   CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight                                  CGRectGetHeight([UIScreen mainScreen].applicationFrame)


#pragma mark -------------------------------  获得颜色
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kGetColorRgba(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)


#pragma mark ------------------------------- 屏幕

#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width




#pragma mark -------------------------------  加载nib文件
#define LOAD_NIB(_NibName_) [[NSBundle mainBundle] loadNibNamed:_NibName_ owner:nil options:nil][0]
#pragma mark -------------------------------  /**字体*/
#define FONT(size)                                     [UIFont systemFontOfSize:size]
#pragma mark -------------------------------  /**每页数据量*/
#define PageSize   10

#define UmengAppkey @"5664fedbe0f55a03eb0016dd"     //友盟key

#pragma mark -------------------------------  分享地址
#define QW_SHARE_ADRESS                    @"http://qw.lionkeji.com/download.html"

#pragma mark -------------------------------  数据库
#define k_DB_NAME                    @"PeopleStreet.sqlite"


#define Key_User_password @"password"  //用户密码
#define Key_User_userId  @"userId"      //用户id
#define Key_User_onlineKey @"onlineKey"    //在线key
#define Key_User_musePayUserId @"musePayUserId"    //通联支付用户ID

