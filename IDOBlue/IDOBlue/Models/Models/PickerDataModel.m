//
//  PickerDataModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "PickerDataModel.h"

@implementation PickerDataModel
- (NSArray *)tenThousandArray
{
    if (!_tenThousandArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            [array addObject:@(i * 10000)];
        }
        _tenThousandArray = array;
    }
    return _tenThousandArray;
}

- (NSArray *)thousandArray
{
    if (!_thousandArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            [array addObject:@(i * 1000)];
        }
        _thousandArray = array;
    }
    return _thousandArray;
}

- (NSArray *)hundredArray
{
    if (!_hundredArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i <= 100; i++) {
            [array addObject:@(i)];
        }
        _hundredArray = array;
    }
    return _hundredArray;
}

- (NSArray *)bpArray
{
    if (!_bpArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 50; i <= 300; i++) {
            [array addObject:@(i)];
        }
        _bpArray = array;
    }
    return _bpArray;
}

- (NSArray *)tenArray
{
    if (!_tenArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i <= 10; i++) {
            [array addObject:@(i)];
        }
        _tenArray = array;
    }
    return _tenArray;
}

- (NSArray *)heightArray
{
    if (!_heightArray) {
        NSMutableArray * heightArray = [NSMutableArray array];
        for (int i = 100; i< 250; i++) {
            [heightArray addObject:@(i)];
        }
        _heightArray = heightArray;
    }
    return _heightArray;
}

- (NSArray *)weightArray
{
    if (!_weightArray) {
        NSMutableArray * weightArray = [NSMutableArray array];
        for (int i = 20; i< 200; i++) {
            [weightArray addObject:@(i)];
        }
        _weightArray = weightArray;
    }
    return _weightArray;
}

- (NSArray *)hrArray
{
    if (!_hrArray) {
        NSMutableArray * hrArray = [NSMutableArray array];
        for (int i = 50; i<= 300; i++) {
            [hrArray addObject:@(i)];
        }
        _hrArray = hrArray;
    }
    return _hrArray;
}

- (NSArray *)hourArray
{
    if (!_hourArray) {
        NSMutableArray * hourArray = [NSMutableArray array];
        for (int i = 1; i< 24; i++) {
            [hourArray addObject:@(i)];
        }
        _hourArray = hourArray;
    }
    return _hourArray;
}

- (NSArray *)minuteArray
{
    if (!_minuteArray) {
        NSMutableArray * minuteArray = [NSMutableArray array];
        for (int i = 0; i< 60; i++) {
            [minuteArray addObject:@(i)];
        }
        _minuteArray = minuteArray;
    }
    return _minuteArray;
}

- (NSArray *)tempArray
{
    if (!_tempArray) {
        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = -50; i <= 60; i ++) {
            [tempArray addObject:@(i)];
        }
        _tempArray = tempArray;
    }
    return _tempArray;
}

- (NSArray *)goalTypeArray
{
    if (!_goalTypeArray) {
        _goalTypeArray = @[@"目标步数",@"目标卡路里",@"目标距离"];
    }
    return _goalTypeArray;
}

- (NSArray *)weekArray
{
    if (!_weekArray) {
        _weekArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    }
    return _weekArray;
}

- (NSArray *)typeArray
{
    if (!_typeArray) {
        _typeArray = @[@"起床",@"睡觉",@"锻炼",@"吃药",@"约会",@"聚会",@"会议",@"自定义"];
    }
    return _typeArray;
}

- (NSArray *)notifyTitleArray
{
    if (!_notifyTitleArray) {
        _notifyTitleArray = @[@[@"子开关",@"延时时间",@"来电提醒"],
                              @[@"短信",@"邮件",@"微信",@"QQ",@"新浪微博",@"facebook",@"twitter"],
                              @[@"whatsApp",@"messenger",@"instagram",@"linked in",@"日历事件",@"skype",@"闹钟事件",@"pokeman"],
                              @[@"vkontakte",@"line",@"viber",@"kakaoTalk",@"gmail",@"outlook",@"snapchat",@"telegram"]];
    }
    return _notifyTitleArray;
}

- (NSArray *)weatherArray
{
    if (!_weatherArray) {
        _weatherArray =  @[@"其他",@"晴天",@"多云",@"阴天",@"雨",@"暴雨",@"雷阵雨",@"雪",@"雨夹雪",@"台风",@"沙尘暴",@"夜间晴",
                           @"夜间多云",@"热",@"冷",@"清风",@"大风",@"雾霭",@"阵雨",@"多云转晴"];
    }
    return _weatherArray;
}

- (NSArray *)weatherTitleArray
{
    if (!_weatherTitleArray) {
        _weatherTitleArray = @[@"当前天气类型 : ",@"当前温度 : ",@"当天最高温度 : ",@"当天最低温度 : ",@"当前湿度 : ",@"当前紫外线强度 : ",@"当天空气指数 : "];
    }
    return _weatherTitleArray;
}

- (NSArray *)hrModeArray
{
    if (!_hrModeArray) {
        _hrModeArray = @[@"自动模式",@"手动模式",@"关闭"];
    }
    return _hrModeArray;
}

- (NSArray *)distanceUnitArray
{
    if (!_distanceUnitArray) {
        _distanceUnitArray = @[@"无效",@"km",@"mi"];
    }
    return _distanceUnitArray;
}

