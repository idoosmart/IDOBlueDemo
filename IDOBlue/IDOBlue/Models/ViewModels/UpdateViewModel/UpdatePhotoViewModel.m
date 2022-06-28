//
//  UpdatePhotoViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/12/5.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "UpdatePhotoViewModel.h"
#import "FileViewModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "TextViewCellModel.h"
#import "TextFieldCellModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface UpdatePhotoViewModel()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,NSString * titleStr);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,strong) UIImagePickerController * picker;
@property (nonatomic,weak) UIViewController * currentVc;
@end

@implementation UpdatePhotoViewModel

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   self.picker = nil;
    self.currentVc = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"selected agps file");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getViewWillDisappearCallback];
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(selectFileNotice:)
                                                    name:@"idoDemoSelectFileNotice"
                                                  object:nil];
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    /*
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 1;
    vc.model = fileModel;
    vc.title = lang(@"selected agps file");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
    */
    [self tapUserImageView];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    NSString * infoStr = [self selectedFileWithFilePath:filePath];
    [self addMessageText:infoStr];
}

- (void)getViewWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
    };
}

- (void)getCellModels
{
    /*
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    if ([filePath rangeOfString:@".png"].location != NSNotFound) {
        self.logStr = [self selectedFileWithFilePath:filePath];
    }*/
     
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = lang(@"file name:");
    model4.data = @[@"wallpaper.z"];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"photo update")];
    model1.cellHeight = 70.0f;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data    = @[lang(@"删除壁纸表盘")];
    model5.cellHeight = 70.0f;
    model5.buttconCallback = self.buttconCallback;
    model5.cellClass  = [OneButtonTableViewCell class];
        
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.data    = @[self.logStr ?: @""];
    model2.textViewCallback = self.textViewCallback;
    model2.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model2.cellClass  = [OneTextViewTableViewCell class];
    
    LabelCellModel * model3 = [[LabelCellModel alloc]init];
    model3.typeStr = @"oneLabel";
    model3.data = @[@"0"];
    model3.cellHeight = 100.0f;
    model3.cellClass  = [OneLabelTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.fontSize   = 50;
    model3.isShowLine = YES;
    model3.isCenter   = YES;
    
    self.cellModels = @[model4,model1,model5,model2,model3];
}

- (NSString *)selectedFileWithFilePath:(NSString *)filePath
{
    LabelCellModel * model = [self.cellModels lastObject];
    model.data = @[@"0"];
    if (filePath.length == 0) return @"";
    NSString * fileName = @"";
    NSString * path = @"";
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    NSRange range = [filePath rangeOfString:@"Documents"];
    if (range.location != NSNotFound) {
    fileName = [filePath substringFromIndex:range.location + range.length];
    path = [path stringByAppendingPathComponent: fileName];
    }
    self.filePath = path;
    /*
    NSString * newPath = nil;
    [IDOMakePhotoManager pngTo16Bmp:path bmpPath:&newPath];
     */
    NSURL * url = [NSURL URLWithString:path];
     
    NSString * lastPathComponent = @"";
    if (!url) {
        lastPathComponent = [[path componentsSeparatedByString:@"/"] lastObject]?:@"";
    }else {
        lastPathComponent = url.lastPathComponent;
    }
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:lastPathComponent];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * typeStr = [@"Type : "stringByAppendingString:@"png File"];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    return fileStr;
}

- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels objectAtIndex:1];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 1) {
            [strongSelf updatePhotoWithVc:funcVC];
        }else if (indexPath.row == 2) {
            if (!__IDO_FUNCTABLE__.funcTable34Model.setWallpaperColor) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                return;
            }
            IDOWatchDialInfoItemModel * model = [IDOWatchDialInfoItemModel new];
            model.fileName = @"wallpaper.z";
            model.operate = 0x02;
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"delete the wallpaper dial")]];
            initWatchDialManager().setCurrentDial(^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"delete the wallpaper dial success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"delete the wallpaper dial failed")];
                }
            }, model);
        }
    };
}

- (void)updatePhotoWithVc:(FuncViewController *)funcVC
{
    if (!__IDO_FUNCTABLE__.funcTable26Model.multiDial) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    if ([self.filePath rangeOfString:@".png"].location == NSNotFound) {
        [funcVC showToastWithText:lang(@"please select a png image")];
        return;
    }

    [self startTimer];
    
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"photo update")]];
    initMakePhotoManager().filePath = self.filePath;
    initMakePhotoManager().fileName = @"wallpaper.z";
    __weak typeof(self) weakSelf = self;
    initMakePhotoManager().addPhotoProgress(^(int progress) {
        [funcVC showSyncProgress:progress/100.0f];
    }).addPhotoTransfer(^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
      if (errorCode == 0) {
          [funcVC showToastWithText:lang(@"transfer dial file success")];
      }else if (errorCode == 6) {
          [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
      }else {
          [funcVC showToastWithText:lang(@"transfer dial file failed")];
      }
    });
    [IDOMakePhotoManager startPhotoTransfer];
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)startTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTimer) object:nil];
    LabelCellModel * cellModel = [self.cellModels lastObject];
    NSInteger count = [[cellModel.data lastObject] integerValue];
    count = count + 1;
    cellModel.data = @[[NSString stringWithFormat:@"%ld",(long)count]];
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.cellModels.count - 1 inSection:0];
    [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:1];
}

