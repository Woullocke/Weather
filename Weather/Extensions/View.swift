import Foundation
import SwiftUI

// Закругление углов
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corner: corners) )
    }
}
