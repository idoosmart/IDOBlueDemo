//
//  UpdateViewController.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UpdateViewController.h"
#import "FileTableViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightButton];
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.model = self.model;
    self.tableView.tableHeaderView = self.statusLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightButton
{
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)rightButton:(id)sender
{
    FileTableViewController * fileVC = [[FileTableViewController alloc]init];
    self.filePath = nil;
    __weak typeof(self) weakSelf = self;
    fileVC.selectFile = ^(NSString *filePath) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.filePath = filePath;
        strongSelf.model.updateLogStr = [self selectedFileWithFilePath:filePath];
        strongSelf.model.dataArray = @[@{@"type":@"textView",@"textView":@[strongSelf.model.updateLogStr?:@""]}];
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:fileVC animated:YES];
}


- (NSString *)selectedFileWithFilePath:(NSString *)filePath
{
    if (filePath.length == 0) return @"";
    NSURL * fileUrl = [NSURL URLWithString:filePath];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    if (!data) {
        data = [NSData dataWithContentsOfURL:fileUrl];
    }
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileUrl.lastPathComponent];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * typeStr = [@"Type : "stringByAppendingString:@"Distribution packet"];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    NSString * lineStr = @"#********************************************#";
    NSString * fileInfo = [NSString stringWithFormat:@"%@\n%@\n%@\n",lineStr,fileStr,lineStr];
    return fileInfo;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
