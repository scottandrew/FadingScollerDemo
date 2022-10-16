//
//  ScrollViewOffsetPreferenceKey                         .swift
//  FadingScrollerDemo
//
//  Created by Scott Andrew on 10/10/22.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
