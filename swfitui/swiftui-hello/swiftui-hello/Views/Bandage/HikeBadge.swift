/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a badge for hiking.
*/

import SwiftUI

struct HikeBadge: View {
    var name: String

    var body: some View {
        /*
         第一次 frame 修饰符：
         .frame(width: 300, height: 300) 设置 Badge 视图的布局大小为 300x300。
         
         scaleEffect 修饰符：
         .scaleEffect(1.0 / 3.0) 将 Badge 视图的内容缩放到原来的 1/3。
         经过 scaleEffect(1.0 / 3.0) 之后，内容会被缩放到 100x100，但视图本身的布局大小仍然是 300x300。
         
         第二次 frame 修饰符：
         .frame(width: 100, height: 100) 将 Badge 视图的布局大小重新设置为 100x100。
         */
        VStack(alignment: .center) {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
        }
    }
}

#Preview {
    HikeBadge(name: "Preview Testing")
}
