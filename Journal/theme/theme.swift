import SwiftUI

enum Theme {

    // MARK: - Colors
    enum Colors {
        static let primaryAccent = Color(hex: "7F81FF")
        static let textAccent    = Color(hex: "AF99FD")
        static let surfaceCard   = Color(hex: "1C1C1E")
        static let destructive   = Color(hex: "FD453C")
    }

    // MARK: - Images
    enum Images {
        static let emptyState = "journal-notepad"
    }

    // MARK: - Spacing
    enum Spacing {
        static let small: CGFloat  = 6
        static let medium: CGFloat = 12
        static let large: CGFloat  = 16
    }

    // MARK: - Radius
    enum Radius {
        static let card: CGFloat = 16
    }
}
