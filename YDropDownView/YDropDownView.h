//
//  YDropDownView.h
//
//

#import <UIKit/UIKit.h>

@protocol YDropDownViewDelegate <NSObject>

- (void)showShadowViewWithBool:(BOOL)isShow;

@end

typedef void (^MenuBlock)(NSInteger, NSString*);

@interface YDropDownView : UIView<UITableViewDelegate,UITableViewDataSource>

//下拉列表
@property (nonatomic, strong) UITableView *listTableView;

//点击button
@property (nonatomic, strong) UIButton *dropBtn;

//下拉图片
@property (nonatomic, strong) UIImageView *dropImgView;

//下拉列表项
@property (nonatomic, strong) NSArray *listData;

//选中的第几项
@property (nonatomic, assign) NSInteger index;

//选项默认值
@property (nonatomic, copy) NSString *defaultStr;

//view初始高度
@property (nonatomic, assign) NSInteger dropHeight;

//view最大高度
@property (nonatomic, assign) NSInteger maxHeight;

@property (nonatomic, copy) MenuBlock menuBlock;

@property (nonatomic, assign) id<YDropDownViewDelegate>delegate;

//收起列表
- (void)flipUp;

@end
