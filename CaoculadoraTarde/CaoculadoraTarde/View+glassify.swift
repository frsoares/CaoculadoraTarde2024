//
//  ContentView.swift
//  CaoculadoraTarde
//
//  Created by Francisco Miranda Soares on 05/11/25.
//

import SwiftUI

extension View {

    func glassify(
        in shape: some Shape = RoundedRectangle(
            cornerRadius: 10
        )
    ) -> some View {
        if #available(iOS 26.0, *) {
            return glassEffect(.regular.interactive(), in: shape)
        } else {
            return self
        }
    }
}
