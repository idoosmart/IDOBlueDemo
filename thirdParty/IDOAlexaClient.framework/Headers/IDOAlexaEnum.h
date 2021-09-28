//
//  IDOAlexaEnum.h
//  IDOAlexaClient
//
//  Created by 鲁鲁骁 on 2021/3/8.
//

#ifndef IDOAlexaEnum_h
#define IDOAlexaEnum_h

/**< 多国语言 */
typedef enum : NSUInteger {
    AlexaCountryGermanGermany = 0,          /**< 德语 */
    AlexaCountryEnglishAustralia,           /**< 英语 澳大利亚 */
    AlexaCountryEnglishCanada,              /**< 英语 加拿大 */
    AlexaCountryEnglishUnitedKingdom,       /**< 英语 英国 */
    AlexaCountryEnglishIndia,               /**< 英语 印度 */
    AlexaCountryEnglishUnitedStates,        /**< 英语 美国 */
    AlexaCountrySpanishEspana,              /**< 西班牙语 西班牙 */
    AlexaCountrySpanishMexico,              /**< 西班牙语 墨西哥 */
    AlexaCountrySpanishUnitedStates,        /**< 西班牙语 美国 */
    AlexaCountryFrenchCanada,               /**< 法语 加拿大 */
    AlexaCountryFrenchFrench,               /**< 法语 法国 */
    AlexaCountryHindiIndia,                 /**< 印地语 印度 */
    AlexaCountryItalianItaly,               /**< 意大利语 */
    AlexaCountryJapaneseJapan,              /**< 日语 */
    AlexaCountryPortuguesePortugal,         /**< 葡萄牙语 */
} AlexaCountryType;

typedef enum : NSUInteger {
    AlexaGetValueTypePedometer = 0,         /**< 当天步数 */
    AlexaGetValueTypeCalorie,               /**< 当天卡路里 */
    AlexaGetValueTypeHeartRate,             /**< 当天最近一次测量的心率 */
    AlexaGetValueTypeSpO2,                  /**< 当天血氧 */
    AlexaGetValueTypeKilometer,             /**< 当天距离（米） */
    AlexaGetValueTypeSwimmingDistance,      /**< 当天室内游泳距离（米） */
    AlexaGetValueTypeSleepScore,            /**< 当天睡眠得分 */
    AlexaGetValueTypeRunningCount,          /**< 当天跑步次数 */
    AlexaGetValueTypeSwimmingCount,         /**< 当天游泳次数 */
    AlexaGetValueTypeWorkoutCount,          /**< 当天运动次数 */
    AlexaGetValueTypeWeekWorkoutCount,      /**< 当周运动次数 */
} AlexaGetValueType;

/**< 获取心率 */
typedef enum : NSUInteger{
    AlexaHRDataTypeAVG = 1,                 /**< 平均 */
    AlexaHRDataTypeMAX,                     /**< 最大 */
    AlexaHRDataTypeMIN,                     /**< 最小 */
} AlexaHRDataType;

typedef enum : NSUInteger {
    AlexaHRTimeTypeToday = 1,                   /**< 今天 */
    AlexaHRTimeTypeWeek,                    /**< 上周 */
    AlexaHRTimeTypeMouth,                   /**< 上个月 */
    AlexaHRTimeTypeYear,                    /**< 上一年 */
} AlexaHRTimeType;

/**< 功能控制 */
typedef enum : NSUInteger {
    AlexaFoundationTypeCloseFoundPhone = 1,     /**< 关闭找手机功能 */
} AlexaFoundationType;

#endif /* IDOAlexaEnum_h */
