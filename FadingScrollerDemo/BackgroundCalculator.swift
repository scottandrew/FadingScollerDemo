//
//  BackgroundCalculator.swift
//  FadingScrollerDemo
//
//  Created by Scott Andrew on 10/10/22.
//

import SwiftUI

class BackgroundCalculator: ObservableObject {
    @Published var color = Color.clear
    
    var width: CGFloat = 0
    var colors: [UIColor] = [] {
        didSet {
            let aColor = colors.count > 0 ? colors[0] : UIColor.clear
            color = Color(aColor)
        }
    }

    func calucateBackground(position: CGFloat) {
        guard width > 0, colors.count > 0 else {
            return
        }
        
        let fractionalPage = position / width
        let page = Int(fractionalPage)
        let fromColor: UIColor = colors[page]
        
         if fractionalPage > 0 && fractionalPage < CGFloat(colors.count - 1) {
             let nextPage = min(page + 1, colors.count - 1)
             let transitionPercentage = fractionalPage.truncatingRemainder(dividingBy: 1)

             color = Color(fromColor.interpolate(to: colors[nextPage], percentage: transitionPercentage))
        }
        else {
            color = Color(fromColor)
        }
    }
}
