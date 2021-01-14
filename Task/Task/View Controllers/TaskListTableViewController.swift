//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Devin Flora on 1/13/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.tasks[indexPath.row]
        cell.delegate = self
        cell.updateViews(task: task)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTaskDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            destination.task = taskToSend
            
        }
    }
}

// MARK: - Extension
extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsComplete(task: task)
        cell.updateViews(task: task)
    }
}
