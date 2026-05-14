
import SwiftUI

struct SettingsView: View {
    private let darkThemeString = "Темная тема"
    private let titleAgreement = "Пользовательское соглашение"
    private let apiString1 = "Приложение использует API «Яндекс.Расписания»"
    private let apiString2 = "Версия 1.0 (beta)"

    @EnvironmentObject private var viewModel: TravelViewModel
    @AppStorage(ApiParams.theme) private var isDarkModeOn = false
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            
            VStack {
                Toggle(darkThemeString, isOn: $isDarkModeOn)
                    .toggleStyle(SwitchToggleStyle(tint: .trBlue))
                    .frame(height: 60)
                HStack {
                    Text(titleAgreement)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .background(.trWhite)
                .frame(height: 60)
                .onTapGesture {
                    viewModel.addView(type: ViewType.agreementView)
                }
                Spacer()
                VStack(spacing: 16) {
                    Text(apiString1)
                    Text(apiString2)
                }
                .font(.regular12)
            }
            .foregroundStyle(.trBlack)
            .padding(24)
        }
    }
}

#Preview {
    SettingsView()
}
