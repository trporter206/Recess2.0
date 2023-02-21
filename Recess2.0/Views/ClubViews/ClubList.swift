//
//  ClubList.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI

struct ClubList: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Number of clubs: \(dataManager.clubs.count)").bold().padding()
                ForEach($dataManager.clubs) { $club in
                    ClubListItem(club: $club)
                }
                NavigationLink(destination: CreateClubForm(), label: {
                    Text("Create Club").padding()
                })
            }
        }
    }
}

struct ClubList_Previews: PreviewProvider {
    static var previews: some View {
        ClubList().environmentObject(DataManager())
    }
}
