//
//  CreateClubForm.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CreateClubForm: View {
    @EnvironmentObject var dM: DataManager
    @State private var newClubData = Club.Data(id: UUID().uuidString)
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Create club form")
            ClubFields(newClubData: $newClubData)
            Toggle("Club is private", isOn: $newClubData.privateClub).toggleStyle(.switch).padding()
            Button(action: {
                let newID = UUID().uuidString
                Firestore.firestore().collection("Clubs").document("\(newID)").setData([
                    "id": newID,
                    "creator": dM.currentUser.getID(),
                    "name": newClubData.name,
                    "description": newClubData.description,
                    "members" : [dM.currentUser.getID()],
                    "scheduledGames" : [],
                    "privateClub": newClubData.privateClub,
                    "preReqsNeeded": newClubData.preReqsNeeded,
                    "reqHosted": newClubData.reqHosted,
                    "reqJoined": newClubData.reqJoined,
                    "reqTier": newClubData.reqTier,
                    "reqWins": newClubData.reqWins,
                    "clubRef" : Firestore.firestore().collection("Clubs").document(newID)
                ])
                Firestore.firestore().collection("Players").document(dM.currentUser.getID()).updateData([
                    "createdClubs" : FieldValue.arrayUnion([newID])
                ])
                dM.getClubs()
                showingAlert = true
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Create club")
            })
            .alert("Club Created", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
        }
        .padding()
    }
}

struct CreateClubForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateClubForm().environmentObject(DataManager())
    }
}
