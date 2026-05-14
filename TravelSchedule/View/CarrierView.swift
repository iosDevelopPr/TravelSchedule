
import SwiftUI

struct CarrierView: View {
    @EnvironmentObject private var viewModel: TravelViewModel
    
    private let textNotFound = "Вариантов нет"

    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack() {
                    Text(viewModel.getTitleCarrier())
                        .font(.bold24)
                    Spacer()
                }

                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                } else if !viewModel.filteredCarriersList.isEmpty {
                    ZStack(alignment: .bottom) {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.filteredCarriersList, id: \.self) { segment in
                                    CarrierCardView(segment: segment)
                                        .frame(height: 104)
                                        .onTapGesture {
                                            viewModel.addView(type: .carrierInfoView)
                                        }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        VStack {
                            Spacer()
                            Button {
                                viewModel.addView(type: .filtersView)
                            } label: {
                                HStack {
                                    Text("Уточнить время")
                                        .font(.bold17)
                                        .foregroundStyle(.trWhiteOnly)
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundStyle(viewModel.isFilter ? .trRedOnly : .trBlue)
                                }
                            }
                            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                            .background(.trBlue)
                            .clipShape(.rect(cornerRadius: 16))
                            .padding(.bottom, 8)
                        }
                    }
                } else {
                    Spacer()
                    Text(textNotFound)
                        .font(.bold24)
                }
                Spacer()
                    .toolbarRole(.editor)
            }
            .padding(16)
        }
    }
}

#Preview {
    CarrierView()
}
