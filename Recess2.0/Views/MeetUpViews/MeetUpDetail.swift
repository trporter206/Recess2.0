//
//  MeetUpDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct MeetUpDetail: View {
    @EnvironmentObject var dM: DataManager
    var meetUp: MeetUp
    
    var body: some View {
        Text(meetUp.getSport())
    }
}

struct MeetUpDetail_Previews: PreviewProvider {
    static var previews: some View {
        MeetUpDetail(meetUp: DataManager().meetUps[0]).environmentObject(DataManager())
    }
}
