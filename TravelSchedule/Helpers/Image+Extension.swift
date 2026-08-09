
import SwiftUI

enum ImageString: String {
    case chevronRight = "chevron.right"
    case closeButton = "xmark.circle.fill"
    case magnifyingGlass = "magnifyingglass"
    case checkmarkSquareFill = "checkmark.square.fill"
    case square
    case largeCircleFillCircle = "largecircle.fill.circle"
    case circle
    case photo
}

extension Image {
    init(system: ImageString) {
        self.init(systemName: system.rawValue)
    }
}
