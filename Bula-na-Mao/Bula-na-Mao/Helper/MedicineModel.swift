//
//  MedicineModel.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 02/05/23.
//

import Foundation

struct MedicineModel: Decodable {
    var id: String
    var name: String
    var laboratory: String
    var cnpj: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idBulaPacienteProtegido"
        case name = "nomeProduto"
        case laboratory = "razaoSocial"
        case cnpj
    }
}
