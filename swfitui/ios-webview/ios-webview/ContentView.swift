//
//  ContentView.swift
//  ios-webview
//
//  Created by Luke-Surface-mac on 2024/10/10.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String?
    var body: some View {
        VStack {
            /*
             if let message = message 这一行代码的意思是：
             检查 message 是否为 nil。
             如果 message 不是 nil，则将其解包并赋值给一个新的常量 message。
             如果 message 是 nil，则跳过 if 语句块中的代码。
             */
            if let message = message {
                Text("Received from H5: \(message)")
            }
            
            /*
             WebView 是一个自定义的视图组件，用于加载网页。url 参数是一个强制解包的 URL 对象，message 参数是一个双向绑定的可选字符串，$ 符号用于获取一个 Binding 类型的值。$message 表示 message 的双向绑定。
                 WebVeiw组件中，通过`@Binding`注解实现了双向绑定
             */
            WebView(url: URL(string: "http://127.0.0.1:8091/")!, message: $message)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
