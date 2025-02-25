//
//  SSZIP.swift
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

import Foundation
import Zip
 
@objcMembers class ZipHelper: NSObject {
    
    @objc public class func unzipFile(_ zipFilePath: URL, destination: URL, progress: ((_ progress: Double) -> ())? = nil, fileOutputHandler: ((_ unzippedFile: URL) -> Void)? = nil) {
        do {
            try  Zip.unzipFile(zipFilePath, destination: destination, overwrite: true, password: nil,progress: progress,fileOutputHandler: fileOutputHandler)
        } catch {
            print("解压失败: \(error.localizedDescription)")

        }
    }
    

    @objc public class func createZipFile(atPath path: String,
                      withContentsOfDirectory directoryPath: String,
                      keepParentDirectory: Bool,
                      compressionLevel: Int = 9) -> Bool {
        
        // 获取文件管理器
        let fileManager = FileManager.default
        
        // 检查目标目录是否存在
        var isDirectory: ObjCBool = false
        guard fileManager.fileExists(atPath: directoryPath, isDirectory: &isDirectory), isDirectory.boolValue else {
            print("目录不存在或不是文件夹: \(directoryPath)")
            return false
        }
        
        // 获取目录中的所有文件
        let enumerator = fileManager.enumerator(atPath: directoryPath)
        guard let allObjects = enumerator?.allObjects as? [String] else {
            print("无法获取目录内容")
            return false
        }
        
        // 如果需要保留父目录，调整文件路径
        var filesToZip: [URL] = []
        for fileName in allObjects {
            let fullFilePath = URL(fileURLWithPath: directoryPath).appendingPathComponent(fileName)
            if keepParentDirectory {
                let parentDirectoryName = URL(fileURLWithPath: directoryPath).lastPathComponent
                let adjustedFileName = "\(parentDirectoryName)/\(fileName)"
                filesToZip.append(fullFilePath)
            } else {
                filesToZip.append(fullFilePath)
            }
        }
        
        // 如果没有文件且需要保留父目录，添加空目录
        if keepParentDirectory && allObjects.isEmpty {
            let parentDirectoryName = URL(fileURLWithPath: directoryPath).lastPathComponent
            let emptyDirectoryURL = URL(fileURLWithPath: directoryPath).appendingPathComponent("")
            filesToZip.append(emptyDirectoryURL)
        }
        
        // 压缩文件
        do {
            try Zip.zipFiles(paths: filesToZip,
                             zipFilePath: URL(fileURLWithPath: path),
                             password: nil,
                             compression: .BestCompression,
                             progress: { progress in
                                
                             })
            print("压缩成功")
            return true
        } catch {
            print("压缩失败: \(error)")
            return false
        }
    }
}
