//
//  DiffTableView.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//

import UIKit

enum SectionType {
    case todo, complete
}

struct Item: Hashable {
    var id = UUID().uuidString
    var item: String
}

class DiffTableView: UITableViewController {
    var viewModel: HomeViewViewModel!
   lazy var source: DiffDataSource = .init(tableView: self.tableView) { (_, indexPath, item) -> UITableViewCell? in
        let cell = ItemCell(style: .default, reuseIdentifier: nil)
        cell.cellModel.itemDescription = item.item
        return cell
    }
    
    override func viewDidLoad() {
        viewModel.delegate = self
        var snapShot = source.snapshot()
        snapShot.appendSections([.todo, .complete])
        snapShot.appendItems(viewModel.toDoList, toSection: .todo)
        snapShot.appendItems(viewModel.completeList, toSection: .complete)
        source.apply(snapShot)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.text = section == 0 ? "TO DO" : "COMPLETED"
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            completion(true)
            var snapShot = self.source.snapshot()
            guard let item = self.source.itemIdentifier(for: indexPath) else {
                return
            }
            if indexPath.section == 0 {
                self.viewModel.toDoList.remove(at: indexPath.row)
                snapShot.deleteItems([item])
            } else {
                self.viewModel.completeList.remove(at: indexPath.row)
                snapShot.deleteItems([item])
            }
            self.source.apply(snapShot)
            
        }
        
        let complete = UIContextualAction(style: .normal, title: indexPath.section == 0 ? "Complete": "To Do") { (_, _, completion) in
            completion(true)
            var snapShot = self.source.snapshot()
            guard let item = self.source.itemIdentifier(for: indexPath) else {
                return
            }
            let section = snapShot.sectionIdentifier(containingItem: item)
            if section == .todo {
                self.viewModel.toDoList.remove(at: indexPath.row)
                self.viewModel.completeList.append(item)
                if let _ = snapShot.indexOfSection(.complete) {
                    snapShot.appendItems([item], toSection: .complete)
                } else {
                    snapShot.insertSections([.complete], afterSection: .todo)
                    snapShot.appendItems([item], toSection: .complete)
                }
            } else {
                self.viewModel.completeList.remove(at: indexPath.row)
                self.viewModel.toDoList.append(item)
                if let _ = snapShot.indexOfSection(.todo) {
                    snapShot.appendItems([item], toSection: .todo)
                } else {
                    snapShot.insertSections([.todo], beforeSection: .complete)
                    snapShot.appendItems([item], toSection: .todo)
                }
            }
            self.source.apply(snapShot)
            
        }
        return UISwipeActionsConfiguration(actions: [delete, complete])
    }
}



extension DiffTableView:  HomeViewViewModelDelgate {
    func newItemAdded(item: Item) {
        var snapShot = self.source.snapshot()
        if let _ = snapShot.indexOfSection(.todo) {
            snapShot.appendItems([item], toSection: .todo)
        } else {
            snapShot.appendSections([.todo])
            snapShot.appendItems([item], toSection: .todo)
        }
        
        self.source.apply(snapShot)
    }
}
