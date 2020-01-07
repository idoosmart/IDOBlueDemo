//
//  ViewController.swift
//  testDemo
//
//  Created by 何东阳 on 2019/6/11.
//  Copyright © 2019 何东阳. All rights reserved.
//

import UIKit
import IDOBlueProtocol
import IDOBluetooth



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,IDOBluetoothManagerDelegate {

    var devices:[Any] = []
    var tableView : UITableView?
    let refreshControl = UIRefreshControl()
    
    // ido bluetooth manager delegate
    func bluetoothManager(_ manager: IDOBluetoothManager!, connectPeripheralError error: Error!) {
        
    };
    
    func bluetoothManager(_ manager: IDOBluetoothManager!, didUpdate state: IDO_BLUETOOTH_MANAGER_STATE) {
        
    };
    
    func bluetoothManager(_ manager: IDOBluetoothManager!, allDevices: [IDOPeripheralModel]!, otaDevices: [IDOPeripheralModel]!) {
        self.devices = allDevices;
        self.tableView?.reloadData();
    };
    
    func bluetoothManager(_ manager: IDOBluetoothManager!, center centerManager: CBCentralManager!, didConnect peripheral: CBPeripheral!, isOatMode isOtaMode: Bool) -> Bool {
        self.showTotal(message: "device connected");
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
         self.showMsgbox(_message: "bind current device");
        }
        return true;
    };
    
    func showMsgbox(_message: String, _title: String = "Tip"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
        let btnOK  = UIAlertAction(title: "ok", style: .default){(action)in
            self.showLoading(message: "device binding...");
            let model = IDOSetBindingInfoBluetoothModel.init();
            IDOFoundationCommand.bindingCommand(model, callback: {(state,errorCode) in
                if errorCode == 0 {
                    if state == IDO_BIND_STATUS.BLUETOOTH_BIND_SUCCESS { //bind success
                        self.showTotal(message: "device bind success");
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            let bindViewController = BindedViewController.init();
                            bindViewController.title = "func page";
                            let mainViewController = UINavigationController.init(rootViewController: bindViewController);
                            mainViewController.navigationBar.backgroundColor = UIColor.white;
                            self.present(mainViewController, animated: true, completion: nil);
                        }
                    }else if state == IDO_BIND_STATUS.BLUETOOTH_BINDED { // binded

                    }else if state == IDO_BIND_STATUS.BLUETOOTH_BIND_FAILED { // bind failed

                    }else if state == IDO_BIND_STATUS.BLUETOOTH_NEED_AUTH { // bind need auth

                    }else if state == IDO_BIND_STATUS.BLUETOOTH_REFUSED_BINDED { // bind refused

                    }
                }else {
                    self.showTotal(message: "device bind failed");
                }
            });
        }
        let btnCal = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        alert.addAction(btnCal)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // scan device table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showLoading(message: "device connect...");
        let model = self.devices[indexPath.row];
        IDOBluetoothManager .connectDevice(with: model as? IDOPeripheralModel);
    };
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    };
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count;
    };
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
       let model = self.devices[indexPath.row];
        cell.textLabel?.text = (model as! IDOPeripheralModel).name;
       return cell;
    };
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        if #available(iOS 10.0, *) {
            
        }else {
            let barButtonItem = UIBarButtonItem(title: "scan", style: UIBarButtonItemStyle.plain, target: self, action: #selector(scanDevice))
            self.navigationItem.rightBarButtonItem = barButtonItem;
        }

        IDOBluetoothManager.shareInstance()?.rssiNum = 100;
        IDOBluetoothManager.shareInstance()?.delegate = self;
        self.setupUI();
        self.addHeader();
    }
        
    func setupUI()  {
        self.tableView = UITableView(frame:view.bounds, style: .plain)
        self.view!.addSubview(self.tableView!)
        self.tableView!.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tableView!.separatorStyle = .singleLine
        self.tableView!.dataSource = self
        self.tableView!.delegate   = self
        self.tableView!.tableFooterView = UIView()
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    @objc func scanDevice(){
        IDOBluetoothManager.startScan();
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.refreshControl.endRefreshing();
        });
    }
    
    func addHeader(){
        if #available(iOS 10.0, *) {
            self.tableView!.refreshControl = refreshControl
            refreshControl.backgroundColor = UIColor.lightGray
            refreshControl.attributedTitle = NSAttributedString(string: "drop down scan...", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
            refreshControl.tintColor = UIColor.black
            refreshControl.tintAdjustmentMode = .dimmed
            refreshControl.addTarget(self, action: #selector(scanDevice), for: .valueChanged)
            view.addSubview(self.tableView!)
        } else {
           
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

