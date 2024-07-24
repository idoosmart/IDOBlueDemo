//
//  CloudDailViewController.swift
//  IDOBlue
//
//  Created by lux on 2024/4/22.
//  Copyright © 2024 hedongyang. All rights reserved.
//

import UIKit
import SwiftUI
import PhotosUI
import CropViewController
import SwiftyJSON
import CoreImage.CIFilterBuiltins
import IDOBlueUpdate
import MobileCoreServices
import UniformTypeIdentifiers
import Zip


func getScreenWidth() -> CGFloat {
    if let w = IDOWatchScreenInfoModel.current()?.width {
        return CGFloat(w)
    }
    return 240.0;
}
func getScreenHeight() -> CGFloat {
    if let h = IDOWatchScreenInfoModel.current()?.height {
        return CGFloat(h)
    }
    return 289.0;
}

func getDefaultBgImages() -> [UIImage] {
    var imagePath = Bundle.main.bundleURL.appendingPathComponent("Files/custom1/images/bg.png")
    if getScreenWidth() ==  getScreenHeight() {
        imagePath = Bundle.main.bundleURL.appendingPathComponent("Files/TITAN_90207/images/bg.png")
    }
    do {
        let data = try Data(contentsOf: imagePath)
        let image = UIImage(data: data)
        return [image!]
    }catch {
        print("图片不存在: \(error.localizedDescription)")
        return []
    }
}

func getPreViewImage() -> UIImage {
    var imagePath = Bundle.main.bundleURL.appendingPathComponent("Files/custom1/images/preview.png")
    if getScreenWidth() ==  getScreenHeight() {
        imagePath = Bundle.main.bundleURL.appendingPathComponent("Files/TITAN_90207/images/preview.png")
    }
    do {
        let data = try Data(contentsOf: imagePath)
        let image = UIImage(data: data)
        return image!
    }catch {
        print("图片不存在: \(error.localizedDescription)")
        return UIImage(named: "preview.png")!
    }
}

// MARK: ViewController
class SiCeDailViewController: UIViewController {
    override func viewDidLoad() {
        // 导航栏
        super.viewDidLoad()
        self.navigationItem.title = lang("SiChe photo cloud dial")
        
        // 显示 toolbar
        self.navigationController?.setToolbarHidden(false, animated: false)

        // 创建 SwiftUI 视图
        let swiftUIView = SiCeDialDailView(viewModel: SiCeDialDailViewModel())
        
        // 创建承载 SwiftUI 视图的 UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // 添加为子视图控制器
        self.addChild(hostingController)
        
        // 添加视图并设置约束
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
}
// MARK: - Model
enum LocationType: Int, Codable, CaseIterable {
    case up_left = 1 // 上左
    case up_center = 2 //上中
    case up_right = 3 // 上右
    case center_left = 4 // 中左
    case center_center = 5 // 中中
    case center_right = 6 // 中右
    case dowm_left = 7 // 下左
    case dowm_center = 8 // 下中
    case down_right = 9 // 下右
}

struct Location: Codable {
    let type: LocationType
    let time: [Int]
    let day: [Int]
    let week: [Int]
}

// 预设的几个时间位置
var locations: [Location] = [
    Location(type: .up_left, time: [44,64,180,74], day: [80,30,32,26], week: [44,30,62,26]),
    Location(type: .up_right, time: [210,64,180,74], day: [347,30,32,26], week: [265,30,62,26]),
    Location(type: .dowm_left, time: [44,390,180,74], day: [80,356,32,26], week: [44,356,62,26]),
    Location(type: .down_right, time: [210,390,180,74], day: [347,356,32,26], week: [265,356,62,26]),
]

// MARK: - ViewModel

class SiCeDialDailViewModel: ObservableObject {
    
    @Published var progress: Float = 0
    @Published var preViewImage: UIImage = getPreViewImage()
    @Published var pWidth = getPreViewImage().size.width;
    @Published var pHeight = getPreViewImage().size.height;
    @Published var bgWidth = getScreenWidth();
    @Published var bgHeight = getScreenHeight();
    
    var progressHUD: MBProgressHUD?
    
