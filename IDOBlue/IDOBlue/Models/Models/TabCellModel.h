//
//  TabCellModel.h
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/22.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"

@interface TabCellModel : BaseCellModel
@property (nonatomic,copy)void(^threeButtonCallback)(NSInteger index,UITableViewCell * tableViewCell);
@property (nonatomic,strong) NSArray * selectIndexs;
@end
