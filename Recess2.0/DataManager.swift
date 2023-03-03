//
//  DataManager.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: ObservableObject {
    @Published var clubs = [Club]()
    @Published var meetUps = [MeetUp]()
    @Published var users = [User]()
    @Published var currentUser = User(id: UUID().uuidString, name: "temp", city: "temp")
    let db = Firestore.firestore()
    
    init() {
        getCurrentUser()
        getClubs()
        getMeetUps()
    }
    
    func getCurrentUser() {
        let playerRef = db.collection("Players")
        
        playerRef.document("402E8C70-E7E1-4627-91F7-DEA1BA7B441D").addSnapshotListener { documentSnapshot, error in
            do {
                self.currentUser = try documentSnapshot!.data(as: User.self)
            } catch {
                print(error)
            }
        }
    }
    
    func getClubs() {
        self.clubs = []
        Firestore.firestore().collection("Clubs").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print(error)
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let data = try document.data(as: Club.self)
                        self.clubs.append(data)
                    } catch {
                        print(error)
                    }
            
                }
            }
        }
    }
    
    func getMeetUps() {
        self.clubs = []
        Firestore.firestore().collection("MeetUps").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print(error)
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let data = try document.data(as: MeetUp.self)
                        self.meetUps.append(data)
                    } catch {
                        print(error)
                    }
            
                }
            }
        }
    }
    
    //TODO: test
    //EFFECTS: returns meetups in order of date
    func sortMeetUpsByDate(meetUps: Array<MeetUp>) -> Array<MeetUp> {
        return meetUps.sorted(by: { $0.getDate().compare($1.getDate()) == .orderedAscending })
    }
}