- (NSArray *)weightUnitArray
{
    if (!_weightUnitArray) {
        _weightUnitArray = @[@"无效",@"kg",@"lb",@"英石"];
    }
    return _weightUnitArray;
}

- (NSArray *)tempUnitArray
{
    if (!_tempUnitArray) {
        _tempUnitArray = @[@"无效",@"°C",@"°F"];
    }
    return _tempUnitArray;
}

- (NSArray *)languageUnitArray
{
    if (!_languageUnitArray) {
        _languageUnitArray = @[@"无效",@"中文",@"英文",@"法语",
                               @"德语",@"意大利语",@"西班牙语",@"日语",
                               @"波兰语",@"捷克语",@"罗马尼亚",@"立陶宛语",
                               @"荷兰语",@"斯洛文尼亚",@"匈牙利语",@"俄罗斯语",
                               @"乌克兰语",@"斯洛伐克语",@"丹麦语",@"克罗地亚"];
    }
    return _languageUnitArray;
}

- (NSArray *)timeUnitArray
{
    if (!_timeUnitArray) {
        _timeUnitArray = @[@"无效",@"24小时制",@"12小时制"];
    }
    return _timeUnitArray;
}

- (NSArray *)strideGpsArray
{
    if (!_strideGpsArray) {
        _strideGpsArray = @[@"无效",@"开",@"关"];
    }
    return _strideGpsArray;
}

- (NSArray *)gpsInfoTitleArray
{
    if (!_gpsInfoTitleArray) {
        _gpsInfoTitleArray = @[@"启动模式 : ",@"操作模式 : ",@"定位周期 : ",@"定位模式 : ",];
    }
    return _gpsInfoTitleArray;
}

- (NSArray *)unitTitleArray
{
    if (!_unitTitleArray) {
        _unitTitleArray = @[@"距离单位 : ",@"体重单位 : ",@"温度单位 : ",@"当前语言 : ",
                            @"走路步长 : ",@"跑步步长 : ",@"GPS步幅校准 : ",@"时间格式 : "];
    }
    return _unitTitleArray;
}

- (NSArray *)sportShortcutTitleArray
{
    if (!_sportShortcutTitleArray) {
        _sportShortcutTitleArray = @[@[@"走路",@"跑步",@"骑行",@"徒步",@"游泳",@"爬山",@"羽毛球",@"其他"],
                                     @[@"健身",@"动感单车",@"椭圆球",@"跑步机",@"仰卧起坐",@"俯卧撑",@"哑铃",@"举重"],
                                     @[@"健身操",@"瑜伽",@"跳绳",@"乒乓球",@"篮球",@"足球",@"排球",@"网球"],
                                     @[@"高尔夫球",@"棒球",@"滑雪",@"轮滑",@"跳舞"]];
    }
    return _sportShortcutTitleArray;
}

- (NSArray *)bootModeArray
{
    if (!_bootModeArray) {
        _bootModeArray = @[@"无效",@"冷启动",@"热启动"];
    }
    return _bootModeArray;
}

- (NSArray *)operatingModeArray
{
    if (!_operatingModeArray) {
        _operatingModeArray = @[@"无效",@"正常",@"低功耗",@"无效",@"Balance",@"1PPS"];
    }
    return _operatingModeArray;
}

- (NSArray *)satelliteModeArray
{
    if (!_satelliteModeArray) {
        _satelliteModeArray = @[@"无效",@"GPS",@"GLONASS",@"GPS+GLONASS"];
    }
    return _satelliteModeArray;
}

- (NSArray *)hotStartTitleArray
{
    if (!_hotStartTitleArray) {
        _hotStartTitleArray = @[@"晶振偏移 : ",@"经度 : ",@"纬度 : ",@"高度 : "];
    }
    return _hotStartTitleArray;
}

- (NSArray *)hotStartplaceholderArray
{
    if (!_hotStartplaceholderArray) {
        _hotStartplaceholderArray = @[@"精确到10^1",@"精确到10^6",@"精确到10^6",@"精确到10^1"];
    }
    return _hotStartplaceholderArray;
}

- (NSArray *)targetTypes
{
    if (!_targetTypes) {
        _targetTypes = @[@"无",@"次",@"米",@"大卡",@"分钟"];
    }
    return _targetTypes;
}

- (NSArray *)sportTypes
{
    if (!_sportTypes) {
        _sportTypes = @[@"无",@"走路",@"跑步",@"骑行",@"徒步",@"游泳"
                        ,@"爬山",@"羽毛球",@"其他",@"健身",@"动感单车",@"椭圆机"
                        ,@"跑步机",@"仰卧起坐",@"俯卧撑",@"哑铃",@"举重",@"健身操"
                        ,@"瑜伽",@"跳绳",@"乒乓球",@"篮球",@"足球",@"排球"
                        ,@"网球",@"高尔夫",@"棒球",@"滑雪",@"轮滑",@"跳舞"
                        ,@"室内划船",@"普拉提",@"交叉训练",@"有氧运动",@"尊巴舞"
                        ,@"广场舞",@"平板支撑",@"健身房"];
    }
    return _sportTypes;
}

- (NSArray *)firmwareTypes
{
    if (!_firmwareTypes) {
        _firmwareTypes = @[@"SoftDevice",@"BootLoader",@"SoftDevice_BootLoader",@"Application"];
    }
    return _firmwareTypes;
}

@end
