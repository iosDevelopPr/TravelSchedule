
import SwiftUI

struct FiltersView: View {
    
    @EnvironmentObject private var viewModel: TravelViewModel
    @ObservedObject var searchSettings: SearchSettings
    
    private let timeDeparture = "Отправление"
    private let optionsTransfers = "Показывать варианты с пересадками"
    private let titleApply = "Применить"
    
    init(searchSettings: SearchSettings) {
        self.searchSettings = searchSettings
    }
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Text(timeDeparture)
                    .font(.bold24)
                
                VStack(alignment: .leading, spacing: 0) {
                    TimeIntervalView(isOn: $searchSettings.isMorning, timeInterval: .morning)
                    TimeIntervalView(isOn: $searchSettings.isAfternoon, timeInterval: .afternoon)
                    TimeIntervalView(isOn: $searchSettings.isEvening, timeInterval: .evening)
                    TimeIntervalView(isOn: $searchSettings.isNight, timeInterval: .night)
                }
                
                Text(optionsTransfers)
                    .font(.bold24)
                
                VStack(alignment: .leading, spacing: 0) {
                    RadioRowView(isHasTransfers: $searchSettings.isHasTransfers, hasTransfers: true)
                    RadioRowView(isHasTransfers: $searchSettings.isHasTransfers, hasTransfers: false)
                }
                
                Spacer()
                
                Button {
                    viewModel.setSearchSettings(searchSettings: searchSettings)
                    viewModel.stepBack()
                } label: {
                    Text(titleApply)
                        .padding()
                        .font(.bold17)
                        .foregroundStyle(.trWhiteOnly)
                }
                .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                .background(.trBlue)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.bottom, 24)
                .toolbarRole(.editor)
            }
            .padding(16)
        }
    }
}

#Preview {
    FiltersView(searchSettings: SearchSettings())
        .environmentObject(TravelViewModel())
}
