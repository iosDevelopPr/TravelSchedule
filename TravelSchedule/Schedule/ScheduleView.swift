
import SwiftUI

struct ScheduleView: View {
    // MARK: - Properties
    @EnvironmentObject private var stationViewModel: StationViewModel
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel
    @EnvironmentObject private var navigation: Navigation
    
    @StateObject private var stories = StoriesViewModel()
    @State private var showStory: Bool = false
    
    private let titleFind = "Найти"
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(spacing: 24) {
                StoriesView(showStory: $showStory)
                    .environmentObject(stories)
                
                ZStack {
                    Color.trBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 0) {
                            DestinationView(direction: .from)
                                .onTapGesture {
                                    navigation.addView(type: .fromCity)
                                }
                            DestinationView(direction: .to)
                                .onTapGesture {
                                    navigation.addView(type: .toCity)
                                }
                        }
                        .frame(height: 96)
                        .font(.regular17)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.trWhiteOnly)
                        )
                        
                        Button {
                            stationViewModel.changeDirection()
                        } label: {
                            Image(.change)
                                .frame(width: 36, height: 36)
                                .background(.trWhiteOnly)
                                .clipShape(.rect(cornerRadius: 40))
                        }
                    }
                    .padding(16)
                }
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal, 16)
                .frame(height: 128)
                
                Button {
                    carriersViewModel.setStations(stationModel: stationViewModel)
                    navigation.addView(type: .carrier)
                } label: {
                    Text(titleFind)
                        .font(.bold17)
                        .foregroundStyle(.trWhiteOnly)
                        .frame(width: 150, height: 60)
                        .background(.trBlue)
                        .clipShape(.rect(cornerRadius: 16))
                }
                .opacity(stationViewModel.getSearchEnable() ? 1 : 0)
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showStory) {
            StoryView()
                .environmentObject(stories)
        }
    }
}

#Preview {
    ScheduleView()
}
