//
//  DiffDataSource.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//
import UIKit

class DiffDataSource: UITableViewDiffableDataSource<SectionType, Item> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
