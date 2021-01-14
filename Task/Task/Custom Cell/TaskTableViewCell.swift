//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Devin Flora on 1/13/21.
//

import UIKit

// MARK: - Protocol
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: TaskCompletionDelegate?
    var task: Task? {
        didSet {
            guard let task = task else { return }
            updateViews(task: task)
        }
    }
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(cell: self)
    }
    
    // MARK: - Helper Functions
    func updateViews(task: Task) {
        taskNameLabel.text = task.name
        if task.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
//        guard let task = task else { return }
//        taskNameLabel.text = task.name
//        if task.isComplete {
//            completionButton.setBackgroundImage(complete, for: )
//        }
    }
    
    
}//End of Class
