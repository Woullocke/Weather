import SwiftUI

class SettingsManager: ObservableObject {
    @Published var toggles: [Bool] = Array(repeating: true, count: 6)
    init() {
        loadSettings()
    }
    func toggleDidChange(at index: Int) {
        objectWillChange.send()
        saveSettings()
    }
    private func saveSettings() {
        UserDefaults.standard.set(toggles, forKey: "toggleSettings")
    }
    private func loadSettings() {
        if let savedToggles = UserDefaults.standard.array(forKey: "toggleSettings") as? [Bool] {
            toggles = savedToggles
        }
    }
}
