//
//  Recess2_0App.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import SwiftUI

@main
struct Recess2_0App: App {
    var dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            NavigationMenu(dataManager: dataManager)
        }
    }
}
