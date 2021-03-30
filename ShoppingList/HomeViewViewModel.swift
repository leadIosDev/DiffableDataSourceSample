//
//  HomeViewViewModel.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//

import Foundation

protocol HomeViewViewModelDelgate: NSObject {
    func newItemAdded(item: Item)
}

class HomeViewViewModel: ObservableObject {
    var completeList = [Item]()
    var toDoList = [Item]()
    weak var delegate: HomeViewViewModelDelgate?
    init() {
        completeList = [.init(item: "Item 2"), .init(item: "Item 3")]
        toDoList = [.init(item: "Shirt"), .init(item: "Jean")]
    }
    
    func addNewItem(item: Item) {
        
        self.toDoList.append(item)
        delegate?.newItemAdded(item: item)
    }
}
