//
//  MedicineModel.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 02/05/23.
//

import Foundation

struct MedicineModel: Codable {
    var id: String
    var name: String
    var laboratory: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idBulaPacienteProtegido"
        case name = "nomeProduto"
        case laboratory = "razaoSocial"
    }
}
