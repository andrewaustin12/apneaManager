import Foundation
import SwiftData

@Model
final class Session: Identifiable, Hashable, Codable {
    var id: UUID
    var date: Date
    var image: String
    var sessionType: SessionType
    var duration: Int // Duration in seconds
    var tableData: String?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        image: String,
        sessionType: SessionType,
        duration: Int,
        tableData: String? = nil
    ) {
        self.id = id
        self.date = date
        self.image = image
        self.sessionType = sessionType
        self.duration = duration
        self.tableData = tableData
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        image = try container.decode(String.self, forKey: .image)
        sessionType = try container.decode(SessionType.self, forKey: .sessionType)
        duration = try container.decode(Int.self, forKey: .duration)
        tableData = try container.decodeIfPresent(String.self, forKey: .tableData)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }

    private enum CodingKeys: String, CodingKey {
        case id, date, image, sessionType, duration, tableData
    }

    var o2Table: [Cycle]? {
        guard sessionType == .O2Table, let data = tableData?.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode([Cycle].self, from: data)
    }
}

struct Cycle: Codable, Identifiable {
    var id = UUID()
    var hold: Int
    var rest: Int
}

extension Session {
    enum SessionType: String, CaseIterable, Codable {
        case breathHold = "Breath Hold"
        case prebreathe = "Pre Breathe"
        case O2Table = "O2 Table"
        case Co2Table = "Co2 Table"
        case squareBreath = "Square Breath"
        case pranayama = "Pranayama"
    }
}

extension Session {
    static func longestSessionByType(sessions: [Session]) -> Session? {
        return sessions
            .sorted {
                if $0.sessionType == $1.sessionType {
                    return $0.duration > $1.duration
                }
                return $0.sessionType.rawValue < $1.sessionType.rawValue
            }
            .first
    }
}

extension Session {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(image, forKey: .image)
        try container.encode(sessionType, forKey: .sessionType)
        try container.encode(duration, forKey: .duration)
        try container.encodeIfPresent(tableData, forKey: .tableData)
    }
}
