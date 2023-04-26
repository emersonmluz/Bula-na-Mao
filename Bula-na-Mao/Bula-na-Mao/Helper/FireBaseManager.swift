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
    
    func saveUserData(data: [String: String], completion: @escaping((_: NSError?) -> Void)) {
        ref = dataBase.collection("users").addDocument(data: [
            "name": data["name"] ?? "name",
            "email": data["email"] ?? "email",
            "password": data["password"] ?? "password",
            "photo": data["photo"] ?? "photo"
        ]) { error in
            completion(error as NSError?)
        }
    }
}
