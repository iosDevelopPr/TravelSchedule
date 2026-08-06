
enum Direction {
    case from
    case to
    
    var placeholder: String {
        switch self {
        case .from:
            return "Откуда"
        case .to:
            return "Куда"
        }
    }
}
