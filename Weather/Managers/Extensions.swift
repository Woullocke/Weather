//
//  Extensions.swift
//  Weather
//
//  Created by Иван Булгаков on 2.7.2024.
//
import Foundation
import SwiftUI


// Конвертация и округление
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

// Закругление углов
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape (RoundedCorner (radius: radius, corner: corners) )
    }
}

struct RoundedCorner: Shape{
    var radius: CGFloat = .infinity
    var corner: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

