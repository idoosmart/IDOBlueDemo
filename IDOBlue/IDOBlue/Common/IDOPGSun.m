//
//  IDOPGSun.m
//  
//
//  Created by xiongjie on 2021/10/29.
//

#import "IDOPGSun.h"



#define Inv360  1.0/360.0
#define Degrad  M_PI/180.0
#define Radge   180.0/M_PI

@interface IDOPGSun()

@property (nonatomic,assign) double start;
@property (nonatomic,assign) double sRA;
@property (nonatomic,assign) double sdec;
@property (nonatomic,assign) double sr;
@property (nonatomic,assign) double lon;
@property (nonatomic,assign) double end;

@end

@implementation IDOPGSun
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *) sun:(double) longitude withLat:(double) latitude
{
    return [self getSunTimeAtDate:[NSDate date] withLon:longitude withLat:latitude];
}

- (NSDictionary *) getSunTimeAtDate:(NSDate *) d withLon:(double) longitude withLat:(double) latitude
{
    int xcts = [self days:d];
    NSDictionary *dic = [self getSunTime:xcts withLon:longitude withLat:latitude];
    return dic;
}

- (NSDictionary *) getSunTime:(int) day withLon:(double) longitude withLat:(double) latitude
{
    [self sunRiset:day withLong:longitude withLat:latitude withAltit:-35.0 / 60.0 withLimb:1 withTrise:self.start withTset:self.end];
    NSString * sunrise = [self toLocalTime:self.start];
    NSString * sunset = [self toLocalTime:self.end];
    NSDictionary * dic = @{@"sunrise":sunrise,@"sunset":sunset};
    return dic;
}

- (NSString *) toLocalTime:(double) utTime
{
    int hour = floor(utTime);
    double temp = utTime - hour;
    hour += 8;
    temp = temp*60;
    int minute = floor(temp);
    if (hour > 24) {
        hour -= 24;
    }
    return [NSString stringWithFormat:@"%02d:%02d",hour,minute];
}

- (int) days:(NSDate *) d
{
    //距离2000-01-01的天数
    NSString *dateStr = @"2000-01-01";
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeInterval time = [d timeIntervalSinceDate:date];
    int days = time/(3600*24);
    return days;
}


- (int) sunRiset:(int) day withLong:(double) longitude withLat:(double) lat withAltit:(double) altit withLimb:(int) upper_limb withTrise:(double) trise withTset:(double) tset
{
    double d = 0.0;/* Days since 2000 Jan 0.0 (negative before) */
    //以历元2000.0起算的日数。
    double sradius = 0.0;   /* Sun's apparent radius */
    //太阳视半径，约16分（受日地距离、大气折射等诸多影响）
    
    double  t = 0.0;         /* Diurnal arc */
    //周日弧，太阳一天在天上走过的弧长。
    
    double  tsouth = 0.0;    /* Time when Sun is at south */
    double sidtime = 0.0;    /* Local sidereal time */
    //当地恒星时，即地球的真实自转周期。比平均太阳日（日常时间）长3分56秒。
    
    int rc = 0; /* Return cde from function - usually 0 */
    /* Compute d of 12h local mean solar time */
    d = day /* Days_since_2000_Jan_0(date)*/ + 0.5 - longitude / 360.0;
    //计算观测地当日中午时刻对应2000.0起算的日数。
    /* Compute local sideral time of this moment */
    sidtime = [self revolution:[self GMST0 :d] + 180.0 + longitude];
    //计算同时刻的当地恒星时（以角度为单位）。以格林尼治为基准，用经度差校正。
    
    /* Compute Sun's RA + Decl at this moment */
    [self Sun_RA_dec:d withra:_sRA withDec:_sdec withR:_sr];
    
    //    Sun_RA_dec(d, sRA,sdec,sr);
    //计算同时刻太阳赤经赤纬。
    
    /* Compute time when Sun is at south - in hours UT */
    tsouth = 12.0 - [self rev180:(sidtime - self.sRA)] / 15.0;
    //    tsouth = 12.0 - Rev180(sidtime - sRA) / 15.0;
    //计算太阳日的正午时刻，以世界时（格林尼治平太阳时）的小时计。
    
    /* Compute the Sun's apparent radius, degrees */
    sradius = 0.2666 / self.sr;
    //太阳视半径。0.2666是一天文单位处的太阳视半径（角度）。
    
    /* Do correction to upper limb, if necessary */
    if (upper_limb != 0){
        altit -= sradius;
        //如果要用上边缘，就要扣除一个视半径。
    }
    /* Compute the diurnal arc that the Sun traverses to reach */
    //计算周日弧。直接利用球面三角公式。如果碰到极昼极夜问题，同前处理。
    /* the specified altitide altit: */
    
    double cost = 0;
    cost = ([self sind:altit] - [self sind:lat]*[self sind:self.sdec])/( [self cosd:lat] * [self cosd:self.sdec]);
    //    cost = (Sind(altit) - Sind(lat) * Sind(sdec)) /
    //    (Cosd(lat) * Cosd(sdec));
    
    if (cost >= 1.0)
    {
        rc = -1;
        t = 0.0;
    }
    else
    {
        if (cost <= -1.0)
        {
            rc = +1;
            t = 12.0;      /* Sun always above altit */
        }
        else{
            //            t = Acosd(cost) / 15.0;   /* The diurnal arc, hours */
            t = [self acosd:cost] / 15.0;
        }
    }
    
    /* Store rise and set times - in hours UT */
    self.start = tsouth - t;
    self.end = tsouth + t;
    return rc;
}



