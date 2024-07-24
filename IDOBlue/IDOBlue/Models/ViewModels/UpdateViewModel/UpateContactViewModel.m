//
//  UpateContactViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2022/3/11.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "UpateContactViewModel.h"
#import "FileViewModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "TextFieldCellModel.h"
#import "EmpltyCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import <Contacts/Contacts.h>

@interface UpateContactViewModel()
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,strong)NSMutableDictionary * contactDic;
@property (nonatomic,copy) NSArray <IDOSetAllContactItemModel *>* items;

@end

@implementation UpateContactViewModel

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getViewWillDisappearCallback];
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
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
    self.logStr = [self selectedFileWithFilePath:filePath];
    */
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"contact update")];
    model1.cellHeight = 70.0f;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
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
    
    self.cellModels = @[model1,model2,model3];
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

- (NSString *)selectedFileWithFilePath:(NSString *)filePath
{
    if (filePath.length == 0) return @"";
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
    
    NSURL * url = [NSURL URLWithString:path];
    NSString * lastPathComponent = @"";
    if (!url) {
        lastPathComponent = [[path componentsSeparatedByString:@"/"] lastObject]?:@"";
    }else {
        lastPathComponent = url.lastPathComponent;
    }
    self.fileName = lastPathComponent;
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:lastPathComponent];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * typeStr = [@"Type : "stringByAppendingString:@"contact file"];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    return fileStr;
}

- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels lastObject];
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
        
        if (!__IDO_FUNCTABLE__.funcTable33Model.v2SupportGetAllContact) {
            [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            return;
        }
        
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            [strongSelf requestContactAuthAfterhLaunch];
            return;
        }else if(status != CNAuthorizationStatusAuthorized){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:lang(@"tip") message:lang(@"To use the frequent contacts, you have to obtain the permission to access your phone’s contacts. Go to the phone’s \"Settings > Privacy > Contacts\" to enable the permission.") preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:lang(@"ok") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancelAction];
            [funcVC presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        
        IDOSetSyncAllContactModel * model = [strongSelf configContactData];
        if (!model) {
            [funcVC showToastWithText:lang(@"The phonebook data has been synchronized")];
            return;
        }else if (model.items.count <= 0){
            [funcVC showToastWithText:lang(@"Address book data is empty")];
            return;
            
        }
        
        [IDOFoundationCommand setSyncAllContactCommand:model
                                              callback:^(int errorCode, NSString * _Nullable path) {
            strongSelf.filePath = path;
            NSString * logStr = [strongSelf selectedFileWithFilePath:path];
            [strongSelf addMessageText:logStr];
            [strongSelf updateWordwithVc:funcVC];
        }];
    };
}

- (void)updateWordwithVc:(FuncViewController *)funcVC
{
    [self startTimer];
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"contact file transfer")]];
    initTransferManager().transferType = IDO_DATA_FILE_TRAN_CONTACT_TYPE;
    initTransferManager().compressionType = IDO_DATA_TRAN_COMPRESSION_NO_USE_TYPE;
    initTransferManager().fileName = @".ml";
    initTransferManager().filePath = self.filePath;
    initTransferManager().numberPackets = 10;
    initTransferManager().isSetConnectParam = YES;
    __weak typeof(self) weakSelf = self;
    initTransferManager().addDetection(^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
        [funcVC showToastWithText:lang(@"transfer complete")];
    }).addProgress(^(int progress) {
        [funcVC showSyncProgress:progress/100.0f];
    }).addTransfer(^(int errorCode,int value) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
        [funcVC showToastWithText:lang(@"transfer complete")];
        if (errorCode == 0) {
            //缓存通讯录字典
            [[NSUserDefaults standardUserDefaults]setObject:weakSelf.contactDic forKey:[weakSelf cacheKey]];

        }
    });
    [IDOTransferFileManager startTransfer];
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}


///通讯录获取权限
///Access to address book
-(void)requestContactAuthAfterhLaunch{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
           CNContactStore *store = [[CNContactStore alloc] init];
           [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
               if (!granted) {
                   NSLog(@"请求通讯录权限:%d,error:%@",granted,error.localizedDescription);
               }
           }];
    }
    
}

///通讯录获取
///Address book acquisition
-(IDOSetSyncAllContactModel*)configContactData{
    // 获取指定的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    NSMutableArray * items = [NSMutableArray new];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
      
        //拼接姓名
        NSString *nameStr = [NSString stringWithFormat:@"%@%@%@",contact.familyName, contact.middleName, contact.givenName];
        NSString *phone = @"";
        NSArray *phoneNumbers = contact.phoneNumbers;
        
        for (CNLabeledValue *labelValue in phoneNumbers) {
            
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSString *string = phoneNumber.stringValue;
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (string.length) {
                phone = string;
                break;
            }
        }
        
        IDOSetAllContactItemModel *model = [[IDOSetAllContactItemModel alloc] init];
        model.name = nameStr;
        model.phone = phone;
        
        if([model.name length] == 0 && [model.phone length] > 0){
            model.name = model.phone;
        }
        
        if (model.phone && [model.phone length] > 0&&[self isEnglishStart:model.name]){
            
            [self.contactDic setObject:model.name?model.name:@""  forKey:model.phone];
           // NSLog(@"model.name = %@,model.phone = %@",model.name,model.phone);
            
            [items addObject:model];
        }

    }];
        
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:[self cacheKey]];
    
    BOOL isSyncAllContact = NO;
    if (!dic) {
        //本地缓存通讯录没数据，发一次
        isSyncAllContact = YES;
    }else if (dic&&[dic isKindOfClass:[NSDictionary class]]&&![dic isEqual:self.contactDic.copy]){
        //本地缓存通讯录变更发一次
        isSyncAllContact = YES;
    }
   
    if (isSyncAllContact) {
        IDOSetSyncAllContactModel * syncAllContactModel = [[IDOSetSyncAllContactModel alloc]init];    //
        
        IDOSetTimeInfoBluetoothModel * timeInfo =[IDOSetTimeInfoBluetoothModel currentModel];
        
        syncAllContactModel.year = timeInfo.year;
        syncAllContactModel.month = timeInfo.month;
        syncAllContactModel.day = timeInfo.day;
        syncAllContactModel.hour = timeInfo.hour;
        syncAllContactModel.minute = timeInfo.minute;
        syncAllContactModel.second  = timeInfo.second;
        
        syncAllContactModel.items = items;
        syncAllContactModel.contactItemNum = items.count;
        return syncAllContactModel;
    }
    
    return nil;
    
}

-(NSString*)cacheKey{
    return [NSString stringWithFormat:@"k_all_contact_%@",__IDO_MAC_ADDR__];
}

/// 判断是否英文字符开头，主要为了临时解决传了中英文通讯录到固件，固件不显示英文名称问题
/// @param name 电话
- (BOOL)isEnglishStart:(NSString*)name{
    if(!name||name.length == 0){
        return NO;
    }
    unichar  str = [name characterAtIndex:0];

    if (str >= 'a' && str <= 'z') {
        return YES;
    }else  if (str >= 'A' && str <= 'Z') {
        return YES;
    }else if (name.integerValue>0){
      //带数字开头的也要
      return YES;
        
    }
    return NO;
}

- (NSMutableDictionary *)contactDic {
    if (!_contactDic) {
        _contactDic = NSMutableDictionary.new;
    }
    return _contactDic;
}
  

@end

