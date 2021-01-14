//
//  Task.swift
//  Task
//
//  Created by Devin Flora on 1/13/21.
//

import Foundation

class Task: Codable {
    
    var name: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    
    init(name: String, notes: String?, dueDate: Date = Date(), isComplete: Bool = false) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}//End of Class

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.notes == rhs.notes
    }
}
