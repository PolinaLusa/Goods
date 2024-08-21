//
//  ContentView.swift
//  goods
//
//  Created by Полина Лущевская on 18.03.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var goods = [
        MyGood(name: "Xiaomi 12X", description: "Secure style. Durable, accessible, color options.", photoName: "Xiaomi12X", photoImg: UIImage(named: "Xiaomi12X")?.jpegData(compressionQuality: 1.0), price: "$59", isMyFavourite: true),
        MyGood(name: "Xiaomi 13", description: "Fashionably strong. Easy access, diverse color selection.", photoName: "Xiaomi13", photoImg: UIImage(named: "Xiaomi13")?.jpegData(compressionQuality: 1.0), price: "$1599",  isMyFavourite: true),
        MyGood(name: "Xiaomi A3", description: "Compact and convenient. Keep your essentials close at hand.", photoName: "XiaomiA3", photoImg: UIImage(named: "XiaomiA3")?.jpegData(compressionQuality: 1.0), price: "$429", isMyFavourite: true),
        MyGood(name: "Car", description: "New brand car from Xiaomi. Comfortable seats. Explore roads with your family and friends.", photoName: "Car",photoImg: UIImage(named: "Car")?.jpegData(compressionQuality: 1.0), price: "$249999", isMyFavourite: true),
        MyGood(name: "Watch", description: "Bright display with different options of color and apps.Choose any app u want and place it on your watch.", photoName: "Watch",photoImg: UIImage(named: "Watch")?.jpegData(compressionQuality: 1.0), price: "$549", isMyFavourite: true)
    ]
    @State var showGoods = true
    @State var showOthers = true
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isAddItemViewPresented = false
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("Fav Goods", isExpanded: $showGoods) {
                    ForEach($goods.filter { $0.wrappedValue.isMyFavourite }) { $currentGood in
                        NavigationLink(destination: GoodItem(currentGood: $currentGood)) {
                            HStack {
                                Image(uiImage: UIImage(data: $currentGood.wrappedValue.photoImg ?? Data()) ?? UIImage())
                                    .resizable()
                                    .frame(width: 63, height: 63)
                                VStack(alignment: .leading){
                                    Text($currentGood.wrappedValue.name)
                                    Text(currentGood.price)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                ZStack {
                                    Image(systemName: currentGood.isMyFavourite ? "heart.fill" : "heart")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color("Blue"))
                                        .onTapGesture {
                                            currentGood.isMyFavourite.toggle()
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteFavGoods)
                }
                
                
                Section("Non fav goods", isExpanded: $showOthers) {
                    ForEach($goods.filter { !$0.wrappedValue.isMyFavourite }) { $currentGood in
                        NavigationLink(destination: GoodItem(currentGood: $currentGood)) {
                            HStack {
                                Image(uiImage: UIImage(data: $currentGood.wrappedValue.photoImg ?? Data()) ?? UIImage())
                                    .resizable()
                                    .frame(width: 63, height: 63)
                                VStack(alignment: .leading){
                                    Text($currentGood.wrappedValue.name)
                                    Text(currentGood.price)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                ZStack {
                                    Image(systemName: currentGood.isMyFavourite ? "heart.fill" : "heart")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color("Blue"))
                                        .onTapGesture {
                                            currentGood.isMyFavourite.toggle()
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteNonFavGoods)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        isAddItemViewPresented = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        detail: {
            Text("Select a good")
        }
        .sheet(isPresented: $isAddItemViewPresented) {
            AddItemView(addAction: { newItem in
                self.goods.insert(newItem, at: 0)
                self.isAddItemViewPresented = false
            })
        }
    }

    private func deleteFavGoods(at offsets: IndexSet) {
        for offset in offsets {
            let favGoods = goods.filter { $0.isMyFavourite }
            if offset < favGoods.count {
                let index = goods.firstIndex(where: { $0.id == favGoods[offset].id }) ?? 0
                goods.remove(at: index)
            }
        }
    }

    private func deleteNonFavGoods(at offsets: IndexSet) {
        for offset in offsets {
            let nonFavGoods = goods.filter { !$0.isMyFavourite }
            if offset < nonFavGoods.count {
                let index = goods.firstIndex(where: { $0.id == nonFavGoods[offset].id }) ?? 0
                goods.remove(at: index)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
