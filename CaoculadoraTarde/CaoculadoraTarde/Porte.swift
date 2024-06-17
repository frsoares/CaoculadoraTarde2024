//
//  Porte.swift
//  CaoculadoraTarde
//
//  Created by Francisco Miranda Soares on 10/05/24.
//

import Foundation

enum Porte: String, CaseIterable {
    case small = "Pequeno"
    case medium = "Médio"
    case large = "Grande"

    func conversaoDeIdade(anos: Int, meses: Int) -> Int {
        let result: Int
        let multiplicador: Int
        switch self {
        case .small:
            multiplicador = 6
        case .medium:
            multiplicador = 7
        case .large:
            multiplicador = 8
        }


        result = anos * multiplicador + meses * multiplicador / 24

        return result
    }
}
