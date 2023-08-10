//
//  CustomModifier.swift
//  WeatherAsync
//
//  Created by Uri on 10/8/23.
//

import Foundation
import SwiftUI

struct CustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .symbolRenderingMode(.multicolor)
            .foregroundColor(.white)
    }
}
