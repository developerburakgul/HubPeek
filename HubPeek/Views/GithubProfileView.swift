//
//  GithubProfileView.swift
//  denemeUI
//
//  Created by Burak Gül on 2.04.2024.
//

import SwiftUI


struct GithubProfileView: View {
    
    var follower: Follower
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            WebView(urlString: follower.html_url ?? "", isLoading: $isLoading)
                .edgesIgnoringSafeArea(.all)
            if isLoading {
                ProgressView()
            }
        }
    }
}


#Preview {
    GithubProfileView(follower: Follower(login: "Burak"))
}



