//
//  RegisterLogic.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 25/04/23.
//

import Foundation
import FirebaseFirestore

class FireBaseManager {
    private let dataBase = Firestore.firestore()
    private var ref: DocumentReference?
    static var shared = FireBaseManager()
    
    func saveUserData(name: String, email: String, password: String, photo: String, completion: @escaping((_ titleMessage: String, _ message: String, _ actionTitle: String) -> Void)) {
        ref = dataBase.collection("users").addDocument(data: [
            "name": name,
            "email": email.lowercased(),
            "password": password.lowercased(),
            "photo": photo
        ]) { error in
            guard error == nil else {
                completion("Ops!", "Parece que algo deu errado, tente novamente mais tarde.", "Retornar")
                return}
            completion("Sucesso", "Registro realizado com sucesso.", "Retornar")
        }
    }
}
