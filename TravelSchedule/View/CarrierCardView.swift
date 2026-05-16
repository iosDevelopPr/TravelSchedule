
import SwiftUI

struct CarrierCardView: View {
    @EnvironmentObject private var viewModel: TravelViewModel
    
    private let segment: Segment
    
    @State var startDate: String = ""
    @State var departureTime: String = ""
    @State var travelTime: String = ""
    @State var arrivalTime: String = ""
    
    private let notInfo = "Информации нет"
    
    init(segment: Segment) {
        self.segment = segment
    }
    
    var body: some View {
        ZStack {
            Color.trLightGray
            VStack(spacing: 14) {
                HStack(alignment: .top, spacing: 18) {
                    AsyncImage(url: URL(string: segment.thread?.carrier?.logo ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(.trNoIcon)
                                .font(.largeTitle)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            Image(.trNoIcon)
                                .font(.largeTitle)
                        }
                    }
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading) {
                        Text(segment.thread?.carrier?.title ?? notInfo)
                            .font(.regular17)
                        Text("С пересадкой в: \(segment.transfers?.first?.title ?? "")")
                            .font(.regular12)
                            .foregroundStyle(.trRedOnly)
                            .lineLimit(2)
                            .opacity(segment.has_transfers ?? false ? 1 : 0)
                    }
                    Spacer()
                    Text(startDate)
                        .font(.regular12)
                        .onAppear {
                            startDate = viewModel.startDate(date: segment.start_date)
                        }
                }
                .foregroundStyle(.trBlackOnly)
                
                HStack {
                    Text(departureTime)
                        .font(.regular17)
                        .onAppear {
                            departureTime = viewModel.departureTime(date: segment.departure)
                        }
                    VStack {
                        Divider()
                            .frame(height: 1)
                            .overlay(.trGrayOnly)
                    }
                    Text(travelTime)
                        .font(.regular12)
                        .onAppear {
                            travelTime = viewModel.travelTime(intervalTime: segment.duration)
                        }
                    VStack {
                        Divider()
                            .frame(height: 1)
                            .overlay(.trGrayOnly)
                    }
                    Text(arrivalTime)
                        .font(.regular17)
                        .onAppear {
                            arrivalTime = viewModel.arrivalTime(date: segment.arrival)
                        }
                }
                .foregroundStyle(.trBlackOnly)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    CarrierCardView(segment: Segment())
        .environmentObject(TravelViewModel())
}
