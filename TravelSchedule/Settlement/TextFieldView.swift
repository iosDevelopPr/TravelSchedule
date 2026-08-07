
import SwiftUI

struct TextFieldView: View {
    // MARK: - Properties
    @Binding var findName: String
    private let placeholder = "Введите запрос"
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack {
                    TextField(placeholder, text: $findName)
                        .font(.regular17)
                        .padding(.leading, 8)
                }
                .padding()
                .cornerRadius(16)
                .padding(.horizontal)
                
                .overlay(alignment: .center) {
                    HStack {
                        Image(system: .magnifyingGlass)
                            .resizable()
                            .frame(width: 17, height: 17)
                        
                        Spacer()
                        
                        if findName.count > 0 {
                            Button {
                                findName = ""
                            } label: {
                                Image(system: .closeButton)
                                    .foregroundStyle(.trGrayOnly)
                                    .padding(.vertical)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .foregroundColor(.trGrayOnly)
                }
            }
            .frame(height: 36)
            .background(.trSearchForeground)
            .cornerRadius(10)
        }
        .frame(height: 36)
        .padding(.horizontal, 16)
    }
}

#Preview {
    TextFieldView(findName: .constant(""))
}
