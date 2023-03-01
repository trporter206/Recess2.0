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
    @Published var currentUser = User(name: "temp", city: "temp")
    let db = Firestore.firestore()
    
    init() {
        getCurrentUser()
    }
    
    func getCurrentUser() {
        let playerRef = db.collection("Players")
        playerRef.document("TorriPorter").addSnapshotListener { documentSnapshot, error in
            do {
                self.currentUser = try documentSnapshot!.data(as: User.self)
            } catch {
                print(error)
            }
        }
    }
    
    //TODO: test
    //EFFECTS: return users sorted by Tier Ranking
    func rankByTier(users: Array<User>) -> Array<User> {
        return users.sorted(by: {$0.getTier() > $1.getTier()})
    }
    
    //TODO: test
    //EFFECTS: return a filtered list of meet ups based on param
    func filterMeetUpsBySport(meetUps: Array<MeetUp>, sport: String) -> Array<MeetUp> {
        return meetUps.filter({$0.getSport() == sport})
    }
    
    //TODO: test
    //EFFECTS: returns clubs sorted by size
    func sortClubsBySize(clubs: Array<Club>) -> Array<Club> {
        return clubs.sorted(by: {$0.getMembers().count > $1.getMembers().count})
    }
    
    //TODO: test
    //EFFECTS: returns meetups in order of date
    func sortMeetUpsByDate(meetUps: Array<MeetUp>) -> Array<MeetUp> {
        return meetUps.sorted(by: { $0.getDate().compare($1.getDate()) == .orderedAscending })
    }
}

