/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a rotated version of a badge symbol.
*/

import SwiftUI

struct RotatedBadgeSymbol: View {
    let angle: Angle

    /*
    BadgeSymbol()：
    创建一个 BadgeSymbol 视图。
    
    .padding(-60)：
    使用负的 padding 值来缩小视图的大小。负的 padding 值会使视图的内容向内收缩。
    
    .rotationEffect(angle, anchor: .bottom)：
    将 BadgeSymbol 视图旋转 angle 指定的角度。
    旋转的中心点是视图的底部（.bottom）。
    */
    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}

#Preview {
    RotatedBadgeSymbol(angle: Angle(degrees: 5))
}
