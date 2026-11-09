//
//  theme.swift
//  Journal
//
//  Created by ghaida on 29/05/1448 AH.
//

import Foundation
import SwiftUI

enum Theme {

    // MARK: - 01 Colors
    enum Colors {
        static let primaryAccent   = Color(hex: "7F81FF") // أزرار الحفظ والإجراءات النشطة
        static let textAccent      = Color(hex: "AF99FD") // عناوين اليوميات وعنوان Empty State
        static let textPrimary     = Color(hex: "FFFFFF") // العناوين الرئيسية ونص اليومية
        static let textSecondary   = Color(hex: "A39A9A") // تواريخ اليوميات
        static let surfaceCard     = Color(hex: "1C1C1E") // كروت اليوميات
        static let backgroundMain  = Color(hex: "000000") // خلفية الشاشة
        static let destructive     = Color(hex: "FD453C") // الحذف
    }

    // MARK: - 02 Typography (SF Pro)
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
    }

    // MARK: - 03 Icons (SF Symbols)
    enum Icons {
        static let close          = "xmark"
        static let bookmark       = "bookmark"
        static let bookmarkFilled = "bookmark.fill"
        static let trash          = "trash.fill"
        static let checkmark      = "checkmark"
        static let plus           = "plus"
        static let filter         = "line.3.horizontal.decrease"
    }

    // MARK: - المسافات والزوايا (مب موجودة بالتصميم، تقريبية)
    enum Spacing {
        static let small: CGFloat  = 6
        static let medium: CGFloat = 12
        static let large: CGFloat  = 16
    }

    enum Radius {
        static let card: CGFloat = 16
    }
}
