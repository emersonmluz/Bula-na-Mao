//
//  RegisterLogic.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 25/04/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireBaseManager {
    private let dataBase = Firestore.firestore()
    private var ref: DocumentReference?
    static var shared = FireBaseManager()
    
    func authLogin(email: String, senha: String, completion: @escaping((_ title: String, _ message: String, _ actionTitle: String) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: senha) { authResult, error in
            guard error == nil else {
                completion("Falha", "Verifique se o e-mail digitado e a senha estão corretos ou tente novamente mais tarde.", "Entendi")
                return}
            completion("","","")
        }
    }
    
    func saveUserData(name: String, email: String, password: String, photo: String, completion: @escaping((_ titleMessage: String, _ message: String, _ actionTitle: String) -> Void)) {

        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            guard error == nil else {
                completion("Falha", "Esse e-mail já está em uso ou o sistema pode estar indisponível.", "Entendi")
                return}
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
}
