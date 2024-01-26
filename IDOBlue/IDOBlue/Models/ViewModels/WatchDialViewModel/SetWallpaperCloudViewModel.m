//
//  SetWallpaperCloudViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2023/2/8.
//  Copyright © 2023 hedongyang. All rights reserved.
//

#import "SetWallpaperCloudViewModel.h"
#import "TextFieldCellModel.h"
#import "UpdatePhotoViewModel.h"
#import "OneTextFieldTableViewCell.h"
#import "FuncViewController.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "NSObject+DemoToDic.h"
#import "OneTextViewTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "FileViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"

@interface SetWallpaperCloudViewModel ()
@property (nonatomic,strong) IDOV3WallpaperDialInfoModel * wallpaperModel;
@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,copy)void(^pickerFileCallback)(NSString * selectStr);

@property (nonatomic,strong) NSString * imagefilePath;
@property (nonatomic,copy)void(^imagePickerFileCallback)(NSString * selectStr);

@property (nonatomic,strong) NSString * wallpaperZipPath;

@property (nonatomic,strong) IDOWallpaperCloudLibModel* wallpaperCloudModel;
@property (nonatomic,strong) IDOWallpaperCloudLibManager* wallpaperCloudManager;

///照片表盘的时间颜色
@property (nonatomic, assign) BOOL timeColorNotSelect;

@property (nonatomic, assign) NSInteger imageWidth;

@property (nonatomic, assign) NSInteger imageHeight;

@end

@implementation SetWallpaperCloudViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titleArray = @[lang(@"selected agps file"),lang(@"Select Picture"),lang(@"display position"),lang(@"time color"),lang(@"widgets Type"),lang(@"widgets bgcolor"),lang(@"widgets location")];
       
        NSString * locStr = self.pickerDataModel.wallpaperLoc[self.wallpaperModel.location];
        self.dataArray = @[lang(@"selected agps file"),lang(@"Select Picture"),locStr,self.wallpaperModel.timeColor?:@"#FFFFFF",lang(@"parameter select"),lang(@"parameter select"),lang(@"parameter select")];
        self.wallpaperCloudManager.timeSelectedColorHex = @"#FFFFFF";
        [self getTextViewCallback];
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getCellModels];
        [self getWatchScreenInfo];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(selectFileNotice:)
                                                    name:@"idoDemoSelectFileNotice"
                                                  object:nil];
        
    }
    return self;
}

-(IDOWallpaperCloudLibManager *)wallpaperCloudManager{
    if (!_wallpaperCloudManager) {
        _wallpaperCloudManager = [IDOWallpaperCloudLibManager new];
    }
    return _wallpaperCloudManager;
}

- (void)actionButton{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 1;
    vc.model = fileModel;
    vc.title = lang(@"selected agps file");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    
    if (filePath.length == 0) return;
    NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * fileName = @"";
    NSString * path = @"";
    if (fileMode == 0) { // bundle
        NSString * mainPath = [NSBundle mainBundle].bundlePath;
        path = [mainPath stringByAppendingPathComponent:@"Files"];
        NSURL * fileUrl = [NSURL URLWithString:filePath];
        fileName = fileUrl.lastPathComponent;
        path = [path stringByAppendingPathComponent:fileName];
    }else { // sandbox
        path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        NSRange range = [filePath rangeOfString:@"Documents"];
        if (range.location != NSNotFound) {
            fileName = [filePath substringFromIndex:range.location + range.length];
            path = [path stringByAppendingPathComponent: fileName];
        }
    }
    if ([fileName containsString:@".zip"]) {
        self.filePath = path;
        self.fileName = [fileName stringByReplacingOccurrencesOfString:@".zip" withString:@""];
        self.pickerFileCallback(fileName);
    }else if ([fileName containsString:@".png"] || [fileName containsString:@".jpg"]){
        self.imagefilePath = path;
        self.imagePickerFileCallback(fileName);
    }
       
}

