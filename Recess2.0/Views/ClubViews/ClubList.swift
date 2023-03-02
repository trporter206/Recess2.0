//
//  ClubList.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ClubList: View {
    @EnvironmentObject var dM: DataManager
    
    var body: some View {
        VStack {
            NavigationLink(destination: CreateClubForm(), label: {
                Text("Create Club").padding()
            })
            Text("Number of clubs: \(dM.clubs.count)").bold().padding()
            ForEach($dM.clubs) { $club in
                ClubListItem(club: $club)
            }
        }
    }
}

struct ClubList_Previews: PreviewProvider {
    static var previews: some View {
        ClubList().environmentObject(DataManager())
    }
}
