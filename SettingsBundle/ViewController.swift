//
//  ViewController.swift
//  SettingsBundle
//
//  Created by Tony Camilli on 8/21/18.
//  Copyright © 2018 Tony Camilli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        debugPrint("Settings at viewDidLoad():  ")
        logCurrentSettings()
        
        //Register a notification delegate when settings are changed while app is running
       NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSettingFromDefaults(Key: String) -> Any? {
        
        let userDefaults = UserDefaults.standard
        let retVal = userDefaults.value(forKey: Key)
        return retVal
    }
    
    func logCurrentSettings() {
        debugPrint("********** Settings Dump **********")
        logValueForKey(Key: "name_preference")
        logValueForKey(Key: "url_preference")
        logValueForKey(Key: "email_preference")
        logValueForKey(Key: "enabled_preference")
        logValueForKey(Key: "slider_preference")
        debugPrint("**********************************")        
    }
    
    func logValueForKey(Key: String) {
        guard let valueForKey = getSettingFromDefaults(Key: Key) else {
            NSLog("Error getting value for key named \(Key)")
            return
        }
        debugPrint("\(Key)  :  \(valueForKey)")
    }
    
    @objc func userDefaultsDidChange() {
        debugPrint("Settings Changed")
        logCurrentSettings()
    }


}

