//
//  SetMenuView.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/8/17.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "SetMenuView.h"
#import "ScanViewController.h"
#import "FuncViewController.h"
#import "ModeSelectViewModel.h"
#import "IDODemoUtility.h"
#import "Masonry.h"
#import "UITableView+cellSeparator.h"

@interface CustomView : UIView
@property (nonatomic,strong) UIColor * bgColor;
@end

@implementation CustomView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.bounds.size.width/2, 0);  // top
    CGContextAddLineToPoint(context, 0,self.bounds.size.height);  // right
    CGContextAddLineToPoint(context, self.bounds.size.width,self.bounds.size.height);  // left
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context,self.bgColor.CGColor);
    CGContextFillPath(context);
}

@end

@interface SetMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * listArray;
@property (nonatomic,strong) CustomView * arrawView;
@end

@implementation SetMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}

- (CustomView *)arrawView
{
    if (!_arrawView) {
        _arrawView = [[CustomView alloc]init];
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        _arrawView.bgColor = color;
        _arrawView.backgroundColor = [UIColor clearColor];
        [self addSubview:_arrawView];
        [_arrawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@30);
            make.width.equalTo(@20);
            make.height.equalTo(@10);
        }];
    }
    return _arrawView;
}

- (NSArray *)listArray
{
    if (!_listArray) {
        _listArray = @[@{@"icon":@"disconnect",@"title":lang(@"mandatory unbind")},@{@"icon":@"setup",@"title":lang(@"setup")}];
    }
    return _listArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        _tableView.backgroundColor = color;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        __weak typeof(self) weakSelf = self;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.top.equalTo(strongSelf.arrawView.mas_bottom);
            make.width.equalTo(@150);
            make.height.equalTo(@200);
        }];
    }
    return _tableView;
}

#pragma mark- ****************** UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor clearColor];
        [tableView separatorInsetsZero:cell];
    }
    NSDictionary * dic = self.listArray[indexPath.row];
    NSString * imageName = [dic valueForKey:@"icon"]?:@"";
    NSString * titleStr  = [dic valueForKey:@"title"]?:@"";
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text  = titleStr;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark- ****************** UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hidden = YES;
    if (indexPath.row == 0) {
        [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
            if (errorCode == 0) {
                if ([[IDODemoUtility getCurrentVC]isKindOfClass:[ScanViewController class]])return;
                ScanViewController * scanVC  = [[ScanViewController alloc]init];
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                [UIApplication sharedApplication].delegate.window.rootViewController = nav;
            }
        }];
    }else if (indexPath.row == 1){
        FuncViewController * vc = [[FuncViewController alloc]init];
        ModeSelectViewModel * selectModel = [ModeSelectViewModel new];
        vc.model = selectModel;
        vc.title = lang(@"parameter select");
        [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.hidden = YES;
}

- (void)reloadData
{
    self.listArray = nil;
    [self.tableView reloadData];
}

@end
