//
//  Webview.swift
//  ios-webview
//
//  Created by Luke-Surface-mac on 2024/10/10.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var message: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let contentController = WKUserContentController()
        contentController.add(context.coordinator, name: "callbackHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "callbackHandler", let messageBody = message.body as? String {
                parent.message = messageBody
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation?) {
            // 页面加载完成后执行 JavaScript 代码
            webView.evaluateJavaScript("handleNativeMessage('Hello from Native')", completionHandler: { result, error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("Result: \(result ?? "")")
                }
            })
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, url.scheme == "customeschemetest" {
                // 处理自定义URL Scheme
                if let host = url.host, let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems {
                    // 根据host和queryItems进行逻辑处理
                    print("Host: \(host), Query Items: \(queryItems)")
                    // 你可以在这里更新parent的message绑定变量
                    parent.message = "Received from H5: \(url.absoluteString)"
                }
                decisionHandler(.cancel)  // 取消导航，因为我们已经处理了这个URL
            } else {
                decisionHandler(.allow)  // 允许其他URL加载
            }
        }
    }
}
