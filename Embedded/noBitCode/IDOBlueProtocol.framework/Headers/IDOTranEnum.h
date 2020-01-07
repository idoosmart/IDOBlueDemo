//
//  IDOTranEnum.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/7.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOTranEnum_h
#define IDOTranEnum_h

/**
 压缩类型 | compression type
 */
typedef NS_ENUM(NSInteger, IDO_DATA_TRAN_COMPRESSION_TYPE) {
    /**
     不适用压缩 | no use
     */
    IDO_DATA_TRAN_COMPRESSION_NO_USE_TYPE = 0,
    /**
     zlib压缩 | zlib
     */
    IDO_DATA_TRAN_COMPRESSION_ZLIB_TYPE = 1,
    /**
     fastlz压缩 | fastlz
     */
    IDO_DATA_TRAN_COMPRESSION_FASTLZ_TYPE = 2,
    
};

/**
 文件传输类型 | file transfer type
 */
typedef NS_ENUM(NSInteger, IDO_DATA_FILE_TRAN_TYPE) {
    /**
     AGPS 文件 | AGPS file type
     */
    IDO_DATA_FILE_TRAN_AGPS_TYPE = 1,
    /**
     表盘 文件 | dial file type
     */
    IDO_DATA_FILE_TRAN_DIAL_TYPE = 2,
    /**
      字库 文件 | word file type
    */
    IDO_DATA_FILE_TRAN_WORD_TYPE = 3,
    /**
     图片文件 | photo file type
     */
    IDO_DATA_FILE_TRAN_PHOTO_TYPE = 4
};

/**
 文件传输状态 | file transfer state type
 */
typedef NS_ENUM(NSInteger, IDO_DATA_FILE_TRAN_STATE_TYPE) {
    /**
     文件传输初始值 | transmission init
     */
    IDO_DATA_FILE_TRAN_INIT_TYPE = 0,
    /**
     文件开始传输 | start transmission
     */
    IDO_DATA_FILE_TRAN_START_TYPE = 1,
    /**
     文件传输中 | transmissioning
     */
    IDO_DATA_FILE_TRAN_ING_TYPE = 2,
    /**
     文件传输成功 | transmission success
     */
    IDO_DATA_FILE_TRAN_SUCCESS_TYPE = 3,
    /**
     文件传输失败 | transmission failed
     */
    IDO_DATA_FILE_TRAN_FAILED_TYPE = 4,
    /**
     文件开始写入 | start write
     */
    IDO_DATA_FILE_WRITE_TYPE = 5,
    /**
     文件写入成功 | write success
     */
    IDO_DATA_FILE_WRITE_SUCCESS_TYPE = 6,
    /**
     文件写入失败 | write failed
     */
    IDO_DATA_FILE_WRITE_FAILED_TYPE = 7,
    
};


#endif /* IDOTranEnum_h */
