

import SwiftUI

struct DestinationView: View {
    // MARK: - Properties
    @EnvironmentObject private var stationViewModel: StationViewModel
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .leading) {
            Color.trWhiteOnly
            Text(name)
                .padding(.vertical, 14)
                .padding(.leading, 13)
                .padding(.trailing, 16)
                .lineLimit(1)
                .foregroundStyle(color)
        }
        .cornerRadius(20)
    }
    
    private var name: String {
        stationViewModel.getNameDestination(direction: direction)
    }
    
    private var color: Color {
        name != direction.placeholder ? .trBlackOnly : .trGrayOnly
    }
}
