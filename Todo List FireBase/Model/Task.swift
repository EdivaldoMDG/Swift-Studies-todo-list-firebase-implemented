//
//  Task.swift
//  Todo List FireBase
//
//  Created by Edivaldo Goncalves on 3/10/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task : Codable, Identifiable {
   @DocumentID var id: String? 
    var title: String
    var completed: Bool
    @ServerTimestamp  var createdTime: Timestamp?
}

#if DEBUG
let testDataTasks = [
    Task(title: "Implemented", completed: true),
    Task(title: "Connected to Firebase", completed: false),
    Task(title: "??", completed: false),
    Task(title: "Profit! ", completed: false)
]  
#endif
