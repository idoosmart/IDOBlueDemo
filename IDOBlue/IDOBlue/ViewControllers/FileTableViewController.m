//
//  FileTableViewController.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FileTableViewController.h"

@interface FileTableViewController ()
@property (nonatomic,strong) NSIndexPath * currentIndexPath;
@property (nonatomic,strong) NSArray * allFileArr;
@end

@implementation FileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择固件包";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.allFileArr = [self localFileArr];
}

- (NSArray *)localFileArr
{
    NSString * filePath = [NSBundle mainBundle].bundlePath;
    filePath = [filePath stringByAppendingPathComponent:@"firmwares"];
    NSURL * url = [NSURL URLWithString:filePath];
    NSError * error = nil;
    if (!url) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url
                                                        includingPropertiesForKeys:nil
                                                                           options:0
                                                                             error:&error];
    return fileList;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allFileArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString * urlStr = [self.allFileArr objectAtIndex:indexPath.row];
    cell.textLabel.text = urlStr.lastPathComponent;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (_currentIndexPath.row == indexPath.row
        && _currentIndexPath.section == indexPath.section
        && _currentIndexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor blueColor];
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        self.currentIndexPath = indexPath;
        [tableView reloadData];
        NSURL * url = [self.allFileArr objectAtIndex:indexPath.row];
        self.selectFile(url.absoluteString);
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(self) strongSelf = weakSelf;
             [strongSelf.navigationController popViewControllerAnimated:YES];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
