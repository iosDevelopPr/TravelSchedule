
import SwiftUI

struct DestinationView: View {
    let text: String
    let placeholder: String
    
    init(settlement: String, station: String, placeholder: String) {
        if settlement == "".trimmingCharacters(in: .whitespacesAndNewlines) && station == "".trimmingCharacters(in: .whitespacesAndNewlines) {
            self.text = placeholder
        } else {
            self.text = settlement + " (\(station))"
        }
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.trWhiteOnly
            Text(text)
                .padding(.vertical, 14)
                .padding([.leading], 16)
                .lineLimit(1)
                .foregroundStyle(text != placeholder ? .trBlackOnly : .trGrayOnly)
        }
        .cornerRadius(20)
    }
}

#Preview {
    DestinationView(settlement: "Moscow", station: "??", placeholder: "Откуда")
}