- (IDOV3WallpaperDialInfoModel *)wallpaperModel
{
    if (!_wallpaperModel) {
         _wallpaperModel = [IDOV3WallpaperDialInfoModel currentModel];
    }
    return _wallpaperModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];

    for (int i = 0; i < 7; i++) {
        TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
        model.typeStr  = @"oneTextField";
        model.titleStr = self.titleArray[i]?:@"";
        model.data = @[self.dataArray[i]?:@""];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneTextFieldTableViewCell class];
        model.modelClass = [NSNull class];
        model.textFeildCallback = self.textFeildCallback;
        model.isShowLine = YES;
        [cellModels addObject:model];
    }
        
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data    = @[lang(@"Extract and read the json dial file")];
    model.cellHeight = 70.0f;
    model.cellClass  = [OneButtonTableViewCell class];
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"Make wallpaper cloud dial file")];
    model1.cellHeight = 70.0f;
    model1.cellClass  = [OneButtonTableViewCell class];
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data    = @[lang(@"transfer the wallpaper dial")];
    model2.cellHeight = 70.0f;
    model2.cellClass  = [OneButtonTableViewCell class];
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[lang(@"get wallpaper dial info")];
    model3.cellHeight = 70.0f;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    TextViewCellModel * model4 = [[TextViewCellModel alloc]init];
    model4.typeStr = @"oneTextView";
    model4.cellHeight = 220;
    model4.cellClass  = [OneTextViewTableViewCell class];
    model4.textViewCallback = self.textViewCallback;
    model4.data = @[@""];
    [cellModels addObject:model4];
    
    self.cellModels = cellModels;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 7) {
            [strongSelf startunCloudZipFileAndReadJsonData:funcVc];
        }else if (indexPath.row == 8) {
            [strongSelf startMakingWapperFromCloud:funcVc];
        }else if (indexPath.row == 9) {
            [strongSelf startInstallWapperFromCloud:funcVc];
        }else if (indexPath.row == 10) {
            [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get wallpaper dial info")]];
            initWatchDialManager().getWallpaperDialInfo(^(IDOV3WallpaperDialInfoModel * _Nullable model, int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:lang(@"get wallpaper dial info success")];
                    NSDictionary * dic = model.dicFromObject;
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@",dic];
                }else if (errorCode == 6) {
                    [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVc showToastWithText:lang(@"get wallpaper dial info failed")];
                }
            });
        }
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if(indexPath.row == 0) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            [strongSelf actionButton];
            strongSelf.pickerFileCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if(indexPath.row == 1) {
            
            //选择图片
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            [strongSelf actionButton];
            strongSelf.imagePickerFileCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            
            
        }else if (indexPath.row == 2) {
            if (strongSelf.fileName.length > 0 ) {
                if (!strongSelf.wallpaperCloudModel) {
                    [funcVC showToastWithText:lang(@"Extract and read the json dial file")];
                    return;
                }
            }else{
                [funcVC showToastWithText:lang(@"selected agps file")];
                return;
            }
            
            NSMutableArray*loctionsTextArray = [NSMutableArray array];
            NSMutableArray*loctionsArray = [NSMutableArray array];
            for (IDONewDialJsonLocationLibModel *modle in strongSelf.wallpaperCloudModel.locations) {
                if (modle.type < strongSelf.pickerDataModel.wallpaperLoc.count) {
                    [loctionsTextArray addObject:strongSelf.pickerDataModel.wallpaperLoc[modle.type]];
                    [loctionsArray addObject:@(modle.type)];
                }
            }
            
            if (loctionsTextArray.count != strongSelf.wallpaperCloudModel.locations.count) {
                [loctionsTextArray removeAllObjects];
                [loctionsTextArray addObjectsFromArray:strongSelf.pickerDataModel.wallpaperLoc];
                
                [loctionsArray removeAllObjects];
                for (int i = 0; i<strongSelf.pickerDataModel.wallpaperLoc.count; i++) {
                    [loctionsArray addObject:@(i)];
                }
            }
            
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = loctionsTextArray;
            NSUInteger index  = [loctionsTextArray containsObject:textField.text] ?
            [loctionsTextArray indexOfObject:textField.text] : 0 ;
            funcVC.pickerView.currentIndex = index;
            
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                FuncViewController*fuu = (FuncViewController *)viewController;
                
                [[fuu tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                NSInteger indexNum  = [loctionsTextArray containsObject:textField.text] ?
                [loctionsTextArray indexOfObject:textField.text] : 0 ;
                
                int loctionIndex = [loctionsArray[indexNum] intValue];
                
                NSLog(@"timeFuncLocation--->%d",loctionIndex);
                
                weakSelf.wallpaperCloudModel.select.timeFuncLocation = loctionIndex;
                
            };
        }else if (indexPath.row == 3) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.widgetColor;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.widgetColor containsObject:textField.text] ?
            [strongSelf.pickerDataModel.widgetColor indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.timeColor = selectStr;
                strongSelf.wallpaperCloudManager.timeSelectedColorHex = selectStr;
            };
        }else if (indexPath.row == 4) {
            if (strongSelf.fileName.length > 0 ) {
                if (!strongSelf.wallpaperCloudModel) {
                    [funcVC showToastWithText:lang(@"Extract and read the json dial file")];
                    return;
                }else if (strongSelf.wallpaperCloudModel.function_support_new != 1){
                    [funcVC showToastWithText:lang(@"Editing of widgets is not supported")];
                    return;
                }
            }else{
                [funcVC showToastWithText:lang(@"selected agps file")];
                return;
            }
            
            //List of all supported widgets
            NSMutableArray*AllTitleItems = [NSMutableArray array];
            for (IDONewDialJsonFunctionListLibModel *itemModel in strongSelf.wallpaperCloudModel.function_list) {
                [AllTitleItems addObject:itemModel.name];
            }
            
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = AllTitleItems;
            NSUInteger index  = [AllTitleItems containsObject:textField.text] ? [AllTitleItems indexOfObject:textField.text] : 0;
            funcVC.pickerView.currentIndex = index;
            
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                FuncViewController*fuu = (FuncViewController *)viewController;
                
                [[fuu tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                for (IDONewDialJsonFunctionListLibModel *itemModel in strongSelf.wallpaperCloudModel.function_list) {
                    if ([selectStr isEqualToString:itemModel.name]) {
                        //功能
                        weakSelf.wallpaperCloudModel.select.function = @[[NSString stringWithFormat:@"%d",itemModel.function]];
                        break;
                    }
                }
                
              
            };
        }else if (indexPath.row == 5) {
            if (strongSelf.fileName.length > 0 ) {
                if (!strongSelf.wallpaperCloudModel) {
                    [funcVC showToastWithText:lang(@"Extract and read the json dial file")];
                    return;
                }else if (strongSelf.wallpaperCloudModel.function_support_new != 1){
                    [funcVC showToastWithText:lang(@"Editing of widgets is not supported")];
                    return;
                }
            }else{
                [funcVC showToastWithText:lang(@"selected agps file")];
                return;
            }
            
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.widgetColor;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.widgetColor containsObject:textField.text] ?
            [strongSelf.pickerDataModel.widgetColor indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                //颜色
                weakSelf.wallpaperCloudModel.select.funcBgColor = selectStr;
                weakSelf.wallpaperCloudModel.select.funcFgColor = selectStr;

            };
        }else if (indexPath.row == 6) {
            if (strongSelf.fileName.length > 0 ) {
                if (!strongSelf.wallpaperCloudModel) {
                    [funcVC showToastWithText:lang(@"Extract and read the json dial file")];
                    return;
                }else if (strongSelf.wallpaperCloudModel.function_support_new != 1){
                    [funcVC showToastWithText:lang(@"Editing of widgets is not supported")];
                    return;
                }else if (weakSelf.wallpaperCloudModel.select.function.count <= 0){
                    [funcVC showToastWithText:lang(@"selected widgets Type")];
                    return;
                }
            }else{
                [funcVC showToastWithText:lang(@"selected agps file")];
                return;
            }
            
            int widgetsType = weakSelf.wallpaperCloudModel.select.function.firstObject.intValue;
            
            //List of all supported widgets location
            NSMutableArray*AllTitleItems = [NSMutableArray array];
            for (IDONewDialJsonLocationLibModel *itemModel in strongSelf.wallpaperCloudModel.locations) {
                BOOL isSupport = NO;
                for (IDONewDialJsonFunctionCoordinateLibModel *locitemModel in itemModel.function_coordinate) {
                    if (widgetsType == locitemModel.function) {
                        isSupport = YES;
                    }
                }
                if (isSupport) {
                    [AllTitleItems addObject:[NSString stringWithFormat:@"%d",itemModel.type]];
                }
            }
            
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = AllTitleItems;
            NSUInteger index  = [AllTitleItems containsObject:textField.text] ? [AllTitleItems indexOfObject:textField.text] : 0;
            funcVC.pickerView.currentIndex = index;
            
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                FuncViewController*fuu = (FuncViewController *)viewController;
                
                [[fuu tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                // select widgets location
                weakSelf.wallpaperCloudModel.select.funcLocationType = selectStr.intValue;
              
            };
        }
    };
}

