//
//  ClubList.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI

struct ClubList: View {
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        VStack {
            Text("Number of clubs: \(dataManager.clubs.count)")
            ForEach(dataManager.clubs) { club in
                Text(club.getName())
            }
            Button(action: {
                let u = User(name: "Torri", city: "Seattle")
                let c = Club(creator: u, name: "Pick up league", description: "Pick up ballers", privateClub: false, preReqsNeeded: false, preReqs: "")
                dataManager.clubs.append(c)
            }, label: {
                Text("Create Club")
            })
        }
    }
}

struct ClubList_Previews: PreviewProvider {
    static var previews: some View {
        ClubList(dataManager: DataManager())
    }
}
