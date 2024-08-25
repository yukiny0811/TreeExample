//
//  ColorExtension.swift
//  TreeExample
//
//  Created by Yuki Kuwashima on 2024/08/26.
//

import SwiftUI
import SwiftyCreatives

extension Color {
    var f3Value: f3 {
        guard let color = self.cgColor else {
            return f3.zero
        }
        guard let components = color.components else {
            return f3.zero
        }
        switch components.count {
        case 2:
            return f3(Float(components[0]), Float(components[0]), Float(components[0]))
        case 4:
            return f3(Float(components[0]), Float(components[1]), Float(components[2]))
        default:
            return f3.zero
        }
    }
}
