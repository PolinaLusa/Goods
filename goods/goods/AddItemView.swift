//
//  AddItemView.swift
//  goods
//
//  Created by Полина Лущевская on 31.03.24.
//

import SwiftUI
import PhotosUI
struct AddItemView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""

    @State var pickerItem: PhotosPickerItem? = nil
    @State var imageData: Data? = nil
    
    let addAction: (MyGood) -> Void
    
    var body: some View {
        VStack {
            if imageData == nil {
                VStack{
                    PhotosPicker(selection: $pickerItem, matching: .images)
                        {
                            Label("Select a photo", systemImage: "photo")
                     }
                        .tint(.blue)
                        .controlSize(.large)
                        .buttonStyle(.borderedProminent)
                        .padding(.top,150)
                   }
                   
                .onChange(of: pickerItem) { newItem in
                    Task {
                        imageData = try await newItem?.loadTransferable(type: Data.self)
                    }
                }
            } else {
                Image(uiImage: UIImage(data: imageData!)!)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(.top)
                    .onTapGesture {
                        imageData = nil
                    }
            }
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            TextField("Price", text: $price)
            Button("Add") {
                addAction(MyGood(name: name, description: description, photoName: "", photoImg: imageData, price: price, isMyFavourite: true))
            }
            .padding()
        }
        .padding()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(addAction: { _ in })
    }
}
