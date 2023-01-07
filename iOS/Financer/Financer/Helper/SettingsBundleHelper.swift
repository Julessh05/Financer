//
//  SettingsBundleHelper.swift
//  Financer
//
//  Created by Julian Schumacher on 03.01.23.
//

import Foundation

// Settings Bundle Info from here: https://www.logisticinfotech.com/blog/setting-bundle-ios-application/

/// The Helper to register the Settings Bundle
/// and handle it's values
internal struct SettingsBundleHelper {
    
    /// A Struct to hold constants for the Keys
    /// of the Settings Bundle's Items
    private struct SettingsBundleKeys {
        
        /// The Key for the App Version
        static let appVersion = "app_version"
        
        /// The Key for the Build Number
        static let buildNumber = "build_number"
    }
    
    /// The shared Singleton Object to use in this App
    internal static let shared : SettingsBundleHelper = SettingsBundleHelper()
    
    /// The standard initializer to
    /// create a new Object of Settings Helper.
    /// This is private, so only the shared singleton Object
    /// can be used.
    private init() {
        // Set the Dictionary to the Main Bundle Dictionary
        // or an Empty Dictionary if the main bundle dict is
        // not available
        dict = Bundle.main.infoDictionary ?? [ : ]
        configure()
    }
    
    /// The User Defaults to store the Information in
    private let userDefaults : UserDefaults = UserDefaults.standard
    
    /// The Info Dictionary for this App.
    private let dict : [String : Any]
    
    /// The Function to set all Values
    /// to the Settings App
    internal func setValues() -> Void {
        guard let appVersion = dict["CFBundleShortVersionString"] else { return }
        guard let buildNumber = dict[String(kCFBundleVersionKey)] else { return }
        userDefaults.set(appVersion, forKey: SettingsBundleKeys.appVersion)
        userDefaults.set(buildNumber, forKey: SettingsBundleKeys.buildNumber)
    }
    
    /// Configures the Settings Bundle for the User Dictionary
    /// and it's default Values
    private func configure() -> Void {
        guard let settingsBundle = Bundle.main.url(forResource: "Settings", withExtension:"bundle") else { return }
        guard let settings = NSDictionary(contentsOf: settingsBundle.appendingPathComponent("Root.plist")) else { return }
        guard let preferences = settings.object(forKey: "PreferenceSpecifiers") as? [[String: AnyObject]] else { return }
        var defaultsToRegister : [String: AnyObject] = [ : ]
        for pref in preferences {
            if let key = pref["Key"] as? String, let val = pref["DefaultValue"] {
                defaultsToRegister[key] = val
            }
        }
        userDefaults.register(defaults: defaultsToRegister)
    }
}
