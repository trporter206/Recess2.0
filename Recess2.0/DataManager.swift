//
//  DataManager.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import Foundation

class DataManager: ObservableObject {
    @Published var clubs = [Club]()
    @Published var meetUps = [MeetUp]()
    @Published var users = [User]()
    
    init() {
        
    }
    
}
