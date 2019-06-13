//
//  BindedViewController.swift
//  testDemo
//
//  Created by 何东阳 on 2019/6/12.
//  Copyright © 2019 何东阳. All rights reserved.
//

import UIKit
import IDOBlueProtocol

class BindedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var devices:[Any] = ["unbind device","get mac info","get device info","get func table","set current time"]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (self.devices.count - 1) {
            let model = IDOSetTimeInfoBluetoothModel.init();
            self.showLoading(message: "set current time...");
            IDOFoundationCommand.setCurrentTime(model) { (errorCode) in
                if errorCode == 0 {
                    self.showTotal(message: "set current time success");
                }else {
                    self.showTotal(message: "set current time failed");
                }
            }
        }else if indexPath.row == 0 {
            self.showLoading(message: "device unbind...");
            IDOFoundationCommand.mandatoryUnbindingCommand { (errorCode) in
                if errorCode == 0 {
                    self.showTotal(message: "device unbind success");
                    let scanViewController = ViewController.init();
                    scanViewController.title = "sacn page";
                    let rootViewController = UINavigationController.init(rootViewController: scanViewController);
                    UIApplication.shared.delegate?.window??.rootViewController = rootViewController;
                }else {
                    self.showTotal(message: "device unbind failed");
                }
            }
        }else {
            let getInfoViewController = GetBlueInfoViewController.init();
            getInfoViewController.title = self.devices[indexPath.row] as? String;
            getInfoViewController.type = indexPath.row;
            self.navigationController?.pushViewController(getInfoViewController, animated: true);
        }
    };
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    };
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count;
    };
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = self.devices[indexPath.row] as? String;
        return cell;
    };
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI();
    }
    
    func setupUI()  {
        
        let table:UITableView = UITableView(frame:view.bounds, style: .plain)
        self.view!.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
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
