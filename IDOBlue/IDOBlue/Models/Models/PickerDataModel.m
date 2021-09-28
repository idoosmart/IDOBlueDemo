//
//  PickerDataModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "PickerDataModel.h"
#import "IDODemoUtility.h"

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
        for (int i = 0; i< 24; i++) {
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

- (NSArray *)screenModeArray
{
    if (!_screenModeArray) {
        _screenModeArray = @[lang(@"turn off auto tune"),lang(@"use ambient light sensors"),
                             lang(@"auto brightness at night"),lang(@"set time for night dimming")];
    }
    return _screenModeArray;
}

- (NSArray *)goalTypeArray
{
    if (!_goalTypeArray) {
        _goalTypeArray = @[lang(@"target step"),lang(@"target calories"),lang(@"target distance")];
    }
    return _goalTypeArray;
}

- (NSArray *)weekArray
{
    if (!_weekArray) {
        _weekArray = @[lang(@"monday"),lang(@"tuesday"),lang(@"wednesday"),lang(@"thursday"),lang(@"friday"),lang(@"saturday"),lang(@"sunday")];
    }
    return _weekArray;
}

- (NSArray *)weekTypeArray
{
    if (!_weekTypeArray)
    {
        NSMutableArray * weekTypeMArray = [NSMutableArray array];
        for (int i = 0; i< 7; i++)
        {
            [weekTypeMArray addObject:@(i)];
        }
        _weekTypeArray = weekTypeMArray;
    }
    return _weekTypeArray;
}


- (NSArray *)monthArray
{
    if (!_monthArray)
    {
        NSMutableArray * monthMArray = [NSMutableArray array];
        for (int i = 1; i<= 12; i++)
        {
            [monthMArray addObject:@(i)];
        }
        _monthArray = monthMArray;
    }
    return _monthArray;
}

- (NSArray *)dayArray
{
    if (!_dayArray)
    {
        NSMutableArray * dayMArray = [NSMutableArray array];
        for (int i = 1 ; i <= 30; i++)
        {
            [dayMArray addObject:@(i)];
        }
        _dayArray = dayMArray;
    }
    return _dayArray;
}

- (NSArray *)typeArray
{
    if (!_typeArray) {
        _typeArray = @[lang(@"get up"),lang(@"sleep"),lang(@"exercise"),lang(@"take medicine"),lang(@"date"),lang(@"party"),lang(@"meeting"),lang(@"custom")];
    }
    return _typeArray;
}

- (NSArray *)notifyTitleArray
{
    if (!_notifyTitleArray) {
        _notifyTitleArray = @[@[lang(@"sub-switch"),lang(@"delay time"),lang(@"call reminder")],
                              @[lang(@"sms"),lang(@"email"),lang(@"wechat"),@"QQ",lang(@"sina weibo"),@"facebook",@"twitter"],
                              @[@"whatsapp",@"messenger",@"instagram",@"linked in",lang(@"calendar event"),@"skype",lang(@"alarm event"),@"pokeman"],
                              @[@"vkontakte",@"line",@"viber",@"kakaotalk",@"gmail",@"outlook",@"snapchat",@"telegram"],
                              @[@"chatwork",@"slack",@"yahoo mail",@"tumblr",@"youtube",@"yahoo pinterest"]];
    }
    return _notifyTitleArray;
}

- (NSArray *)weatherArray
{
    if (!_weatherArray) {
        _weatherArray =  @[lang(@"other"),lang(@"sunny days"),lang(@"cloudy1"),lang(@"cloudy2"),lang(@"rain1"),lang(@"rain2"),
                           lang(@"thunder storm"),lang(@"snow"),lang(@"snow rain"),lang(@"typhoon"),lang(@"sandstorm"),lang(@"shine at night"),
                           lang(@"cloudy at night"),lang(@"hot"),lang(@"cold"),lang(@"breezy"),lang(@"windy"),lang(@"misty"),lang(@"showers"),lang(@"cloudy to clear")];
    }
    return _weatherArray;
}

- (NSArray *)weatherTitleArray
{
    if (!_weatherTitleArray) {
        _weatherTitleArray = @[lang(@"current weather type:"),lang(@"current temperature:"),lang(@"current top temperature:"),
                               lang(@"current minimum temperature:"),lang(@"current humidity:"),lang(@"current uv intensity:"),lang(@"current air index:")];
    }
    return _weatherTitleArray;
}

- (NSArray *)hrModeArray
{
    if (!_hrModeArray) {
        _hrModeArray = @[lang(@"off"),lang(@"manual mode"),
                         lang(@"auto mode"),
                         lang(@"continuously monitor"),
                         lang(@"default mode"),lang(@"heart rate interval mode")];
    }
    return _hrModeArray;
}

- (NSArray *)v3HrModeArray
{
    if (!_v3HrModeArray) {
        _v3HrModeArray = @[lang(@"off"),lang(@"manual mode"),lang(@"auto mode"),lang(@"continuously monitor")];
    }
    return _v3HrModeArray;
}

- (NSArray *)distanceUnitArray
{
    if (!_distanceUnitArray) {
        _distanceUnitArray = @[lang(@"invalid"),lang(@"km"),lang(@"mi")];
    }
    return _distanceUnitArray;
}

- (NSArray *)weightUnitArray
{
    if (!_weightUnitArray) {
        _weightUnitArray = @[lang(@"invalid"),lang(@"kg"),lang(@"lb"),lang(@"st")];
    }
    return _weightUnitArray;
}

- (NSArray *)tempUnitArray
{
    if (!_tempUnitArray) {
        _tempUnitArray = @[lang(@"invalid"),lang(@"°C"),lang(@"°F")];
    }
    return _tempUnitArray;
}

- (NSArray *)languageUnitArray
{
    if (!_languageUnitArray) {
        _languageUnitArray = @[lang(@"invalid"),lang(@"chinese"),lang(@"english"),lang(@"french"),
                               lang(@"german"),lang(@"italian"),lang(@"spanish"),lang(@"japanese"),
                               lang(@"polish"),lang(@"czech"),lang(@"romania"),lang(@"lithuanian"),
                               lang(@"dutch"),lang(@"slovenia"),lang(@"hungarian"),lang(@"russian"),
                               lang(@"ukrainian"),lang(@"slovak"),lang(@"danish"),lang(@"croatia"),
                               lang(@"indonesian"),lang(@"korean"),lang(@"hindi"),lang(@"portuguese"),
                               lang(@"turkey"),lang(@"thai"),lang(@"vietnamese"),lang(@"burmese"),
                               lang(@"filipino"),lang(@"traditional chinese"),lang(@"greek")];
    }
    return _languageUnitArray;
}

- (NSArray *)timeUnitArray
{
    if (!_timeUnitArray) {
        _timeUnitArray = @[lang(@"invalid"),lang(@"24 hours"),lang(@"12 hours")];
    }
    return _timeUnitArray;
}

- (NSArray *)strideGpsArray
{
    if (!_strideGpsArray) {
        _strideGpsArray = @[lang(@"invalid"),lang(@"open"),lang(@"off")];
    }
    return _strideGpsArray;
}

- (NSArray *)gpsInfoTitleArray
{
    if (!_gpsInfoTitleArray) {
        _gpsInfoTitleArray = @[lang(@"startup mode:"),lang(@"operation mode:"),lang(@"positioning cycle:"),lang(@"positioning mode:")];
    }
    return _gpsInfoTitleArray;
}

- (NSArray *)unitTitleArray
{
    if (!_unitTitleArray) {
        _unitTitleArray = @[lang(@"distance unit:"),lang(@"weight unit:"),lang(@"temperature unit:"),lang(@"current language:"),
                            lang(@"walking step length:"),lang(@"running step length:"),lang(@"gps stride calibration:"),
                            lang(@"time format:"),lang(@"week start:")];
    }
    return _unitTitleArray;
}

- (NSArray *)sportShortcutTitleArray
{
    if (!_sportShortcutTitleArray) {
        _sportShortcutTitleArray = @[@[lang(@"walk"),lang(@"run"),lang(@"ride"),lang(@"hike"),lang(@"swim"),lang(@"mountain climbing"),lang(@"badminton"),lang(@"other")],
                                     @[lang(@"fitness"),lang(@"spinning"),lang(@"elliptical machine"),lang(@"treadmill"),lang(@"sit-ups"),lang(@"push-ups"),lang(@"dumbbells"),lang(@"weight lifting")],
                                     @[lang(@"calisthenics"),lang(@"yoga"),lang(@"rope skipping"),lang(@"table tennis"),lang(@"basketball"),lang(@"football"),lang(@"volleyball"),lang(@"tennis")],
                                     @[lang(@"golf"),lang(@"baseball"),lang(@"skiing"),lang(@"roller skating"),lang(@"dancing")]];
    }
    return _sportShortcutTitleArray;
}

- (NSArray *)sportSortTitleArray
{
    if (!_sportSortTitleArray) {
        _sportSortTitleArray = @[lang(@"walk"),lang(@"run"),lang(@"ride"),lang(@"hike"),lang(@"swim"),lang(@"mountain climbing"),lang(@"badminton"),lang(@"other"),
                                 lang(@"fitness"),lang(@"spinning"),lang(@"elliptical machine"),lang(@"treadmill"),lang(@"sit-ups"),lang(@"push-ups"),lang(@"dumbbells"),lang(@"weight lifting"),
                                 lang(@"calisthenics"),lang(@"yoga"),lang(@"rope skipping"),lang(@"table tennis"),lang(@"basketball"),lang(@"football"),lang(@"volleyball"),lang(@"tennis"),
                                 lang(@"golf"),lang(@"baseball"),lang(@"skiing"),lang(@"roller skating"),lang(@"dancing"),lang(@"outdoor running"),lang(@"indoor running"),lang(@"outdoor cycling"),
                                 lang(@"indoor cycling"),lang(@"outdoor walking"),lang(@"indoor walking"),lang(@"pool swimming"),lang(@"open water swimming"),lang(@"elliptical machine"),
                                 lang(@"rowing machine"),lang(@"high-intensity interval training")];
    }
    return _sportSortTitleArray;
}

- (NSArray *)bootModeArray
{
    if (!_bootModeArray) {
        _bootModeArray = @[lang(@"invalid"),lang(@"cold start"),lang(@"hot start")];
    }
    return _bootModeArray;
}

- (NSArray *)operatingModeArray
{
    if (!_operatingModeArray) {
        _operatingModeArray = @[lang(@"invalid"),lang(@"normal"),lang(@"low power"),lang(@"invalid"),lang(@"balance"),lang(@"1pps")];
    }
    return _operatingModeArray;
}

- (NSArray *)satelliteModeArray
{
    if (!_satelliteModeArray) {
        _satelliteModeArray = @[lang(@"invalid"),lang(@"GPS"),lang(@"GLONASS"),lang(@"GPS+GLONASS")];
    }
    return _satelliteModeArray;
}

- (NSArray *)hotStartTitleArray
{
    if (!_hotStartTitleArray) {
        _hotStartTitleArray = @[lang(@"crystal oscillation offset:"),lang(@"longitude:"),lang(@"latitude:"),lang(@"height:")];
    }
    return _hotStartTitleArray;
}

- (NSArray *)hotStartplaceholderArray
{
    if (!_hotStartplaceholderArray) {
        NSString * str1 = [NSString stringWithFormat:@"%@10^1",lang(@"accurate to")];
        NSString * str2 = [NSString stringWithFormat:@"%@10^6",lang(@"accurate to")];
        NSString * str3 = [NSString stringWithFormat:@"%@10^6",lang(@"accurate to")];
        NSString * str4 = [NSString stringWithFormat:@"%@10^1",lang(@"accurate to")];
        _hotStartplaceholderArray = @[str1,str2,str3,str4];
    }
    return _hotStartplaceholderArray;
}

- (NSArray *)targetTypes
{
    if (!_targetTypes) {
        _targetTypes = @[lang(@"none"),lang(@"times"),lang(@"meter"),lang(@"minute"),lang(@"calories")];
    }
    return _targetTypes;
}

- (NSArray *)sportTypes
{
//    193:Outdoor Fun（户外玩耍）, 194:Other Activity（其他运动）48:户外跑步 52:户外走路 50:户外骑行
    if (!_sportTypes) {
        _sportTypes =  @[lang(@"walk"),lang(@"run"),lang(@"ride"),lang(@"hike"),lang(@"swim"),lang(@"mountain climbing"),lang(@"badminton"),lang(@"other"),
                         lang(@"fitness"),lang(@"spinning"),lang(@"elliptical machine"),lang(@"treadmill"),lang(@"sit-ups"),lang(@"push-ups"),lang(@"dumbbells"),lang(@"weight lifting"),
                         lang(@"calisthenics"),lang(@"yoga"),lang(@"rope skipping"),lang(@"table tennis"),lang(@"basketball"),lang(@"football"),lang(@"volleyball"),lang(@"tennis"),
                         lang(@"golf"),lang(@"baseball"),lang(@"skiing"),lang(@"roller skating"),lang(@"dancing"),
                         lang(@"indoor rowing"),lang(@"pilates"),lang(@"cross training"),lang(@"aerobics"),lang(@"zumba"),
                         lang(@"square dance"),lang(@"plank"),lang(@"gym"),lang(@"outdoor running"),lang(@"outdoor walking"),lang(@"outdoor cycling"),lang(@"outdoor play"),lang(@"other activity")];
    }
    return _sportTypes;
}

- (NSArray *)firmwareTypes
{
    if (!_firmwareTypes) {
        _firmwareTypes = @[@"soft_device",@"boot_loader",@"soft_device_boot_loader",@"application"];
    }
    return _firmwareTypes;
}

- (NSArray *)fileTranTypes
{
    if (!_fileTranTypes) {
        _fileTranTypes = @[@"agps",@"file",@"word",@"photo"];
    }
    return _fileTranTypes;
}

- (NSArray *)compressionTypes
{
    if (!_compressionTypes) {
        _compressionTypes = @[@"no use",@"zlib",@"fastlz"];
    }
    return _compressionTypes;
}


- (NSArray *)menuListTypes
{
    if (!_menuListTypes) {
        _menuListTypes = @[lang(@"steps"),lang(@"heart rate"),lang(@"sleep"),lang(@"picture"),lang(@"alarm clock"),
                           lang(@"music"),lang(@"stopwatch"),lang(@"timer"),lang(@"exercise mode"),lang(@"weather"),
        lang(@"breathing exercise"),lang(@"find mobile phone"),lang(@"pressure"),lang(@"data tricycle"),lang(@"time interface")];
    }
    return _menuListTypes;
}

- (NSArray *)switchTypes
{
    if (!_switchTypes) {
        _switchTypes = @[lang(@"off"),lang(@"on")];
    }
    return _switchTypes;
}

- (NSArray *)musicTypes
{
    if (!_musicTypes) {
        _musicTypes = @[lang(@"previous"),lang(@"next"),lang(@"increase volume"),lang(@"decrease volume"),lang(@"play music"),lang(@"pause music")];
    }
    return _musicTypes;
}

- (NSArray *)wallpaperLoc
{
    if (!_wallpaperLoc) {
         _wallpaperLoc = @[     lang(@"invalid"),lang(@"dial(upperleft)"),lang(@"dial(uppermiddle)"),lang(@"dial(upperright)"),lang(@"dial(middleleft)"),lang(@"dial(middle)"),lang(@"dial(middleright)"),lang(@"dial(bottomleft)"),lang(@"dial(bottommiddle)"),lang(@"dial(bottomright)")];
   
    }
    return _wallpaperLoc;
}

- (NSArray *)hideType
{
    if (!_hideType) {
        _hideType = @[lang(@"show all"),lang(@"hide child controls")];
    }
    return _hideType;
}

- (NSArray *)widgetType
{
    if (!_widgetType) {
         _widgetType = @[lang(@"week/date"),lang(@"number of steps"),lang(@"distance"),
                         lang(@"calorie"),lang(@"heart rate"),lang(@"battery")];
    }
    return _widgetType;
}

- (NSArray *)widgetColor
{
    if (!_widgetColor) {
         _widgetColor = @[@"#FFFFFF",@"#000000",@"#FC1E58",@"#FF9501",@"#0091FF",@"#44D7B6"];
    }
    return _widgetColor;
}

//通知类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
- (NSArray *)notifyFlagArray
{
    if (!_widgetColor) {
         _widgetColor = @[lang(@"notify flag unknow"),lang(@"allow notify flag"),lang(@"silence notify flag"),lang(@"close notify flag")];
    }
    return _widgetColor;
}


@end
