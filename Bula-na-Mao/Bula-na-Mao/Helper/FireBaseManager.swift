//
//  RegisterLogic.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 25/04/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager {
    private let dataBase = Firestore.firestore()
    private var refDoc: DocumentReference?
    static var shared = FirebaseManager()
    
    func authLogin(email: String, senha: String, completion: @escaping((_ title: String, _ message: String, _ actionTitle: String) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: senha) { authResult, error in
            guard error == nil else {
                completion("Falha", "Algo deu errado, tente novamente mais tarde.", "Entendi")
                return}
            completion("","","")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
    
    func getUserDocument(completion: @escaping(([String: Any]) -> Void)) {
        let _: Void = dataBase.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments() { (querySnapshot, error) in
            guard error == nil else {return}
            for document in querySnapshot!.documents {
                completion(document.data())
            }
        }
    }
    
    func updateUser(name: String, email: String, password: String, photo: String, rememberLogin: Bool = false) {
        refDoc = dataBase.collection("users").document(name.lowercased())
        guard let ref = refDoc else {return}
        ref.setData([
            "name": name,
            "email": email.lowercased(),
            "password": password.lowercased(),
            "photo": photo,
            "rememberLogin": rememberLogin
        ])
    }
    
    func createUser(name: String, email: String, password: String, photo: String, completion: @escaping((_ titleMessage: String, _ message: String, _ actionTitle: String) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            guard error == nil else {
                completion("Falha", "Esse e-mail já está em uso ou o sistema pode estar indisponível.", "Entendi")
                return}
            refDoc = dataBase.collection("users").document(name.lowercased())
            guard let ref = refDoc else {return}
            ref.setData([
                "name": name,
                "email": email.lowercased(),
                "password": password.lowercased(),
                "photo": photo,
                "rememberLogin": false
            ]) { error in
                guard error == nil else {
                    completion("Ops!", "Parece que algo deu errado, tente novamente mais tarde.", "Retornar")
                    return}
                completion("Sucesso", "Registro realizado com sucesso.", "Retornar")
            }
        }
        
    }
}
