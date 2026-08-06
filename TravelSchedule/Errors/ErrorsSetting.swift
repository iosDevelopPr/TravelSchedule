
import Foundation

final class ErrorsSetting: ObservableObject {
    // MARK: - Properties
    static let shared = ErrorsSetting()
    @Published var isError: ErrorsType?
    
    private init() {}
}
