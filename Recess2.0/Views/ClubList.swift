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
        NavigationView {
            VStack {
                Text("Number of clubs: \(dataManager.clubs.count)").bold().padding()
                ForEach(dataManager.clubs) { club in
                    NavigationLink(destination: ClubDetail(dataManager: dataManager, club: club), label: {
                        Text(club.getName()).foregroundColor(.black)
                    })
                }
                Button(action: {
                    let c = Club(creator: dataManager.currentUser,
                                 name: "Pick up league",
                                 description: "Pick up ballers",
                                 privateClub: false,
                                 preReqsNeeded: false,
                                 preReqs: "")
                    dataManager.clubs.append(c)
                }, label: {
                    Text("Create Club").padding()
                })
            }
        }
    }
}

struct ClubList_Previews: PreviewProvider {
    static var previews: some View {
        ClubList(dataManager: DataManager())
    }
}
