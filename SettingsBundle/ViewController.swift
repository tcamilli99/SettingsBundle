//
//  ViewController.swift
//  SettingsBundle
//
//  Created by Tony Camilli on 8/21/18.
//  Copyright © 2018 Tony Camilli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textWebAddress: UITextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonEdit: UIBarButtonItem!
    @IBOutlet weak var buttonCancel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Register a notification delegate when settings are changed while app is running
       NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        initializeFields()
        enableEditControls(Enabled: false)
        buttonCancel.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSettingFromDefaults(Key: String) -> Any? {
        
        let userDefaults = UserDefaults.standard
        
        guard let valueForKey = userDefaults.value(forKey: Key) else {
            NSLog("Error getting value for key named \(Key)")
            return nil
        }
    
        debugPrint("\(Key)  :  \(valueForKey)")
        return valueForKey    
    }
    
    func setValueInSettings(Key: String, Value: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(Value, forKey: Key)
        debugPrint("Setting \(Key) : \(Value)")
        
    }
    
    func logValueForKey(Key: String) {
        
    }
    
    @objc func userDefaultsDidChange() {
        debugPrint("Settings Changed")
        initializeFields()
    }

    func initializeFields() {
        textName.text = getSettingFromDefaults(Key: "name_preference") as? String
        textEmail.text = getSettingFromDefaults(Key: "email_preference") as? String
        textWebAddress.text = getSettingFromDefaults(Key: "url_preference") as? String
        
        let emailEnabled = getSettingFromDefaults(Key: "communication_preference") as! Bool
        
        if emailEnabled {
            let emailFrequency = getSettingFromDefaults(Key: "frequency_preference") as! String
            
            labelEmail.text = "You will recieve \(emailFrequency) emails"
            
            
        } else {
            labelEmail.text = "You will not recieve emails"
        }
        
        let fontSize = getSettingFromDefaults(Key: "font_preference") as! CGFloat
        
        labelEmail.font = labelEmail.font.withSize(fontSize)
    }
    
    func enableEditControls(Enabled:  Bool) {
        textName.isEnabled = Enabled
        textEmail.isEnabled = Enabled
        textWebAddress.isEnabled = Enabled
    }

    @IBAction func buttonEditTapped(_ sender: UIBarButtonItem) {
        if buttonEdit.title == "Edit" {
            buttonEdit.title = "Save"
            buttonCancel.isEnabled = true
            buttonCancel.title = "Cancel"
            enableEditControls(Enabled: true)
            
        } else {
            buttonCancel.title = ""
            buttonEdit.title = "Edit"
            let newName = textName.text
            let newEmail = textEmail.text
            let newUrl = textWebAddress.text
            setValueInSettings(Key: "name_preference", Value: newName as Any)
            setValueInSettings(Key: "email_preference", Value: newEmail as Any)
            setValueInSettings(Key: "url_preference", Value: newUrl as Any)
            enableEditControls(Enabled: false)
            
        }
    }
    
    @IBAction func buttonCancelTapped(_ sender: UIBarButtonItem) {
        
        //Discard changed and reload from defaults
        initializeFields()
        enableEditControls(Enabled: false)
        buttonCancel.title = ""
        buttonEdit.title = "Edit"
        
    }
}

