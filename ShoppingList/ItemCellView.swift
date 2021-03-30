//
//  ItemCellView.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//

import SwiftUI


class CellViewModel: ObservableObject {
    @Published var itemDescription: String = ""
}


struct CellView: View {
    @ObservedObject var viewModel: CellViewModel
    var body: some View {
        HStack {
            Text(viewModel.itemDescription)
            Spacer()
        }
        .padding()
    }
}

class ItemCell: UITableViewCell {
    let cellModel = CellViewModel()
    private lazy var cell = CellView(viewModel: cellModel)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let hostingView = UIHostingController(rootView: cell)
        self.addSubview(hostingView.view)
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false
        let c1 = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: hostingView.view, attribute: .leading, multiplier: 1, constant: 0)
        c1.isActive = true
        let c2 = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: hostingView.view, attribute: .bottom, multiplier: 1, constant: 0)
        c2.isActive = true
        let c3 = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: hostingView.view, attribute: .trailing, multiplier: 1, constant: 0)
        c3.isActive = true
        let c4 = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: hostingView.view, attribute: .top, multiplier: 1, constant: 0)
        c4.isActive = true
        self.addConstraints([c1, c2, c3, c4])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
