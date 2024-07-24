## 说明文档 [documentation]


```c
source 'https://github.com/idoosmart/IDOSmartSpec.git'
platform :ios, '13.0'
target 'your_target_name' do
   pod 'IDOBluetooth'
   pod 'IDOBlueProtocol'
   pod 'IDOBlueUpdate'
end
```


* [中文](https://idoosmart.github.io/IDOGitBook/zh/)      

* [English](https://idoosmart.github.io/IDOGitBook/en/)

2024-07-24 
update log: add Siche ota and run plan

IDOBluetooth  3.13.29
IDOBlueProtocol 3.40.45
IDOBlueUpdate 3.6.23



### Siche ota demo 

![image1](./images/image1.png)

<img src="./images/image2.jpg" style="zoom:33%;" />

<img src="./images/image3.jpg" style="zoom:33%;" />

<img src="./images/image4.jpg" style="zoom:33%;" />

<img src="./images/image5.jpg" style="zoom:33%;" />

<img src="./images/image6.jpg" style="zoom:33%;" />



- Decompress the upgrade file and import the directory to the application sandbox

- ```objective-c
   [IDOUpdateFirmwareManager shareInstance].updateType = IDO_SIFLI_PLATFORM_TYPE;
   [IDOUpdateFirmwareManager shareInstance].deviceUUID = IDO_BLUE_ENGINE.peripheralEngine.uuidStr;
   [IDOUpdateFirmwareManager startUpdate];
   
   #pragma mark ======================== IDOUpdateMangerDelegate===================================
  - (NSString *)currentPackagePathWithUpdateManager:(IDOUpdateFirmwareManager *)manager
  {
      return self.filePath;
  }
  
  - (void)updateManager:(IDOUpdateFirmwareManager *)manager
                  state:(IDO_UPDATE_STATE)state
  {
      FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
      if (state == IDO_UPDATE_COMPLETED) {
          funcVC.statusLabel.text = lang(@"update success");
          [funcVC showToastWithText:lang(@"update success")];
          [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                   selector:@selector(startTimer)
                                                     object:nil];
      }else if (state == IDO_UPDATE_START_RECONECT_DEVICE) { //进入ota 重连设备
          funcVC.statusLabel.text = [NSString stringWithFormat:@"%@...",lang(@"reconnect")];
      }else if (state != IDO_UPDATE_START_INIT
                && state != IDO_UPDATE_COMPLETED){
          funcVC.statusLabel.text = lang(@"update...");
      }
  }
  
  - (void)updateManager:(IDOUpdateFirmwareManager *)manager updateError:(NSError *)error
  {
      if (error.code == 3) {
          [IDOFoundationCommand getFuncTableCommand:nil];
      }
      FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
      funcVC.statusLabel.text = lang(@"update failed");
      [funcVC showToastWithText:lang(@"update failed")];
      NSString * errorStr = [NSString stringWithFormat:@"%@\n",error.domain];
      [self addMessageText:errorStr];
      [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTimer) object:nil];
  }
  
  - (void)updateManager:(IDOUpdateFirmwareManager *)manager
               progress:(float)progress
                message:(NSString *)message
  {
      if (progress > 0) {
          FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
          [funcVC showUpdateProgress:progress];
      }else {
          [self addMessageText:message?:@""];
      }
  }
  
  ```

  

### Run plan

<img src="./images/Runingplan1.png" alt="Runingplan1" style="zoom:50%;" />

<img src="./images/Runingplan2.png" alt="Runingplan2" style="zoom:50%;" />

<img src="./images/Runingplan3.png" alt="Runingplan3" style="zoom:50%;" />

- Login account to obtain Token

<img src="./images/Runingplan4.png" alt="Runingplan4" style="zoom:50%;" />

- Start Runing plan

<img src="./images/Runingplan5.png" alt="Runingplan5" style="zoom:50%;" />

- Upload user and device information

<img src="./images/Runingplan6.png" alt="Runingplan6" style="zoom:50%;" />

- Running plan management category (issuing plans, querying plans, synchronizing plans, ending plans

<img src="./images/Runingplan7.png" alt="Runingplan7" style="zoom:50%;" />

- Training management in running plans (real-time interaction with devices, H5 data, pause exercise, end exercise

<img src="./images/Runingplan8.png" alt="Runingplan8" style="zoom:50%;" />

- Server interface queries running plan details

<img src="./images/Runingplan9.png" alt="Runingplan9" style="zoom:50%;" />