//
//  deviceIdentifiers.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/04/2021.
//

import SwiftUI

extension UIDevice {
var hasNotch: Bool {
let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
return bottom > 0
}
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
