//
//  GetBlueInfoViewController.swift
//  testDemo
//
//  Created by 何东阳 on 2019/6/13.
//  Copyright © 2019 何东阳. All rights reserved.
//

import Foundation
import IDOBlueProtocol

class GetBlueInfoViewController: UIViewController{

    var type : Int = 1
    
    let textView = UITextView();
    let button = UIButton();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
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
        self.button.addTarget(self, action:#selector(getBlueInfo), for: UIControlEvents.touchUpInside);
        self.button.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.textView.mas_bottom)?.offset()(30);
            maker?.left.equalTo()(30);
            maker?.right.equalTo()(-30);
            maker?.height.equalTo()(40);
        }
    }
    
    @objc func getBlueInfo() {
        if self.type == 1 { // get mac
            self.showLoading(message: "get mac addr...");
            IDOFoundationCommand.getMacAddrCommand { (errorCode, model) in
                if errorCode == 0 {
                    self.showTotal(message: "get mac addr success");
                    self.textView.text = String("macAddr: ") + String(model?.macAddr ?? "");
                }else {
                    self.showTotal(message: "get mac addr failed");
                }
            };
        }else if self.type == 2 { // get device info
            self.showLoading(message: "get device info...");
            IDOFoundationCommand.getDeviceInfoCommand { (errorCode, model) in
                if errorCode == 0 {
                    self.showTotal(message: "get device info success");
                    let data = try? JSONSerialization.data(withJSONObject: model?.dicFromObject() ?? NSDictionary.init(), options: [])
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    self.textView.text = String(str ?? "");
                }else {
                    self.showTotal(message: "get device info failed");
                }
            };
        }else if self.type == 3 { // get func table
            self.showLoading(message: "get func table...");
            IDOFoundationCommand.getFuncTableCommand { (errorCode, model) in
                if errorCode == 0 {
                    self.showTotal(message: "get func table success");
                    let data = try? JSONSerialization.data(withJSONObject: model?.dicFromObject() ?? NSDictionary.init(), options: [])
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    self.textView.text = String(str ?? "");
                }else {
                    self.showTotal(message: "get func table failed");
                }
            }
        }
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
}