//开始解压云照片表盘和读取json文件
//start unzip Wallpaper Cloud dial and read json data
- (void)startunCloudZipFileAndReadJsonData:(FuncViewController*)funcVc{
    
    if(self.fileName.length <= 0){
        [funcVc showToastWithText:lang(@"selected agps file")];
        return;
    }
    NSString*tip = [NSString stringWithFormat:@"%@...",lang(@"Extract and read the json dial file")];
    [funcVc showToastWithText:tip];
    __weak typeof(self) weakSelf = self;
    
    IDOWallpaperFileLibManager*dialManager = [[IDOWallpaperFileLibManager alloc] initWithFirmwareName:self.fileName];
    NSString *destination = dialManager.dialRootPath;
    
    NSString*unzipPath = [IDOWallpaperFileLibManager dialZipRootPath:self.fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:unzipPath]) {
        
        IDOWallpaperCloudLibModel* wallpaperCloudModel = [IDOWallpaperFileLibManager readAppJsonFile:[IDOWallpaperFileLibManager dialZipRootPath:self.fileName] firmwareName:self.fileName];

        self.wallpaperCloudModel = wallpaperCloudModel;
        self.wallpaperCloudManager.dialJsonObj = wallpaperCloudModel;
        
    }else{
        [dialManager unzipFileAtPath:self.filePath destination:destination shouldUpdateUnzip:YES callback:^(IDODialZipStausType status, CGFloat progress, NSInteger errorCode, NSInteger finishTime) {
            __strong typeof(self) strongSelf = weakSelf;
            if (status == IDODialZipStaus_UnZipSucc) {
                IDOWallpaperCloudLibModel* wallpaperCloudModel = [IDOWallpaperFileLibManager readAppJsonFile:[IDOWallpaperFileLibManager dialZipRootPath:strongSelf.fileName] firmwareName:strongSelf.fileName];

                strongSelf.wallpaperCloudModel = wallpaperCloudModel;
                strongSelf.wallpaperCloudManager.dialJsonObj = wallpaperCloudModel;
             
            }else{
                
            }
        }];        
    }

    
}

