//
//  AddItemView.swift
//  ShoppingList
//
//  Created by shashank on 28/03/21.
//

import SwiftUI

typealias OnComplete =  (Item)-> Void

struct AddItemView: View {
    var complition: OnComplete
    @State var text: String = ""
    var body: some View {
        VStack(spacing: 20) {
         
            TextField("Item Detail", text: $text)
                .foregroundColor(.black)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .frame(height: 50)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray)
                )
            Button(action: {
                complition(Item(item: text))
            }, label: {
                Capsule()
                    .fill(Color.blue)
                    .overlay(
                        Text("ADD")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    )
                    .frame(width: 200, height: 50)
                
            })
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal)
        
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(complition: { _ in
            
        })
            .preferredColorScheme(.dark)
            .ignoresSafeArea()
    }
}
