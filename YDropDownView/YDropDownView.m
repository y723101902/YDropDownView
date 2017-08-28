//
//  DropDownView.m
//
//

#import "YDropDownView.h"

@implementation YDropDownView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //创建子视图
        [self createSubDropViews];
    }
    return self;
}

#pragma mark -创建子视图
- (void)createSubDropViews {
    //创建button
    _dropBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dropBtn.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    [_dropBtn addTarget:self action:@selector(dropBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _dropBtn.selected = NO;
    [_dropBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _dropBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _dropBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dropBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [_dropBtn setTitle:_defaultStr forState:UIControlStateNormal];
    [self addSubview:_dropBtn];
    
    //创建下拉图标
    _dropImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_dropBtn.frame.size.width - 12, 9, 12, 12)];
    _dropImgView.userInteractionEnabled = YES;
    [_dropBtn addSubview:_dropImgView];
    
    //创建下拉列表
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(_dropBtn.frame.origin.x - 3, 0, _dropBtn.frame.size.width, 0) style:UITableViewStylePlain];
    _listTableView.showsVerticalScrollIndicator = NO;
    _listTableView.showsHorizontalScrollIndicator = NO;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.bounces = NO;
    _listTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _listTableView.layer.borderWidth = 0.5;
    [self addSubview:_listTableView];
}

#pragma mark -重绘页面时调用
- (void)layoutSubviews {
    [super layoutSubviews];
    [_dropBtn setTitle:_defaultStr forState:UIControlStateNormal];
    [_listTableView reloadData];
}

#pragma mark -UITableViewDataSourse
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = @"listCell";
    UITableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (listCell == nil) {
        listCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        listCell.textLabel.font = [UIFont systemFontOfSize:16];
        listCell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    listCell.textLabel.text = _listData[indexPath.row];
    return listCell;
}

#pragma mark -UITabelViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _defaultStr = _listData[indexPath.row];
    _menuBlock(indexPath.row,_listData[indexPath.row]);
    [self dropBtnClick:_dropBtn];
}

#pragma mark -btn点击事件
- (void)dropBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (_delegate && [self.delegate respondsToSelector:@selector(showShadowViewWithBool:)]) {
        [self.delegate showShadowViewWithBool:btn.selected];
    }
    if (btn.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            //添加列表动画
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _maxHeight > 44*_listData.count ?44*_listData.count:_maxHeight);
            _listTableView.hidden = NO;
            _listTableView.frame = CGRectMake(_dropBtn.frame.origin.x, 2, _dropBtn.frame.size.width, self.frame.size.height - 2.5);
        } completion:^(BOOL finished) {
            //完成之后
            
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            //添加列表动画
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _dropBtn.frame.size.height);
            _listTableView.frame = CGRectMake(_dropBtn.frame.origin.x, 2, _dropBtn.frame.size.width, self.frame.size.height - 2.5);
        } completion:^(BOOL finished) {
            //完成之后
            _listTableView.hidden = YES;
        }];
    }
}

#pragma mark -点击阴影视图
- (void)flipUp {
    [UIView animateWithDuration:0.3 animations:^{
        //添加列表动画
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _dropBtn.frame.size.height);
        _listTableView.frame = CGRectMake(_dropBtn.frame.origin.x, 2, _dropBtn.frame.size.width, self.frame.size.height - 2.5);
    } completion:^(BOOL finished) {
        //完成之后
        _listTableView.hidden = YES;
    }];
    _dropBtn.selected = NO;
}

@end