//开始制作云照片表盘
//start Making Wallpaper Cloud dial
- (void)startMakingWapperFromCloud:(FuncViewController*)funcVc{
    
    if(self.fileName.length > 0){
        if (!self.wallpaperCloudModel) {
            [funcVc showToastWithText:lang(@"Please first operate the button to extract and read the JSON dial file")];
            return;
        }
    }else{
        [funcVc showToastWithText:lang(@"selected agps file")];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    UIImage *select=[[UIImage alloc]initWithContentsOfFile:self.imagefilePath];
    select = [self scaleImage:select size:CGSizeMake(self.imageWidth, self.imageHeight)];
    
    
    if (self.wallpaperCloudModel.imageBgsize.width > 0) {
        select = [self scaleImage:select size:CGSizeMake(self.wallpaperCloudModel.imageBgsize.width, self.wallpaperCloudModel.imageBgsize.height)];
    }
    
    UIImage*previewImage = select;
    if (self.wallpaperCloudModel.imagePreviewize.width > 0) {
        previewImage = [self scaleImage:previewImage size:CGSizeMake(self.wallpaperCloudModel.imagePreviewize.width, self.wallpaperCloudModel.imagePreviewize.height)];
    }
    
    
    NSString*tip = [NSString stringWithFormat:@"%@...",lang(@"Make wallpaper cloud dial file")];

    [funcVc showToastWithText:tip];
    
    [self.wallpaperCloudManager unZipFirmwareWithReplaceBgImage:select withPreviewSetImage:previewImage withFirmwareName:self.fileName withZipName:self.fileName callback:^(IDOWallpaperWCInstallFaceLog status, NSString * _Nonnull wallpaperZipPath) {
        __strong typeof(self) strongSelf = weakSelf;
        if (status == IDOWallpaperWCInstallFaceLogUpgradeSucc) {
            strongSelf.wallpaperZipPath = wallpaperZipPath;
        }else{
            [funcVc showToastWithText:lang(@"transfer dial file failed")];
        }
    }];
    
}

//开始传输云照片表盘
//start Install Wallpaper Cloud dial
- (void)startInstallWapperFromCloud:(FuncViewController*)funcVc{
    
    if(self.fileName.length <= 0){
        [funcVc showToastWithText:lang(@"selected agps file")];
        return;
    }
    
    if(self.wallpaperZipPath.length <= 0){
        [funcVc showToastWithText:lang(@"selected agps file")];
    }
    NSString*tip = [NSString stringWithFormat:@"%@...",lang(@"transfer the wallpaper dial")];
    [funcVc showToastWithText:tip];
    
    NSString*uniquefileNameId = self.fileName;// [NSString stringWithFormat:@"csutomTitan_%d",arc4random_uniform(100)+1];

    initWatchDialManager().getDialScreenInfo(^(IDOWatchScreenInfoModel * _Nullable model, int errorCode) {
        
        [SetWallpaperCloudViewModel deleteDial:uniquefileNameId block:^(NSInteger errorCode) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                IDOWatchScreenInfoModel *modelScreen = [IDOWatchScreenInfoModel currentModel];
                
                initWatchDialManager().addDialProgress(^(int progress) {
                    NSLog(@"云照片表盘安装进度%d",progress);
                    [funcVc showSyncProgress:progress/100.0f];
                }).addDialTransfer(^(int errorCode, int finishingTime) {
                    if (errorCode == 0) {
                        //成功
                        NSLog(@"照片云表盘安装成功: name = %@",uniquefileNameId);
                        //设为当前表盘
                        [SetWallpaperCloudViewModel setCurrentDial:self.fileName block:^(NSInteger errorCode) {
                            NSLog(@"设为当前表盘结果：%@", [IDOErrorCodeToStr errorCodeToStr:errorCode]);
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"sucSettingDial" object:nil];
                        }];
                        [funcVc showToastWithText:lang(@"transfer dial file success")];
                    }else{
                        NSLog(@"照片云表盘安装失败 errorCode %@ %@",@(errorCode), [IDOErrorCodeToStr errorCodeToStr:errorCode]);
                        [funcVc showToastWithText:lang(@"transfer dial file failed")];
                    }
                });
                initWatchDialManager().colorFormat = modelScreen.colorFormat;
                initWatchDialManager().filePath = self.wallpaperZipPath;
                initWatchDialManager().blockSize = modelScreen.blockSize;
                initWatchDialManager().uniqueId = uniquefileNameId;
                
                [IDOWatchDialManager startDialTransfer];
            });
        }];

    });
    
    
    
}

