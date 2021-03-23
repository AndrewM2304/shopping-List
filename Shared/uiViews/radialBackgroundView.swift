//
//  radialBackgroundView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 20/03/2021.
//

import SwiftUI

struct radialBackgroundView: View {
    var body: some View {
        RadialGradient(gradient: Gradient(colors: [Color("radialBG1"), Color("radialBG2")]), center: UnitPoint(x: 0.5, y: 0.3), startRadius: 10, endRadius: 200)
        
    }
}

struct radialBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        radialBackgroundView()
    }
}
