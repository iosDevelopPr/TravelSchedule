
import SwiftUI

struct ErrorsView: View {
    private let image: UIImage
    private let title: String
    
    init(error: ErrorsType) {
        switch error {
        case .connectionError:
            title = "Нет интернета"
            image = .internetError
        case .serverError:
            title = "Ошибка сервера"
            image = .serverError
        }
    }
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                Image(uiImage: image)
                Text(title)
                    .font(.bold24)
            }
        }
    }
}

#Preview {
    ErrorsView(error: .connectionError)
}
