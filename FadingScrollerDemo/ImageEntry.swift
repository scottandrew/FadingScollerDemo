//
//  ImageEntry.swift
//  FadingScrollerDemo
//
//  Created by Scott Andrew on 10/10/22.
//

import UIKit

struct ImageEntry: Identifiable {
    let image: UIImage
    let id: UUID
    let color: UIColor
    
    init(imageName: String) {
        image = UIImage(named: imageName)!
        color = image.findAverageColor() ?? .clear
        id = UUID()
    }
}
