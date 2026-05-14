
import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var viewModel: TravelViewModel
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                ZStack {
                    Color.trBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            DestinationView(
                                settlement: viewModel.getNameSettlement(direction: .from) ,
                                station: viewModel.getNameStation(direction: .from),
                                placeholder: "Откуда"
                            )
                            .onTapGesture {
                                viewModel.addView(type: .fromCityView)
                            }
                            
                            DestinationView(
                                settlement: viewModel.getNameSettlement(direction: .to),
                                station: viewModel.getNameStation(direction: .to),
                                placeholder: "Куда"
                            )
                            .onTapGesture {
                                viewModel.addView(type: .toCityView)
                            }
                        }
                        .frame(height: 96)
                        .font(.regular17)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                        )
                        
                        Button {
                            viewModel.changeDirection()
                        } label: {
                            Image(.change)
                                .frame(width: 36, height: 36)
                                .background(.white)
                                .cornerRadius(40)
                        }
                    }
                    .padding(16)
                }
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .frame(height: 128)
                
                Button {
                    viewModel.isLoading = true
                    Task {
                        await viewModel.searchCarrier()
                    }
                    viewModel.addView(type: .carrierView)
                } label: {
                    Text("Найти")
                        .font(.bold17)
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 60)
                        .background(.trBlue)
                        .cornerRadius(16)
                }
                .opacity(viewModel.getSearchEnable() ? 1 : 0)
            }
        }
    }
}

#Preview {
    ScheduleView()
}
