//
//  WebView.swift
//  denemeUI
//
//  Created by Burak Gül on 2.04.2024.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    let urlString: String
    @Binding var isLoading: Bool // Yükleme durumunu takip edecek değişken

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator // Yükleme durumunu takip etmek için
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ webView: WebView) {
            self.parent = webView
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }

        // Yükleme sırasında hata oluşursa
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }

        // İlk yükleme sırasında hata oluşursa
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }
    }

}


//#Preview {
//
////    WebView(urlString: "https://github.com/developerburakgul", isLoading: $true)
//}
