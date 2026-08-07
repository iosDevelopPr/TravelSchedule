
import SwiftUI

struct SettlementView: View {
    // MARK: - Properties
    @EnvironmentObject private var stationListViewModel: StationListViewModel
    @State var cityName: String = ""
    
    private let direction: Direction
    
    private let title = "Выбор города"
    private let textNotFound = "Город не найден"
    
    var settlementsIsLoading: Bool {
        stationListViewModel.isLoading
    }
    
    var settlementsListNotEmpty: Bool {
        stationListViewModel.isSettlementsNotEmpty()
    }
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack {
                TextFieldView(findName: $cityName)
                
                if settlementsIsLoading {
                    Spacer()
                    ProgressView()
                } else if settlementsListNotEmpty {
                    SettlementContentView(direction: direction, findName: $cityName)
                } else {
                    Spacer()
                    Text(textNotFound)
                        .font(.bold24)
                }
                
                Spacer()
                
            }
        }
        .navigationTitle(title)
        .toolbarRole(.editor)
    }
}

#Preview {
    SettlementView(direction: .from)
}
