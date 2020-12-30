//
//  TaskController.swift
//  Task
//
//  Created by Cameron Stuart on 12/29/20.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistenceStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Task.json") // <-- Change file (app) name
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(tasks) // <-- Change S.O.T
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our tasks: \(error) -- \(error.localizedDescription)") // <-- Update error message
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try jsonDecoder.decode([Task].self, from: data) // <-- Update S.O.T & Update the decoded type
        } catch {
            print("Error decoding our data into tasks: \(error) -- \(error.localizedDescription)") // <-- Update error message
        }
    }
    
}
