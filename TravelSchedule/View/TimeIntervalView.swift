
import SwiftUI

struct TimeIntervalView: View {
    
    @Binding var isOn: Bool
    let timeInterval: TimeInterval
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            HStack {
                Toggle(timeInterval.rawValue, isOn: $isOn)
                    .toggleStyle(SquareToggleStyle())
            }
            .foregroundStyle(.trBlack)
        }
        .frame(height: 60)
    }
}

struct SquareToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TimeIntervalView(isOn: .constant(false), timeInterval: .morning)
}
