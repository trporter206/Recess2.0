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
        getUsers()
    }
    
    func getUsers() {
        var user: User = User(name: "temp", city: "temp")
        let playersRef = db.collection("Players")
        
        playersRef.document("TorriPorter").setData([
            "id" : UUID().uuidString,
            "name" : "Torri Porter",
            "city" : "Vancouver",
            "about" : "The best in town",
            "joinedClubs" : [],
            "scheduledMeetUps" : [],
            "numHostedMeets" : 0,
            "numJoinedMeets" : 0,
            "wins" : 0,
            "losses" : 0,
            "tier" : 0
        ])
        
        playersRef.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                let documents = querySnapshot!.documents
                self.users = documents.compactMap { doc in
                    do {
                        let data = try doc.data(as: User.self)
                        self.currentUser = data
                    } catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
        print("found current user \(user.getName())")
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

