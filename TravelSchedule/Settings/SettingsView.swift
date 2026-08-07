
import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @AppStorage(ApiParams.theme) private var theme =
        UserDefaults.standard.bool(forKey: ApiParams.theme)
    @EnvironmentObject private var navigation: Navigation
    
    private let darkThemeString = "Темная тема"
    private let titleAgreement = "Пользовательское соглашение"
    private let apiString1 = "Приложение использует API «Яндекс.Расписания»"
    private let apiString2 = "Версия 1.0 (beta)"
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            
            VStack {
                Toggle(darkThemeString, isOn: $theme)
                    .toggleStyle(SwitchToggleStyle(tint: .trBlue))
                    .frame(height: 60)
                HStack {
                    Text(titleAgreement)
                    Spacer()
                    Image(system: .chevronRight)
                }
                .background(.trWhite)
                .frame(height: 60)
                .onTapGesture {
                    navigation.addView(type: .agreement)
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