/// 删除表盘
/// @param dialName 表盘名字
/// @param block 结果回调
+ (void)deleteDial:(NSString *)dialName block:(void(^_Nullable)(NSInteger errorCode))block {
    if (!dialName || [dialName length] <=0) {
        block(0);
        return;
    }
    IDOWatchDialInfoItemModel *dialModel = [[IDOWatchDialInfoItemModel alloc] init];
    
    dialName = [dialName stringByReplacingOccurrencesOfString:@".zip" withString:@""];
    
    NSString *fileName = dialName;
    if (![dialName hasSuffix:@".iwf"]) {
        fileName = [NSString stringWithFormat:@"%@.iwf",dialName];
    }
    dialModel.fileName = fileName;
    dialModel.operate = 2;
    
    NSLog(@"Watch:准备删除表盘协议：%@", fileName);
    //先判断功能表-做判断条件是否使用v3状态


    dispatch_async(dispatch_get_main_queue(), ^{
        
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            NSLog(@"Watch:删除表盘协议：%@",  [IDOErrorCodeToStr errorCodeToStr:errorCode]);
            if (block) {
                block(errorCode);
            }
        }, dialModel);
    });
}

/// 设置当前表盘
/// @param dialName 表盘名字
/// @param block 结果回调
+ (void)setCurrentDial:(NSString *)dialName block:(void(^_Nullable)(NSInteger errorCode))block {
    if ([dialName length] <= 0) {
        if (block) {
            block(10001);
        }
        return;
    }
    dialName = [dialName stringByReplacingOccurrencesOfString:@".zip" withString:@""];
    
    IDOWatchDialInfoItemModel *dialModel = [[IDOWatchDialInfoItemModel alloc] init];
    dialModel.fileName = [dialName containsString:@"local"] ? dialName : [NSString stringWithFormat:@"%@.iwf",dialName];
    dialModel.operate = 1;
    
    //去除原先设置自定义表盘的接口
    
    dispatch_async(dispatch_get_main_queue(), ^{
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            if (block) {
                block(errorCode);
            }
        }, dialModel);
    });
   
}

