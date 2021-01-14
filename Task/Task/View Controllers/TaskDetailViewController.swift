//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Devin Flora on 1/13/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Propterties
    var task: Task?
    var date: Date?

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = taskNameTextField.text, !title.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: title, notes: taskNotesTextView.text, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: title, notes: taskNotesTextView.text, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    
    
}
