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
#import "IDODemoUtility.h"
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

- (void)setIsLeftType:(BOOL)isLeftType
{
    _isLeftType = isLeftType;
    if (_isLeftType) {
        [self.arrawView mas_remakeConstraints:^(MASConstraintMaker *make) {
            CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
            CGRect rectNav = [IDODemoUtility getCurrentVC].navigationController.navigationBar.frame;
            make.top.equalTo(@(rectStatus.size.height + rectNav.size.height));
            make.left.equalTo(@30);
            make.width.equalTo(@20);
            make.height.equalTo(@10);
        }];
        __weak typeof(self) weakSelf = self;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.top.equalTo(strongSelf.arrawView.mas_bottom);
            make.width.equalTo(@150);
            make.height.equalTo(@200);
        }];
    }else {
        [self.arrawView mas_remakeConstraints:^(MASConstraintMaker *make) {
            CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
            CGRect rectNav = [IDODemoUtility getCurrentVC].navigationController.navigationBar.frame;
            make.top.equalTo(@(rectStatus.size.height + rectNav.size.height));
            make.right.equalTo(@(-30));
            make.width.equalTo(@20);
            make.height.equalTo(@10);
        }];
        __weak typeof(self) weakSelf = self;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.right.equalTo(@(-16));
            make.top.equalTo(strongSelf.arrawView.mas_bottom);
            make.width.equalTo(@150);
            make.height.equalTo(@200);
        }];
    }
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
    
    if (self.selectMenuList) {
        self.selectMenuList(indexPath.row);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.hidden = YES;
}

- (void)reloadData
{
    [self.tableView reloadData];
}

@end
