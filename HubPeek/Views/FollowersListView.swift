//
//  FollowersScreenView.swift
//  denemeUI
//
//  Created by Burak Gül on 2.04.2024.
//

import SwiftUI

struct FollowersListView: View {
    var username: String
    @State private var followers: [Follower] = []
    @State private var isLoading = false
    
    var body: some View {
        List(followers, id: \.login) { follower in
            NavigationLink(destination: GithubProfileView(follower: follower)) {
                FollowerCellView(name: follower.login, imageURL: follower.avatar_url ?? "")
            }
            
        }.onAppear {
            loadFollowers()
        }
        .navigationTitle("Followers")
        // .navigationBarTitleDisplayMode(.inline) kullanabilirsiniz eğer başlık çok büyükse ve navigasyon çubuğunda daha iyi görünmesini istiyorsanız.
    }
    
    func loadFollowers() {
        isLoading = true
        NetworkManager.shared.fetchFollowers(for: username) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let followers):
                    self.followers = followers
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}



// Bu yapıyı çalıştırabilmeniz için, `Follower` modelinizin `Identifiable` protokolünü uyguladığından ve `GithubProfileView` ile `FollowerCellView` bileşenlerinizin tanımlı olduğundan emin olun.


#Preview {
    FollowersListView(username: "developerburakgul")
}
