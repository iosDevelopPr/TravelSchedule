
import SwiftUI

enum ErrorsType: Error {
    case serverError
    case connectionError
}

extension ErrorsType {
    
    var title: String {
        switch self {
        case .serverError:
            return "Ошибка сервера"
        case .connectionError:
            return "Нет интернета"
        }
    }
    
    var image: UIImage {
        switch self {
        case .serverError:
            return .serverError
        case .connectionError:
            return .internetError
        }
    }
}
