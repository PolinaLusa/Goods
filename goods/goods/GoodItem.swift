//
//  GoodItem.swift
//  goods
//
//  Created by Полина Лущевская on 18.03.24.
//

import SwiftUI

struct GoodItem: View {
    @Binding var currentGood: MyGood
    
    var body: some View {
        VStack{
            Image(uiImage: UIImage(data: currentGood.photoImg ?? Data()) ?? UIImage())
                .resizable()
                .frame(width: 350, height: 350)
            Text(currentGood.name)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
            Text(currentGood.price)
                .foregroundColor(.gray)
                    .bold()
            Text(currentGood.description)
                    .font(.system(size: 19))
                    .foregroundColor(.black)
            Spacer()
            
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(5)
        .padding(2)
        .cornerRadius(9)
        .padding([.leading,.trailing],5)
        .id(currentGood.id)
    }
}


#Preview {
    GoodItem(currentGood: .constant(MyGood(name: "Xiaomi 12X", description: "Secure style. Durable, accessible, color options.", photoName: "Xiaomi12X", photoImg: UIImage(named: "Xiaomi12X")?.jpegData(compressionQuality: 1.0), price: "1500$",  isMyFavourite: false)))
}