    let fileManager = FileManager.default
    
    let siceDailPath = "SiCeDail/" //思澈主目录
    
    let custom1Path = "SiCeDail/custom1/" // custom1文件夹
    
    let imagesPath = "SiCeDail/custom1/images/" // 图片文件夹
    
    let custom1custom1Path = "SiCeDail/custom1/custom1/" // custom1/custom1文件夹

    init() {
        let documentDirctionary = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let siCeDail = documentDirctionary.appendingPathComponent(siceDailPath)
        let custom1Path1 = documentDirctionary.appendingPathComponent(custom1Path)
        let custom1custom1Path = documentDirctionary.appendingPathComponent(custom1custom1Path)
        var custom1Path2 = Bundle.main.bundleURL.appendingPathComponent("Files/custom1/")
        var jsonPath = Bundle.main.bundleURL.appendingPathComponent("Files/custom1/app.json")
        if (getScreenWidth() == getScreenHeight()) {
            custom1Path2 = Bundle.main.bundleURL.appendingPathComponent("Files/TITAN_90207/")
            jsonPath = Bundle.main.bundleURL.appendingPathComponent("Files/TITAN_90207/app.json")
        }
        do {
            //删除目录文件
            
            if fileManager.fileExists(atPath: siCeDail.path) {
                try fileManager.removeItem(atPath: siCeDail.path)
            }
            
            //创建目录
            try fileManager.createDirectory(at: siCeDail, withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectory(at: custom1Path1, withIntermediateDirectories: true, attributes: nil)
            if fileManager.fileExists(atPath: custom1custom1Path.path) {
                try fileManager.removeItem(at: custom1custom1Path)
            }
            
            if !isDirectoryContainsZIPFiles(directoryPath1: custom1Path2, directoryPath2: custom1custom1Path) {
                try fileManager.copyItem(at: custom1Path2, to: custom1custom1Path)
            }
        
            let data = try Data(contentsOf: jsonPath)
            if data != nil {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let locationItems = jsonObject?["locations"] as? [[String: Any]]
                locations.removeAll()
                locationItems?.forEach({ item in
                    let type = item["type"] as! Int
                    let time = item["time"] as! [Int]
                    let day = item["day"] as! [Int]
                    let week = item["week"] as! [Int]
                    let loc = Location(type: LocationType(rawValue: type)!, time: time, day: day, week: week)
                    locations.append(loc)
                });
            }
        } catch {
            print("创建目录出错: \(error.localizedDescription)")
        }
    }
    
    //判断是否有解压文件
    func isDirectoryContainsZIPFiles(directoryPath1: URL, directoryPath2: URL)-> Bool {
        let fileManager = FileManager.default
            do {
                let directoryContents = try fileManager.contentsOfDirectory(at: directoryPath1, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                for fileName in directoryContents {
                    print("file name == %@",fileName)
                    let filePath = directoryPath1.appendingPathComponent(fileName.lastPathComponent)
                    print("file path == %@",fileName)
                    let fileExtension = filePath.pathExtension
                    if fileExtension == "zip" {
                        if unzipFile(atPath: filePath, toDestination: directoryPath2) {
                            
                        }
                        return true
                    }
                }
            } catch {
                print("无法读取目录内容: \(error.localizedDescription)")
            }
        return false
    }
    
    //解压文件
    func unzipFile(atPath filePath: URL, toDestination destinationPath: URL)-> Bool {
        do {
            try Zip.unzipFile(filePath, destination: destinationPath, overwrite: true, password: nil)
            print("解压成功")
            return true
        } catch {
            print("解压失败: \(error.localizedDescription)")
            return false
        }
    }
    
    // 生成表盘并传输
    func makeDailandTransfer(_ preUIImage: UIImage, _ bcUIImage: UIImage, _ position: Int, _ hexColorInt: Int) async{
        
        makePreUIImageAndBcUIImage(preUIImage, bcUIImage)
        
        let loc = makePosition(position)
        let color = makeRGB(from: hexColorInt)
        let timeLoc = (x:loc.time[0],y:loc.time[1])
        let weekLoc = (x:loc.week[0],y:loc.week[1])
        changeColorAndPositionJSON(positionT: timeLoc, positionW: weekLoc, color: color)
        
        if makeDailFile() {
            // 表盘传输文件地址
            let documentDirctionary = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let custom1custom1Path = documentDirctionary.appendingPathComponent(custom1custom1Path)
            let filePath = custom1custom1Path.appendingPathComponent("custom1.watch")
            transferDailZip(filePath)
        }else {
            print("make dail file failed")
        }
    }
    

    // 根据预设文件判断position
    func makePosition(_ position: Int) -> Location {
        var loc = locations.first!
        locations.forEach { item in
            if item.type.rawValue == position {
               loc = item
            }
        }
        return loc
    }
    
    // 根据hex颜色分析出r, g, b值
    func makeRGB(from hexInt: Int) -> (r: Int, g: Int, b: Int) {
        let r = (hexInt >> 16) & 0xFF
        let g = (hexInt >> 8) & 0xFF
        let b = hexInt & 0xFF
        return (r: r, g: g, b: b)
    }
    
    // 配置文件修改
    func changeColorAndPositionJSON(positionT: (x: Int, y: Int), positionW: (x: Int, y: Int), color: (r: Int, g: Int, b: Int)) {
        
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsDirectory.appendingPathComponent("SiCeDail/custom1/custom1/dial_config.json")
        
        do {
            let data = try Data(contentsOf: filePath)
            do {
                if var map = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // 字段
                    let dail_data = "dial_data"
                    
                    var array = (map["dial_data"] ?? Array<Any>()) as! Array<Any>
                    
                    // 修改第二个对象的颜色和位置
                    if array.count > 2 {
                        var map2 = array[2] as! [String: Any]
                        map2["x"] = positionW.x // 新的x值
                        map2["y"] = positionW.y // 新的y值
                        map2["r"] = color.r // 新的r值
                        map2["g"] = color.g // 新的g值
                        map2["b"] = color.b // 新的b值
                        array[2] = map2
                    }
                    
                    // 修改第三个对象的颜色和位置
                    if array.count > 3 {
                        var map3 = array[3] as! [String: Any]
                        map3["x"] = positionT.x // 新的x值
                        map3["y"] = positionT.y // 新的y值
                        map3["r"] = color.r // 新的r值
                        map3["g"] = color.g // 新的g值
                        map3["b"] = color.b // 新的b值
                        array[3] = map3
                    }
                    map["dial_data"] = array
                    if fileManager.fileExists(atPath: filePath.path) {
                        //删除旧的文件
                        try fileManager.removeItem(at: filePath)
                    }
                    // 将修改后的JSON数据写回文件
                    let jsonData = try JSONSerialization.data(withJSONObject: map, options: .prettyPrinted)
                    try jsonData.write(to: filePath)
                }
            } catch {
                print("转换为 Map 对象时出错: \(error.localizedDescription)")
            }
        } catch {
            print("修改颜色位置JSON出错: \(error.localizedDescription)")
        }
    }
    
    // 修改图片大小
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // 根据比例计算目标图像的新尺寸
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // 创建一个图形上下文，绘制调整后的图像
        UIGraphicsBeginImageContextWithOptions(newSize,false,1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    // 制作背景图，预览图，bin，bmp并保存
    func makePreUIImageAndBcUIImage(_ preImage: UIImage, _ bcImage: UIImage)  {
        // 文件路径
        let documentDirctionary = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let images = documentDirctionary.appendingPathComponent(imagesPath)
        let custom1custom1 = documentDirctionary.appendingPathComponent(custom1custom1Path)
        let bcImageSize = CGSize(width: getScreenWidth(), height: getScreenHeight()) // 背景图片尺寸
        let preImageSize = CGSize(width: pWidth, height: pHeight) // 预览图片尺寸
        
        // 重设大小生成PNG
        let preUIImage = resizeImage(image: preImage, targetSize: preImageSize)
        let bcUIImage = resizeImage(image: bcImage, targetSize: bcImageSize)

        // PNG Data
        guard let bcData = bcUIImage?.pngData() else { return }
        guard let preData = preUIImage?.pngData() else { return }
        
        let bgImagePath = images.appendingPathComponent("bg.png")
        let previewImagePath = images.appendingPathComponent("preview.png")
        
        do {
            // 创建images目录
            try fileManager.createDirectory(at: images, withIntermediateDirectories: true, attributes: nil)
            try bcData.write(to: bgImagePath)
            try preData.write(to: previewImagePath)
            
        } catch {
            print("保存预览图和背景图失败", error.localizedDescription)
        }
                
        // 生成bmp
        guard let prebmp = convertImageToBMP(preUIImage!), let bcbmp = convertImageToBMP(bcUIImage!) else {
            return
        }
        
        // bmp存放路径
        
        let prebmpPath = custom1custom1.appendingPathComponent("bg.bmp")
        let bcbmpPath = custom1custom1.appendingPathComponent("preview.bmp")
        
        // 保存bmp
        do {
            try fileManager.createDirectory(at: custom1custom1, withIntermediateDirectories: true)
            try prebmp.write(to: prebmpPath)
            try bcbmp.write(to: bcbmpPath)
        } catch {
            print("保存bmp出错")
        }
        
        // 生成bin文件并保存
        makebin(preData, bcData)
        
    }
    
    // 使用预览图和背景图生成bin文件并保存
    func makebin (_ prePNG: Data, _ bcPNG: Data) {
                
        let boardType: SiFliEBinBoardType = ._55X
        let folderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(custom1custom1Path)
        let previewBinPath = folderPath.appendingPathComponent("preview.bin")
        let backgroundBinPath = folderPath.appendingPathComponent("background.bin")
        
        // 保存预览图.bin
        if let prebinData = IDOUpdateSFManager.siFliEBin(fromPngSequence: [prePNG], eColor: "RGB888", eType: 0, binType: 1, boardType: boardType) {
            do {
                try prebinData.write(to: previewBinPath, options: .atomic)
            } catch {
                print("保存预览图bin失败: \(error.localizedDescription)")
            }
        }
        
        // 保存背景图.bin
        if let prebinData = IDOUpdateSFManager.siFliEBin(fromPngSequence: [bcPNG], eColor: "RGB888", eType: 0, binType: 1, boardType: boardType) {
            do {
                try prebinData.write(to: backgroundBinPath, options: .atomic)
            } catch {
                print("保存背景图bin失败: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    // 生成bmp文件
    func convertImageToBMP(_ bmpImg: UIImage) -> Data? {
        guard let cgImage = bmpImg.cgImage else { return nil }
        let mutableData = NSMutableData()
        let imageData = NSMutableData()
        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        let type = kUTTypeBMP
        guard let destination = CGImageDestinationCreateWithData(mutableData as CFMutableData, type as CFString, 1, nil) else { return nil }
        let options: [String: Any] = [:] // 这里定义了一个空的选项字典
        CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
        CGImageDestinationFinalize(destination)
        return mutableData as Data
    }
    
    // 制作表盘文件
    func makeDailFile()-> Bool {
        let dailFilePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(custom1custom1Path)
        let state: Int = Int(IDOScManager.getMakeSiFliWatchDial(withFilePath: dailFilePath.path))
        if state == 0 {
            print("dailFilePath.path == \(dailFilePath.path)")
            return true
        }
        return false
    }
    
    
    // 安装传输表盘文件
    func transferDailZip (_ url: URL) {
        initTransferManager().transferType = .DIAL_TYPE//IDO_DATA_FILE_TRAN_DIAL_TYPE;
        initTransferManager().compressionType = .NO_USE_TYPE //IDO_DATA_TRAN_COMPRESSION_NO_USE_TYPE;
        initTransferManager().isSetConnectParam = true//YES;
        initTransferManager().fileName = "custom1.watch"
        initTransferManager().filePath = url.path
        initTransferManager().addDetection? { errorCode in
            // TODO: 错误处理
            print("addDetection: \(errorCode)")
        }.addProgress? { progress in
            // TODO: 进度条
            DispatchQueue.main.async {
                if progress == 99 { // 因为固件只能回复到99，所以需要做特殊处理
                    self.progress = 1
                } else {
                    self.progress = Float(progress)/100
                }
            }
            print("Progress: \(progress)")
        }.addTransfer? { errorCode, value in
            print("addTransfer: \(errorCode)")
            self.progress = 0;
        }
        IDOTransferFileManager.startTransfer()
    }
}


// MARK: - SwiftUIView


struct SiCeDialDailView: View {
    
    @ObservedObject var viewModel: SiCeDialDailViewModel
    @State var showImagePicker = false
    @State var bcImage = 0
    @State var selectedColor = 0xffffff
    @State var setPosition: Int = 1
    @State var allBcImages: [UIImage] = getDefaultBgImages()
    
    func aspectRatio() -> CGFloat {
        return getScreenWidth() / getScreenHeight() // 思澈表盘预览图比例
    }
    
    //获取支持的位置集合
    func getSupportPositions() -> [Int] {
        var positions = [Int]()
        locations.forEach { loc in
            positions.append(loc.type.rawValue)
        }
        return positions
    }
    
    
    
    let tableList = ["Background", "Placement", "Text color"]
    
    
    let timePositions = ["top_left_1","top_centre_1", "bottom_centre_1"]
    let colorList: [Int] = [0xffffff, 0x000000, 0xde4371, 0xde4343,
                            0xde7143, 0xdba85c, 0xdbcf60, 0xb7c96b,
                            0xa8e36d, 0x85e36d, 0x6de379, 0x6de39c,
                            0x6de3c0, 0x6de3e3, 0x6dc0e3, 0x6d9ce3,
                            0x6d79e3, 0x856de3, 0xa86de3, 0xcb6de3,
                            0xe36dd7, 0xe36db4]
    @State private var progressHUD: MBProgressHUD?
    
   
    var body: some View {
        
        ScrollView(.vertical) {
            VStack{
                // 预览图片
                Image(uiImage: dailPreviewUIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: viewModel.pWidth, height: viewModel.pHeight)
                    .padding(10)
                
                
                VStack {
                    ForEach(tableList.indices, id: \.self) { index in
                        
                        VStack {
                            HStack {
                                Text(tableList[index])
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                                
                                
                                Spacer()
                            }
                            
                            
                            Divider()
                                .background(Color.gray)
                            
                            // 设置背景
                            
                            if index == 0 {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    
                                    
                                    HStack {
                                        
                                        Button {
                                            showImagePicker = true
                                        } label: {
                                            Text("Add")
                                                .foregroundColor(.blue)
                                                .frame(width: 120, height: 120/aspectRatio())
                                                .background(Color.gray)
                                                .cornerRadius(25)
                                        }
                                        
                                        
                                        ForEach(allBcImages.indices, id: \.self) { index in
                                            Button {
                                                bcImage = index
                                            } label: {
                                                Image(uiImage: allBcImages[index])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 120, height: 120/aspectRatio())
                                            }
                                            .cornerRadius(8)
                                            .padding(.all, 4)
                                            .overlay(
                                                bcImage == index ?
                                                RoundedRectangle(cornerRadius: 8).stroke(.purple, lineWidth: 1) : nil
                                                
                                            )
                                            .padding(2)
                                            
                                            
                                        }
                                        
                                        Spacer()
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            // 位置
                            else if index == 1 {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(getSupportPositions(), id: \.self) { position in
                                            Button(positionTitle(position)) {
                                                setPosition = position
                                            }
                                            .cornerRadius(8)
                                            .padding(20)
                                            .foregroundColor(.white)
                                            .background(Color.blue)
                                            .overlay(
                                                setPosition == position ?
                                                RoundedRectangle(cornerRadius: 8).stroke(.purple, lineWidth: 1) : nil
                                            )
                                        }
                                    }
                                }
                                
                            }
                            // 字体颜色
                            else if index == 2 {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(colorList, id: \.self) { color in
                                            Button {
                                                selectedColor = color
                                            } label: {
                                                Circle()
                                                    .fill(Color(hexInt: color))
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                    .padding(5)
                                            }
                                            .overlay(
                                                selectedColor == color ?
                                                Circle().stroke(.purple, lineWidth: 1) : nil
                                            )
                                            .padding(6)
                                            
                                        }
                                    }
                                    .background(Color.black.opacity(0.6))
                                }
                                
                            } else {
                                
                            }
                            
                        }
                        
                        
                    }
                }
                
                VStack {
                    Button("保存预览图和背景图") {
                        let bcImage = allBcImages[bcImage]
                        let preImage = dailPreviewUIImage()
                        Task {
                            await viewModel.makeDailandTransfer(preImage, bcImage, setPosition, selectedColor)
                        }
                        showProgress()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
            }
            .padding(.horizontal, 20)
        }
        
        // 当progress发生变化时，更新progressHUD
        .onReceive(viewModel.$progress, perform: { progress in
            updateProgress(progress)
        })
        
        
        .sheet(isPresented: $showImagePicker) {
            // DismissCallback
        } content: {
            SiCeImagePicker(show: $showImagePicker, images: $allBcImages)
                .animation(.easeInOut)
        }
    }
    
    
    
    // 展示进度条
    func showProgress() {
        guard let window = UIApplication.shared.windows.first else { return }
        progressHUD = MBProgressHUD(view: window)
        
        window.addSubview(progressHUD!)
        progressHUD?.mode = .determinateHorizontalBar
        progressHUD?.label.text = "seche dial transfer..."
        progressHUD?.show(animated: true)
    }
    
    // 更新进度条
    func updateProgress(_ progress: Float) {
        
        if progress == 1 {
            progressHUD?.label.text = lang("transfer dial file success")
            progressHUD?.hide(animated: true, afterDelay: 1)
        } else {
            progressHUD?.label.text = lang("sync data...") + "\(Int(progress*100))%"
            progressHUD?.progress = progress
                    
        }
    }
    
    // 时间位置
    func makePlacementType(_ placement: Int) -> JL_PLACEMENT_TYPE {
        if placement == 1 {
            return JL_PLACEMENT_TYPE.CENTER_TOP
        } else if placement == 2 {
            return JL_PLACEMENT_TYPE.CENTER_BOTTOM
        } else {
            return  JL_PLACEMENT_TYPE.LEFT_TOP
        }
    }
    
    // 位置标题
    func positionTitle(_ position: Int) -> String {
        var text = ""
        if position == 1 {
            text = "upLeft"
        } else if position == 2 {
            text = "upCenter"
        } else if position == 3 {
            text = "upRight"
        }else if position == 4 {
            text = "centerLeft"
        } else if position == 5 {
            text = "centerCenter"
        } else if position == 6 {
            text = "centerRight"
        } else if position == 7 {
            text = "bottomLeft"
        }  else if position == 8 {
            text = "bottomCenter"
        } else if position == 9 {
            text = "bottomRight"
        } else {
            text = "upLeft"
        }
        return text
    }
    
    func roundCorners(of image: UIImage, cornerRadius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let bounds = CGRect(origin: .zero, size: image.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        image.draw(in: bounds)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
    
    // 生成表盘预览
    func dailPreviewUIImage() -> UIImage {
        var bcUIImage = allBcImages[bcImage]
        // 覆盖图片
        
        bcUIImage = viewModel.resizeImage(image: bcUIImage, targetSize: CGSize(width: viewModel.pWidth, height: viewModel.pHeight)) ?? bcUIImage
        if bcUIImage.size.width == bcUIImage.size.height {
            bcUIImage = roundCorners(of: bcUIImage, cornerRadius: bcUIImage.size.width/2) ?? bcUIImage
        }
        var timeUIImage = UIImage(named: "icon_dail_time.png")!.withRenderingMode(.alwaysTemplate) // 转化为模板图片
//        timeUIImage = viewModel.resizeImage(image: timeUIImage, targetSize: timePosition.size) ?? timeUIImage
        var weekUIImage = weekUIImage().withRenderingMode(.alwaysTemplate)
//        weekUIImage = viewModel.resizeImage(image: weekUIImage, targetSize: weekPosition.size) ?? weekUIImage
        
        let position = imagePosition(tImageSize: timeUIImage.size, wImageSize: weekUIImage.size)

        
        // 设置颜色
        let coloredUIImageT = timeUIImage.tinted(with: UIColor(hexInt: selectedColor))
        let colorUIImageW =  weekUIImage.tinted(with: UIColor(hexInt: selectedColor))
        
        let positionT: CGPoint = position.timePosition.origin
        let sizeT: CGSize = position.timePosition.size
        let positionW: CGPoint = position.weekPosition.origin
        let sizeW: CGSize = position.weekPosition.size
        
        let imageT = overlay(backgroundImage: bcUIImage, overlayImage: coloredUIImageT, position: positionT, size: sizeT)
        let imageW = overlay(backgroundImage: imageT, overlayImage: colorUIImageW, position: positionW, size: sizeW)
        
        // 重设图片尺寸
        let presize = CGSize(width: viewModel.pWidth, height: viewModel.pHeight) // 预览图片尺寸
        let preimage = imageW.resize(to: presize)
        
        return preimage
    }
    
    // 图片的位置
    func imagePosition (tImageSize: CGSize,wImageSize: CGSize) -> (timePosition: CGRect, weekPosition: CGRect) {
        var timePosition: CGRect
        var weekPosition: CGRect

        var loc = locations.first!
        for location in locations {
            if location.type.rawValue == setPosition {
                loc = location
            }
        }
        
        let t_x = CGFloat(loc.time[0])*(viewModel.pWidth/viewModel.bgWidth)
        let t_y = CGFloat(loc.time[1])*(viewModel.pHeight/viewModel.bgHeight)
        let w_x = CGFloat(loc.week[0])*(viewModel.pWidth/viewModel.bgWidth)
        let w_y = CGFloat(loc.week[1])*(viewModel.pHeight/viewModel.bgHeight)
        timePosition = CGRect(x: t_x, y: t_y, width: tImageSize.width, height: tImageSize.height)
        weekPosition = CGRect(x: w_x, y: w_y, width: wImageSize.width, height: wImageSize.height)
        
        return (timePosition, weekPosition)
    }
    
    // 在背景图片上覆盖图片
    func overlay(backgroundImage: UIImage, overlayImage: UIImage, position: CGPoint, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, false, backgroundImage.scale)
        backgroundImage.draw(at: .zero)
        overlayImage.draw(in: CGRect(origin: position, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? backgroundImage
    }
    
    // 根据位置选择weekImage
    func weekUIImage() -> UIImage {
        let weekImage: UIImage!
        // 根据语言选择图片
        let languageCode = Locale.current.languageCode
        switch languageCode {
        case "en":
            weekImage = UIImage(named: "icon_dail_date_week_en.png")!
        case "it":
            weekImage = UIImage(named: "icon_dail_date_week_en.png")!
        default:
            weekImage = #imageLiteral(resourceName: "icon_dail_date_week.png")
        }
        return weekImage
    }
    
}


// MARK: - ImagePicker

struct SiCeImagePicker: UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
        var parent: SiCeImagePicker
        
        init(_ parent: SiCeImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                let cropController = CropViewController(image: image)
                cropController.delegate = self
                // FIXME: 获取不到手表的宽高
                let watchScreen = IDOWatchScreenInfoModel.current()!
                let width = watchScreen.width
                let height = watchScreen.height
                
                cropController.customAspectRatio = CGSize(width: width, height: height) // Set the custom aspect ratio
                
                cropController.aspectRatioLockEnabled = true // The crop box is locked to the aspect ratio specified above
                cropController.resetAspectRatioEnabled = false // The user cannot reset the aspect ratio
                cropController.rotateButtonsHidden = true // The user cannot rotate the image
                
                picker.dismiss(animated: true) {
                    UIApplication.shared.windows.first?.rootViewController?.present(cropController, animated: true, completion: nil)
                }
            }
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            parent.images.insert(image, at: 0)
            parent.show = false
            cropViewController.dismiss(animated: true)
        }
        
    }
}



