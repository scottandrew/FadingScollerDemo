//
//  ContentView.swift
//  FadingScrollerDemo
//
//  Created by Scott Andrew on 10/5/22.
//

import Introspect
import SwiftUI

struct GalleryView: View {
    @State var images = [
        ImageEntry(imageName: "Image 1"),
        ImageEntry(imageName: "Image 2"),
        ImageEntry(imageName: "Image 3"),
        ImageEntry(imageName: "Image 4")
    ]

    @StateObject var backgroundCalculator = BackgroundCalculator()

    var body: some View {
        GeometryReader { g in
            ZStack {
                Rectangle().foregroundColor(backgroundCalculator.color)
                
                ScrollView(.horizontal) {
                    ZStack {
                        GeometryReader { proxy in
                            let offset = proxy.frame(in: .named("scroll")).minX
                            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                        }

                        LazyHStack(spacing: 0) {
                            ForEach(images) { image in
                                Image(uiImage: image.image)
                                    .resizable()
                                    .cornerRadius(15)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(24)
                                    .frame(width: g.size.width, height: g.size.height)
                            }
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
                .introspectScrollView { scrollView in
                    scrollView.isPagingEnabled = true
                }
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    backgroundCalculator.calucateBackground(position: value * -1)
                }
            }
            .onAppear {
                backgroundCalculator.width = g.size.width
                backgroundCalculator.colors = images.map { $0.color }
            }
        }
        .ignoresSafeArea()
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
