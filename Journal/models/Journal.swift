import Foundation
import SwiftData

@Model
final class Journal {
    var id: UUID
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool

    init(title: String, content: String, date: Date = Date(), isBookmarked: Bool = false) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.date = date
        self.isBookmarked = isBookmarked
    }
}
