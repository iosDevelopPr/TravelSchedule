
import SwiftUI

struct CityView: View {
    @EnvironmentObject private var viewModel: TravelViewModel
    @State var cityName: String = ""
    private let direction: Direction
    
    var searchResults: [Settlement] {
        if cityName.isEmpty {
            return viewModel.settlements
        } else {
            return viewModel.settlements.filter {
                $0.title?.contains(cityName.capitalized) ?? false
            }
        }
    }
    
    private let titleView = "Выбор города"
    private let placeholder = "Введите запрос"
    private let textNotFound = "Город не найден"
    
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
                            TextField(placeholder, text: $cityName)
                                .font(.regular17)
                                .padding(.leading, 8)
                                .onAppear {
                                    cityName = viewModel.getNameSettlement(direction: direction)
                                }
                        }
                        .padding()
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        .overlay(alignment: .center) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                
                                Spacer()
                                
                                if cityName.count > 0 {
                                    Button(action: { cityName = "" }, label: {
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
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                } else if !searchResults.isEmpty {
                    
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(searchResults, id: \.self) { settlement in
                                ZStack {
                                    HStack {
                                        Text(settlement.title ?? "")
                                            .font(.regular17)
                                            .padding([.top, .bottom], 19)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .imageScale(.large)
                                    }
                                    .foregroundStyle(.trBlack)
                                }
                                .onTapGesture {
                                    switch direction {
                                    case .from:
                                        viewModel.addView(type: ViewType.fromStationView)
                                    case .to:
                                        viewModel.addView(type: ViewType.toStationView)
                                    }
                                    viewModel.setSettlement(settlement: settlement, direction: direction)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)

                } else {
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

//#Preview {
//    CityView(direction: .from)
//}
