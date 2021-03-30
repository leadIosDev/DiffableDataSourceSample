//
//  DiffContainerView.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//

import SwiftUI

struct DiffContainerView: UIViewControllerRepresentable {
    var viewModel: HomeViewViewModel
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = DiffTableView(style: .insetGrouped)
        controller.viewModel = viewModel
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
     }
}
struct DiffContainerView_Previews: PreviewProvider {
    static var previews: some View {
        DiffContainerView(viewModel: HomeViewViewModel())
    }
}
