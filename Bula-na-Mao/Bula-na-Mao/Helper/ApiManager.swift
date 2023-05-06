//
//  ApiManager.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 02/05/23.
//

import Foundation
import Alamofire

class ApiManager {
    private let alamofireManager = Alamofire.Session()
    private var url = "https://bula.vercel.app/pesquisar?nome="
    static var shared = ApiManager()
    
    func fetchData(medicine: String, completion: @escaping(_: MedicineResponse?, _: String?) -> Void) {
        alamofireManager.request(self.url + medicine.uppercased()).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).response { response in
            switch response.result {
            case .success:
                guard let jsonData = response.data, response.error == nil else {return}
                do {
                    let response = try JSONDecoder().decode(MedicineResponse.self, from: jsonData)
                    completion(response, nil)
                } catch {
                    completion(nil, "Algo deu errado, tente novamente mais tarde.")
                }
            case .failure:
                if response.response?.statusCode == 504 {
                    completion(nil, "Falha na conexão.")
                } else {
                   completion(nil, "Falha ao buscar dados.")
                }
            }
        }
    }
}
