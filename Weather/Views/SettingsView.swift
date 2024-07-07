import SwiftUI

struct SettingsView: View {
    @State var toggles: [Bool] = Array(repeating: true, count: 6)
    private let toggleLabels = ["MaxTemp", "MinTemp", "Speed", "Wind", "Pressure", "Sunset"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .bold().font(.title)
                .padding()

            ForEach(0..<toggles.count, id: \.self) { index in
                Toggle(isOn: $toggles[index]) {
                    Text(toggleLabels[index])
                        .font(.headline)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorsManager.backgroundColor)
    }
}

#Preview {
    SettingsView(toggles: Array(repeating: true, count: 6))
}
