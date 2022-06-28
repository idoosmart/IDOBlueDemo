//
//  TakingPictureViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/3.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "TakePictureViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface TakePictureViewModel()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation TakePictureViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCameraCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data = @[lang(@"turn on the camera")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data = @[lang(@"turn off camera")];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        [funcVC showLoadingWithMessage:lang(@"set the camera switch...")];
        if (indexPath.row == 0) {
            [IDOFoundationCommand cameraStartCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"setting up Camera Successfully")];
                    [strongSelf openCameraWithViewController:funcVC];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"failed to set up camera")];
                }
            }];
        }else {
            [IDOFoundationCommand cameraStopCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"setting up Camera Successfully")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"failed to set up camera")];
                }
            }];
        }
    };
}
- (void)openCameraWithViewController:(UIViewController *)vc
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }
    self.imagePickerController = imagePickerController;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        [IDOFoundationCommand cameraStopCommand:^(int errorCode) {

        }];
    }];
}

- (void)getCameraCallback
{
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand listenPhotoSingleShotCommand:^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.imagePickerController takePicture];
    }];
        
    [IDOFoundationCommand listenPhotoStartCommand:^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        UIViewController * vc = [IDODemoUtility getCurrentVC];
        [strongSelf openCameraWithViewController:vc];
    }];
    
    [IDOFoundationCommand listenPhotoEndCommand:^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
