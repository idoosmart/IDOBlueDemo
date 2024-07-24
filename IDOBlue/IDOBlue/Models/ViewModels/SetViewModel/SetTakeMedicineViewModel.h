//
//  SetTakeMedicineViewModel.h
//  IDOBlue
//
//  Created by hedongyang on 2022/8/1.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

@interface SetTakeMedicineViewModel : BaseViewModel
@property (nonatomic,assign) BOOL isAdd;
@property (nonatomic,strong) IDOSetTakingMedicineReminderItemModel * reminderModel;
@property (nonatomic,copy) void(^addReminderTimeComplete)(IDOSetTakingMedicineReminderItemModel * item);
@property (nonatomic,copy) void(^editReminderTimeComplete)(IDOSetTakingMedicineReminderItemModel * item);
- (instancetype)initWithModel:(IDOSetTakingMedicineReminderItemModel *)model;
@end

