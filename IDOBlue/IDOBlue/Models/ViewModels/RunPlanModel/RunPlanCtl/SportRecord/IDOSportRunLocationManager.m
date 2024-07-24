//
//  IDOSportRunViewModel.m
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/25.
//

#import "IDOSportRunLocationManager.h"


@interface IDOSportRunLocationManager ()


@property (nonatomic,strong) NSMutableArray *railModelArray;        //所有点数组

@property (nonatomic,assign) CGFloat totalDistance;     //总运动距离 m

@property (nonatomic,assign) CGFloat signal_flag;     //gps信号

@property (nonatomic,assign) NSInteger startRunTimestamp;

@end

@implementation IDOSportRunLocationManager


static IDOSportRunLocationManager *_mgr = nil;

+ (IDOSportRunLocationManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[IDOSportRunLocationManager alloc] init];
    });
    return _mgr;
}

- (instancetype)init{
    if (self = [super init]) {
       
    }
    return self;
}

+ (instancetype)alloc{
    if (_mgr) {
        NSException *exception = [NSException exceptionWithName:@"重复创建IDOSportRunLocationManager单例对象异常" reason:@"请使用[IDOSportRunLocationManager shareInstance]的单例方法." userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}

-(NSMutableArray *)railModelArray{
    if (!_railModelArray) {
        _railModelArray = [NSMutableArray array];
    }
    return _railModelArray;
}

- (NSArray<IDOSRailModel *> *)railModels{
    return [self.railModelArray copy];
}

- (CGFloat)totalDistances{
    return self.totalDistance;
}

- (NSInteger)signalFlag{
    return self.signal_flag;
}

- (void)startUpdatingLocationWithTimestamp:(NSInteger)startRunTimestamp{
    
   
}

-(void)updateGPSView:(double)horizontalAccuracy{
    if (horizontalAccuracy <= 0 || horizontalAccuracy > 65) {
        self.signal_flag = 0;
    }else if (horizontalAccuracy > 0 && horizontalAccuracy <= 15){
        self.signal_flag = 1;
    }else if (horizontalAccuracy > 15 && horizontalAccuracy <= 25){
        self.signal_flag = 1;
    }else if (horizontalAccuracy > 25 && horizontalAccuracy <= 35){
        self.signal_flag = 0;
    }else if (horizontalAccuracy > 35 && horizontalAccuracy <= 65){
        self.signal_flag = 0;
    }
}



- (void)stopLocation{
}

- (void)clearAllData{
    [self.railModelArray removeAllObjects];
    self.totalDistance = 0;
    self.signal_flag = 0;
}

@end
