//
//  SettingsDataManager.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 12/05/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation

public class SettingsDataManager {
    
    private let SHOW_ONLY_FAVORITES: String = "SHOW_ONLY_FAVORITES"
    private let ALL_TAGS: String = "ALL_TAGS"
    private let SELECTED_TAGS: String = "SELECTED_TAGS"

    
    private static var settingsDataManager : SettingsDataManager?
    public static var instance : SettingsDataManager {
        if settingsDataManager == nil {
            settingsDataManager = SettingsDataManager()
        }
        
        return settingsDataManager!
    }
    
    public func toggleShowOnlyFavorites() {
        showOnlyFavorite = !showOnlyFavorite
    }
    
    public var showOnlyFavorite: Bool {
        get {
            return readBool(SHOW_ONLY_FAVORITES)
        }
        set {
            store(SHOW_ONLY_FAVORITES, newValue)
        }
    }
    
    public var allTags: [String] {
        get {
            return readArray(ALL_TAGS)
        }
        set {
            store(ALL_TAGS, newValue)
        }
    }
    
    public func toggleSelectedTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags = selectedTags.filter({$0 != tag})
        } else {
            selectedTags.append(tag)
        }
    }
    
    public var selectedTags: [String] {
        get {
            return readArray(SELECTED_TAGS)
        }
        set {
            store(SELECTED_TAGS, newValue)
        }
    }
    
    private func store(_ key: String, _ val: [String]) {
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize ()
    }
    
    private func store(_ key: String, _ val: Bool) {
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize ()
    }
    
    private func readBool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private func readArray(_ key: String) -> [String] {
        return UserDefaults.standard.array(forKey: key) as? [String] ?? []
    }
}