- (void)tapUserImageView {
    UIActionSheet * headSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:lang(@"cancel") destructiveButtonTitle:nil otherButtonTitles:lang(@"Camera"),lang(@"Album"),nil];
    self.currentVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [headSheet showInView:self.currentVc.view];
}

#pragma mark --- actionsheetDelegate -----
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self photographClick];
            break;
        case 1:
            [self albumClick];
            break;
        default:
            break;
    }
}

- (void)photographClick {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.sourceType = sourceType;
    __weak typeof(self) weakSelf = self;
    [self.currentVc.navigationController presentViewController:self.picker animated:YES completion:^{
         __strong typeof(self) strongSelf = weakSelf;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            UIAlertView *cameraPowerOffTip = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"Camera service is not open, please enter the system 【Settings】> 【IDOBlue】to open the switch" delegate:strongSelf cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [cameraPowerOffTip show];
        }
    }];
}

- (void)albumClick {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.sourceType = sourceType;
    [self.currentVc.navigationController presentViewController:self.picker animated:YES completion:^{
        
    }];
}

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return _picker;
}

#pragma mark --- UIImagePickerControllerDelegate ---
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:NO completion:^{
        __strong typeof(self) strongSelf = weakSelf;
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
        IDOSetTimeInfoBluetoothModel * timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
        NSString * timeStr = [NSString stringWithFormat:@"%04d%02d%02d%02d%02d%02d",(int)timeModel.year,(int)timeModel.month,
        (int)timeModel.day,(int)timeModel.hour,(int)timeModel.minute,(int)timeModel.second];
        documentsPath = [NSString stringWithFormat:@"%@/%@.png",documentsPath,timeStr];
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
            [[NSString string] writeToFile:documentsPath
                                atomically:YES
                                  encoding:NSUTF8StringEncoding
                                     error:nil];
        }
        
        NSFileHandle * wirteFileHandle = [NSFileHandle fileHandleForWritingAtPath:documentsPath];
        if (!wirteFileHandle)return;
        /**
         * Get the device screen information from the local,
         * if there is no screen information, get it through the command
         */
        IDOWatchScreenInfoModel * currentModel = [IDOWatchScreenInfoModel currentModel];
        if (currentModel.height == 0 || currentModel.width == 0) {
            initWatchDialManager().getDialScreenInfo(^(IDOWatchScreenInfoModel * _Nullable model, int errorCode) {
                if (errorCode == 0) {
                    UIImage * newImage = [strongSelf scaleCurrentImage:image
                                                                 width:model.width
                                                                height:model.height];
                    NSData * data = UIImagePNGRepresentation(newImage);
                    [wirteFileHandle seekToEndOfFile];
                    [wirteFileHandle writeData:data];
                    [wirteFileHandle closeFile];
                    NSString * infoStr = [strongSelf selectedFileWithFilePath:documentsPath];
                    [self addMessageText:infoStr];
                }
            });
        }else {
            UIImage * newImage = [strongSelf scaleCurrentImage:image
                                                         width:currentModel.width
                                                        height:currentModel.height];
            NSData * data = UIImagePNGRepresentation(newImage);
            [wirteFileHandle seekToEndOfFile];
            [wirteFileHandle writeData:data];
            [wirteFileHandle closeFile];
            NSString * infoStr = [strongSelf selectedFileWithFilePath:documentsPath];
            [self addMessageText:infoStr];
        }
        
        
    }];
}

- (UIImage *)scaleCurrentImage:(UIImage *)currentImage
                         width:(NSInteger)width
                        height:(NSInteger)height{
    //    CGImageRef imageRef = currentImage.CGImage;
        CGRect rect = CGRectMake(0.f,0.f,width,height);
        UIImage* decompressedImage = [self scaleImage:currentImage size:rect.size];
        return decompressedImage;
        /*
        CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                           rect.size.width,
                                                           rect.size.height,
                                                           CGImageGetBitsPerComponent(imageRef),
                                                           CGImageGetBytesPerRow(imageRef),
                                                           CGImageGetColorSpace(imageRef),
                                                           kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Little
                                                           );
        CGContextDrawImage(bitmapContext, rect, imageRef);

        CGImageRef decompressedImageRef = CGBitmapContextCreateImage(bitmapContext);
        UIImage* decompressedImage = [UIImage imageWithCGImage:decompressedImageRef
                                                         scale:[[UIScreen mainScreen] scale]
                                                   orientation:UIImageOrientationUp];
        CGImageRelease(decompressedImageRef);
        CGContextRelease(bitmapContext);

        return decompressedImage;
         */
}

- (UIImage *)scaleImage:(UIImage *)originImage size:(CGSize)size {
    CGRect rect = CGRectMake(0,0,size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    [originImage drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
