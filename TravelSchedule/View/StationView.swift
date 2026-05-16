
import SwiftUI

struct StationView: View {
    @EnvironmentObject private var viewModel: TravelViewModel
    @State private var stationName: String = ""
    private let direction: Direction
    
    private let titleView = "Выбор станции"
    private let placeholder = "Введите запрос"
    private let textNotFound = "Станция не найдена"

    var searchResults: [Station] {
        if stationName.isEmpty {
            return viewModel.stations
        } else {
            return viewModel.stations.filter {
                $0.title?.contains(stationName.capitalized) ?? false
            }
        }
    }

    init(direction: Direction) {
        self.direction = direction
    }
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        HStack {
                            TextField(placeholder, text: $stationName)
                                .font(.regular17)
                                .padding(.leading, 8)
                        }
                        .padding()
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .onTapGesture {}

                        .overlay(alignment: .center) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                
                                Spacer()
                                
                                if stationName.count > 0 {
                                    Button(action: { stationName = "" }, label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.trGrayOnly)
                                            .padding(.vertical)
                                    })
                                }
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(.gray)
                        }
                    }
                    .frame(height: 36)
                    .background(.trSearchForeground)
                    .cornerRadius(10)
                }
                .frame(height: 36)
                .padding(.horizontal, 16)
                
                if !searchResults.isEmpty {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(searchResults, id: \.self) { station in
                                ZStack {
                                    HStack {
                                        Text(station.title ?? "")
                                            .font(.regular17)
                                            .padding([.top, .bottom], 19)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .imageScale(.large)
                                    }
                                    .foregroundStyle(.trBlack)
                                }
                                .onTapGesture {
                                    viewModel.setStation(station: station, direction: direction)
                                    viewModel.stepToRoot()
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                } else if stationName.isEmpty {
                    Spacer()
                    Text(textNotFound)
                        .font(.bold24)
                }
                Spacer()
                    .navigationTitle(titleView)
                    .toolbarRole(.editor)
            }
        }
    }
}

#Preview {
    StationView(direction: .from)
        .environmentObject(TravelViewModel())
}
