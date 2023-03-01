//
//  Recess2_0App.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

@main
struct Recess2_0App: App {
    @StateObject var dataManager = DataManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationMenu().environmentObject(DataManager())
        }
    }
}
    

