import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    private let toggleLabels = ["MaxTemp", "MinTemp", "Speed Wind", "Humidity", "Pressure", "Sunset"]
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Settings")
                    .bold()
                    .font(.title)
                    .padding()
                List {
                    ForEach(settingsManager.toggles.indices, id: \.self) { index in
                        Toggle(isOn: $settingsManager.toggles[index]) {
                            Text(toggleLabels[index])
                                .font(.headline)
                        }
                        .padding()
                        .background(ColorsManager.backgroundColor)
                        .cornerRadius(15)
                        .onChange(of: settingsManager.toggles[index]) { _ in
                            settingsManager.toggleDidChange(at: index)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorsManager.backgroundColor)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsManager())
    }
}