- (void) Sun_RA_dec:(double) d withra:(double) RA withDec:(double) dec withR:(double) r
{
    double obl_ecl = 0;
    double x = 0;
    double y = 0;
    double z = 0;
    [self sunpos:d withLon:self.lon withR:r];
    //计算太阳的黄道坐标。
    x = self.sr * [self cosd:self.lon];
    y = _sr * [self sind:_lon];
    //计算太阳的直角坐标。
    obl_ecl = 23.4393 - 3.563E-7 * d;
    //黄赤交角，同前。
    z = y * [self sind:obl_ecl];
    y = y * [self cosd:obl_ecl];
    //把太阳的黄道坐标转换成赤道坐标（暂改用直角坐标）。
    _sRA = [self atan2d:y withX:x];
    _sdec = [self atan2d:z withX:sqrt(x * x + y * y)];
    //最后转成赤道坐标。显然太阳的位置是由黄道坐标方便地直接确定的，但必须转换到赤
    //道坐标里才能结合地球的自转确定我们需要的白昼长度。
}


- (void) sunpos:(double) d withLon:(double) lon withR:(double) r
{
    
    double M  = 0;
    double w  = 0;
    double e  = 0;
    double E  = 0;
    double x  = 0;
    double y  = 0;
    double v  = 0; //真近点角，太阳在任意时刻的真实近点角。
    
    M = [self revolution:(356.0470 + 0.9856002585 * d)];
    //自变量的组成：2000.0时刻太阳黄经为356.0470度,此后每天约推进一度（360度/365天
    w = 282.9404 + 4.70935E-5 * d; //近日点的平均黄经。
    
    e = 0.016709 - 1.151E-9 * d; //地球公转椭圆轨道离心率的时间演化。以上公式和黄赤交角公式一样，不必深究。
    
    E = M + e * Radge * [self sind:M] * (1.0 + e * [self cosd:M]);
    x = [self cosd:E] - e;
    y = sqrt(1.0 - e * e) *  [self sind:E];
    self.sr = sqrt(x * x + y * y);
    v = [self atan2d:y withX:x];
    
    lon = v + w;
    self.lon = lon;
    if (lon >= 360.0) {
        lon -= 360.0;
        self.lon = lon;
    }

}



- (double) revolution:(double) x
{
    return x - 360.0 * floor(x * Inv360);
}

- (double) rev180:(double) x
{
    return x - 360.0 * floor(x * Inv360 + 0.5);
}

- (double) GMST0:(double) d
{
    
    double sidtim0 = [self revolution:((180.0 + 356.0470 + 282.9404) + (0.9856002585 + 4.70935E-5) * d)];
    return sidtim0;
}


- (double) sind:(double) x
{
    return sin(x * Degrad);
}

- (double) cosd:(double) x
{
    return cos(x * Degrad);
}

- (double) acosd:(double) x
{
    return Radge * acos(x);
}

- (double)atan2d:(double) y withX:(double) x
{
    return Radge*atan2(y, x);
}

//func atan2d(_ y , x ) -> Double {
//    return Double(Radge * atan2(y, x))
//}

@end
