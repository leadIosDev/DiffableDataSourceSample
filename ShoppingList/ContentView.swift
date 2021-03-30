//
//  ContentView.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .ignoresSafeArea()
    }
}


struct Home: View {
    @State var showAddItemView: Bool = false
    @StateObject var viewModel = HomeViewViewModel()
    var body: some View {
        DiffContainerView(viewModel: viewModel)
            .sheet(isPresented: $showAddItemView, content: {
                NavigationView {
                    AddItemView(complition: { item in
                        self.showAddItemView = false
                        self.viewModel.addNewItem(item: item)
                    })
                    .navigationTitle("Add Item")
                }
            })
            .navigationTitle("Shopping List")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showAddItemView = true
                    }, label: {
                        Text("Add")
                    })
            )
    }
}

