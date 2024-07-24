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



class RWDailViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        
        // 导航栏
        super.viewDidLoad()
        self.navigationItem.title = lang("JieLi wallpaper dial")
        
        // 显示 toolbar
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        // 创建导航栏按钮
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonClicked))
        
        // 设置导航栏右侧按钮
        //        self.navigationItem.rightBarButtonItem = button
        
      
            // 创建 SwiftUI 视图
            let swiftUIView = RWDialDailView(viewModel: RWDialDailViewModel())
            
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
            
      
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonClicked() {
        
    }
}


// MARK: - ViewModel

class RWDialDailViewModel: ObservableObject {
    @Published var showImagePicker: Bool = false
    @Published var selectedImages: [UIImage] = [UIImage(named: "dial_background")!,UIImage(named: "watchface")!]
    @Published var preImage: UIImage?
    @Published var progress: Float = 0
    
    var progressHUD: MBProgressHUD?
    //    static let shared = RWDialDailViewModel()
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        let size = image.size
         UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
         image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
         let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         return resizedImage
    }
    
    // 生成表盘并传输
    func makeDail(_ bcUIImage: UIImage, _ textColor: UInt32, _ placementType: JL_PLACEMENT_TYPE) async{
        
        let model = IDOJLDialModel()
        model.backgroundImage = bcUIImage
        model.textColor = textColor
        model.placementType = placementType
        
        
        let fileManager = FileManager.default
        
        // 获取文档目录的路径
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        
        // 创建新的文件夹的路径
        let newDirectory = documentsDirectory.appendingPathComponent("IDODial/JLWatchDail")
        
        do {
            let data = try IDOUpdateJLManager.jlDialBin(fromParameter: model)
            
            try fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: true)
            let fileUrl = newDirectory.appendingPathComponent("JLWatchDail.bin")
            try data.write(to: fileUrl)
            print("保存表盘文件成功: \(data.count)")
            
            transferDail(fileUrl)
            print("传输文件成功")
        } catch {
            print("生成表盘文件失败: \(error.localizedDescription)")
        }
        
    }
    
    // 传输文件
    func transferDail(_ url: URL) {
        
        initTransferManager().filePath = url.path
        initTransferManager().compressionType = IDO_DATA_TRAN_COMPRESSION_TYPE.FASTLZ_TYPE
        initTransferManager().transferType = IDO_DATA_FILE_TRAN_TYPE.PHOTO_TYPE
        initTransferManager().isSetConnectParam = true
        initTransferManager().fileName = "wallpaper.z"
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


struct RWDialDailView: View {
    
    @ObservedObject var viewModel: RWDialDailViewModel
    @State var bcImage: UIImage = UIImage(named: "dial_background")!
    @State var timeImagePosition: Int = 0
    @State var selectedColor = 0xffffff
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
                if let preImage = dailPreImage() {
                    Image(uiImage: preImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 142)
                        .padding(10)
                }
                else {
                    ZStack {
                        Image(uiImage: bcImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 142)
                            .padding(10)
                        
                        Image(timePositions[timeImagePosition])
                            .renderingMode(.template) // 设置为模版图像
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 142)
                            .foregroundColor(Color(hexInt: selectedColor))
                            .padding(10)
                        
                    }
                }
                
                // 设置杰理壁纸表盘
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
                                            viewModel.showImagePicker = true
                                        } label: {
                                            Text("Add")
                                                .foregroundColor(.blue)
                                                .frame(width: 100, height: 118)
                                                .background(Color.gray)
                                                .cornerRadius(25)
                                        }
                                        
                                        
                                        ForEach(viewModel.selectedImages.indices, id: \.self) { index in
                                            Button {
                                                bcImage = viewModel.selectedImages[index]
                                            } label: {
                                                Image(uiImage: viewModel.selectedImages[index])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 118)
                                            }
                                            .cornerRadius(8)
                                            .padding(.all, 4)
                                            .overlay(
                                                bcImage == viewModel.selectedImages[index] ?
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
                                        ForEach(timePositions.indices, id: \.self) { index in
                                            Button {
                                                timeImagePosition = index
                                                
                                            } label: {
                                                ZStack {
                                                    
                                                    
                                                    
                                                    Image(uiImage: bcImage)
                                                        .resizable()
                                                        .frame(width: 100, height: 118)
                                                        .aspectRatio(contentMode: .fit)
                                                    
//                                                        .padding(.all, 4)
                                                    
                                                    
                                                    Image(timePositions[index])
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 100, height: 118)
//                                                        .padding(.all, 4)
                                                    
                                                }
                                                
                                            }
                                            .padding(4)
                                            .cornerRadius(8)
                                            .overlay(
                                                timeImagePosition == index ?
                                                RoundedRectangle(cornerRadius: 8).stroke(.purple, lineWidth: 1) : nil
                                                    
                                            )
                                            .padding(2)
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
                                
                            }
                            else {
                                
                            }
                            
                        }
                        
                        
                    }
                }
                
                // 生成表盘
                VStack{
                    
                    Button(lang("Generate the watch face and transfer it")) {
                        
                        let placementType = makePlacementType(timeImagePosition)
                        Task {
                            await viewModel.makeDail(bcImage, UInt32(selectedColor), placementType)
                        }
                        showProgress()
                        
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .background(Color.blue)
                    .cornerRadius(20)
                    
                }
                .padding(.bottom, 10)
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
        }
        
        // 当progress发生变化时，更新progressHUD
        .onReceive(viewModel.$progress, perform: { progress in
            updateProgress(progress)
        })
        
        // imagePicker
        .sheet(isPresented: $viewModel.showImagePicker, content: {
            CropImagePicker()
                .environmentObject(viewModel)
                .animation(.easeInOut)
        })
        
        
    }
    
    
    
    // 展示进度条
    func showProgress() {
        guard let window = UIApplication.shared.windows.first else { return }
        progressHUD = MBProgressHUD(view: window)
        
        window.addSubview(progressHUD!)
        progressHUD?.mode = .determinateHorizontalBar
        progressHUD?.label.text = lang("JieLi wallpaper watch face updated")
        progressHUD?.show(animated: true)
    }
    
    // 更新进度条
    func updateProgress(_ progress: Float) {
        
        if progress == 1 {
            progressHUD?.label.text = lang("transfer dial file success")
            progressHUD?.hide(animated: true, afterDelay: 1)
        }else if progress == 0 {
            progressHUD?.label.text = lang("transfer dial file failed")
            progressHUD?.hide(animated: true, afterDelay: 1)
        }else {
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
    
    // 生成表盘预览
    func dailPreImage() -> UIImage? {
        
        let model = IDOJLDialModel()
        model.backgroundImage = bcImage
        model.textColor = UInt32(selectedColor)
        model.placementType = makePlacementType(timeImagePosition)
        
        
        
        // 创建一个 NSError 指针
        var error: NSError?
        
        // 调用 jlCompose:errorInfo: 方法
        let image = IDOUpdateJLManager.jlCompose(model, errorInfo: &error)
        
        // 检查是否有错误
        if let error = error {
            
            print("生成杰理壁纸表盘预览图错误: \(error.localizedDescription)")
            return nil
            
        } else {
            // 使用生成的图片
         
            return image
        }
    }
    
}




// MARK: - CropImagePicker


struct CropImagePicker: UIViewControllerRepresentable {
  
    @EnvironmentObject var viewModel: RWDialDailViewModel
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        //        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
        var parent: CropImagePicker
        
        init(_ parent: CropImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                let screen = IDOWatchScreenInfoModel.current()
                let cropController = CropViewController(image: image)
                cropController.delegate = self
                cropController.customAspectRatio = CGSize(width: 120, height: 142) // Set the custom aspect ratio
                cropController.aspectRatioLockEnabled = true // The crop box is locked to the aspect ratio specified above
                cropController.resetAspectRatioEnabled = false // The user cannot reset the aspect ratio
                cropController.rotateButtonsHidden = true // The user cannot rotate the image
                
                picker.dismiss(animated: true) {
                    UIApplication.shared.windows.first?.rootViewController?.present(cropController, animated: true, completion: nil)
                }
            }
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            // 'image' is the newly cropped version of the original image
            let screen = IDOWatchScreenInfoModel.current()
            let width = screen?.width ?? 240
            let height = screen?.height ?? 284
            let cropRect1 = CGRect(x:0, y: 0, width: width, height: height)
            if let newImage = cropImage(image: image, cropRect: cropRect1) {
//                writeImageToFile(image: newImage, filePath: "123.png")
                parent.viewModel.selectedImages.insert(newImage,at: 0)
                parent.viewModel.showImagePicker = false
            }
            cropViewController.dismiss(animated: true)
        }
        
        func cropImage(image: UIImage, cropRect: CGRect) -> UIImage? {
            guard let cgImage = image.cgImage else {
                return nil
            }
            
            let croppedCGImage = cgImage.cropping(to: cropRect)
            let croppedImage = UIImage(cgImage: croppedCGImage!)
            
            return croppedImage
        }
        
        func scaleImage(_ image: UIImage, to size: CGSize) -> UIImage? {
            if image.size.width == size.width && image.size.height == size.height {
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            context.translateBy(x: 0.0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.copy)
            context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
        
        func writeImageToFile(image: UIImage, filePath: String) {
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(filePath)
                
                if let data = image.pngData() {
                    do {
                        try data.write(to: fileURL)
                        print("图片写入成功")
                    } catch {
                        print("图片写入失败：\(error.localizedDescription)")
                    }
                }
            }
        }
    }
}



