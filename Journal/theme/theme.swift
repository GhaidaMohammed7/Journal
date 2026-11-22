import SwiftUI

enum Theme {

    // MARK: - Colors
    enum Colors {
        static let primaryAccent  = Color(hex: "7F81FF")
        static let textAccent     = Color(hex: "AF99FD")
        static let textPrimary    = Color(hex: "FFFFFF")
        static let textSecondary  = Color(hex: "A39A9A")
        static let surfaceCard    = Color(hex: "1C1C1E")
        static let backgroundMain = Color(hex: "000000")
        static let destructive    = Color(hex: "FD453C")
    }

    // MARK: - Fonts (SF Pro)
    enum Fonts {
        static let display        = Font.system(size: 42, weight: .black)
        static let headingL       = Font.system(size: 34, weight: .bold)
        static let headingM       = Font.system(size: 24, weight: .bold)
        static let titleCard      = Font.system(size: 24, weight: .semibold)
        static let bodyL          = Font.system(size: 20, weight: .regular)
        static let bodyM          = Font.system(size: 18, weight: .regular)
        static let bodySupporting = Font.system(size: 18, weight: .light)
        static let captionM       = Font.system(size: 16, weight: .regular)
        static let captionS       = Font.system(size: 14, weight: .regular)
        static let emptyTitle     = Font.system(size: 24, weight: .bold)
        static let emptyBody      = Font.system(size: 18, weight: .regular)
    }

    // MARK: - Icons (SF Symbols)
    enum Icons {
        static let close          = "xmark"
        static let bookmark       = "bookmark"
        static let bookmarkFilled = "bookmark.fill"
        static let trash          = "trash.fill"
        static let checkmark      = "checkmark"
        static let plus           = "plus"
        static let filter         = "line.3.horizontal.decrease"
        static let search         = "magnifyingglass"
        static let mic            = "mic.fill"
    }

    // MARK: - Images
    enum Images {
        static let emptyState = "journal-notepad"
        static let splashLogo = "JournalLogo"
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
