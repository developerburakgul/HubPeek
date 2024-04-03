//
//  FollowerCellView.swift
//  denemeUI
//
//  Created by Burak Gül on 2.04.2024.
//

import SwiftUI

struct FollowerCellView: View {
    var name: String
    var imageURL: String

    var body: some View {
        HStack {
            // Profil resmini gösteren Image View
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            // Kullanıcı adını gösteren Text View
            Text(name)
                .font(.system(size: 20))

            Spacer() // İçeriği ekranın soluna hizalı tutmak için
        }
    }
}

// Önizleme için SwiftUI Preview Provider


#Preview {
    FollowerCellView(name: "Burak", imageURL: "https://avatars.githubusercontent.com/u/83167665?v=4")
}
