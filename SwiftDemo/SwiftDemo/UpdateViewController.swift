//
//  UpdateViewController.swift
//  SwiftDemo
//
//  Created by 何东阳 on 2019/12/18.
//  Copyright © 2019 何东阳. All rights reserved.
//

import Foundation
import IDOBlueUpdate

class UpdateViewController: UIViewController,IDOUpdateManagerDelegate{
    
    let path = Bundle.main.path(forResource: "ID205_DFU_V33_20190712", ofType: "zip");
    var logStr = "";
    let textView  = UITextView();
    let button = UIButton();
    
    //update firmware manager delegate
    func currentPackagePath(withUpdate manager: IDOUpdateFirmwareManager?) -> String? {
        self.path;
    }
    
    func update(_ manager: IDOUpdateFirmwareManager?, progress: Float, message: String?) {
        if progress > 0 {
            self.showProgress(progress: progress);
        }else {
            self.addMessageText(message: message!);
        }
    }
    
    func update(_ manager: IDOUpdateFirmwareManager?, state: IDO_UPDATE_STATE) {
        if state == IDO_UPDATE_STATE.COMPLETED {
            self.showTotal(message: "update success");
        }else if state == IDO_UPDATE_STATE.DID_ENTER_OTA{
            self.showTotal(message: "enter ota")
        }else if state == IDO_UPDATE_STATE.STARTING {
            self.showLoading(message: "update...");
        }
    }
    
    func update(_ manager: IDOUpdateFirmwareManager?, updateError error: Error?) {
        self.addMessageText(message: error.debugDescription);
        self.showTotal(message: "update failed");
    }
    
    func addMessageText(message:String) -> Void {
        self.logStr = String.localizedStringWithFormat("%@\n\n,%@",self.textView.text,message);
        self.textView.text = self.logStr;
        self.textView.scrollRangeToVisible(NSRange(location: self.textView.text.count,length: 1));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        IDOUpdateFirmwareManager.shareInstance().delegate = self;
        IDOUpdateFirmwareManager.shareInstance().updateType = IDO_UPDATE_PLATFORM_TYPE.NORDIC_PLATFORM_TYPE;
        self.setupUI();
    }
    
    func setupUI(){
         self.view .addSubview(self.textView);
         self.textView.backgroundColor = UIColor.black;
         self.textView.textColor = UIColor.white;
         self.textView .mas_makeConstraints { (maker) in
             maker?.left.equalTo()(0);
             maker?.right.equalTo()(0);
             maker?.top.equalTo()(0);
             maker?.height.equalTo()(300);
         }
         
         self.view .addSubview(self.button);
         self.button .setTitle(self.title, for: UIControlState.normal);
         self.button.backgroundColor = UIColor.orange;
         self.button.addTarget(self, action:#selector(updateFirmware), for: UIControlEvents.touchUpInside);
         self.button.mas_makeConstraints { (maker) in
             maker?.top.equalTo()(self.textView.mas_bottom)?.offset()(30);
             maker?.left.equalTo()(30);
             maker?.right.equalTo()(-30);
             maker?.height.equalTo()(40);
         }
     }
     
    @objc func updateFirmware() {
        IDOUpdateFirmwareManager.startUpdate();
    }
    
    lazy var HUD : MBProgressHUD = {
        let hud = MBProgressHUD.init(view: self.view);
        self.view .addSubview(hud);
        return hud;
    }()
    
    func showLoading(message: String) -> Void {
        self.HUD.mode = MBProgressHUDMode.indeterminate;
        self.HUD.label.text = message;
        self.HUD.show(animated: true);
    }
    
    func showTotal(message: String) -> Void {
        self.HUD.mode = MBProgressHUDMode.text;
        self.HUD.label.text = message;
        self.HUD.show(animated: true);
        self.HUD.hide(animated: true, afterDelay: 2);
    }
    
    func showProgress(progress: Float) -> Void {
        self.HUD.mode = MBProgressHUDMode.determinateHorizontalBar;
        self.HUD.label.text = String.localizedStringWithFormat("%@%.2f%@","file update",progress*100.0,"%");
        self.HUD.progress = progress;
        self.HUD.show(animated: true);
    }
}
