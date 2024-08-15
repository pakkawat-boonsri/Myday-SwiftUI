//
//  FontName.swift
//  Core
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 23/8/2565 BE.
//

import Foundation
import SwiftUI

enum FontName: String {
    case bold = "IBMPlexSansThai-Bold"
    case extraLight = "IBMPlexSansThai-ExtraLight"
    case light = "IBMPlexSansThai-Light"
    case medium = "IBMPlexSansThai-Medium"
    case regular = "IBMPlexSansThai-Regular"
    case semiBold = "IBMPlexSansThai-SemiBold"
    case thin = "IBMPlexSansThai-Thin"
}

struct Fonts: ViewModifier{
    var fontName: FontName
    var size: CGFloat
    public func body(content: Content) -> some View {
        content.font(.custom(fontName.rawValue, size: size))
    }
}
