//
//  FirstScreenView.swift
//  denemeUI
//
//  Created by Burak Gül on 2.04.2024.
//

import SwiftUI


import SwiftUI

struct FirstScreenView: View {
    @State private var username: String = ""

    var body: some View {
        NavigationView {
            VStack {

                Image("search")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom,40)

                TextField("Enter a username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal,40)
                    .padding(.bottom,50)

                // Bu kısımda doğrudan NavigationLink kullanılıyor
                NavigationLink(destination: FollowersListView(username: username)) { // Hedef sayfa SecondScreenView() olmalı
                    Text("Get Followers")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.hubPeek) // Burada renk .hubPeek yerine örnek olarak .blue kullanılmıştır.
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(username.isEmpty) // Kullanıcı adı boşsa butonu devre dışı bırak
                .padding(.horizontal,40)
                .frame(height: 50)

                Spacer(minLength: 20)
            }
        }
    }
}








#Preview {
    FirstScreenView()
}