///获取表盘尺寸信息
- (void)getWatchScreenInfo{
   
    self.imageWidth = [IDOWatchScreenInfoModel currentModel].width;
    self.imageHeight = [IDOWatchScreenInfoModel currentModel].height;
    
    if (self.imageWidth <= 0 || self.imageHeight <= 0) {
        initWatchDialManager().getDialScreenInfo(^(IDOWatchScreenInfoModel * _Nullable model, int errorCode) {
            self.imageWidth = model.width;
            self.imageHeight = model.height;
        });
    }
}

///删除图片的alpha通道，并且压缩图片大小
- (UIImage *)scaleCurrentImage:(UIImage *)currentImage{
    CGImageRef imageRef = currentImage.CGImage;
    CGRect rect = CGRectMake(0.f, 0.f, self.imageWidth, self.imageHeight);
    if (self.imageWidth > currentImage.size.width ||
        self.imageHeight > currentImage.size.height) {
        rect = CGRectMake(0.f, 0.f, currentImage.size.width, currentImage.size.width);
        UIImage* decompressedImage = [self scaleImage:currentImage size:rect.size];
        return decompressedImage;
    }
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       rect.size.width,
                                                       rect.size.height,
                                                       CGImageGetBitsPerComponent(imageRef),
                                                       CGImageGetBytesPerRow(imageRef),
                                                       CGImageGetColorSpace(imageRef),
                                                       kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Little
                                                       );
    // kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little are the bit flags required
    //  so that the main thread doesn't have any conversions to do.

    CGContextDrawImage(bitmapContext, rect, imageRef);

    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage* decompressedImage = [UIImage imageWithCGImage:decompressedImageRef
                                                     scale:[[UIScreen mainScreen] scale]
                                               orientation:UIImageOrientationUp];
    CGImageRelease(decompressedImageRef);
    CGContextRelease(bitmapContext);

    return decompressedImage;
}

- (UIImage *)scaleImage:(UIImage *)image size:(CGSize)size {
    if (image.size.width == size.width && image.size.height == size.height) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
