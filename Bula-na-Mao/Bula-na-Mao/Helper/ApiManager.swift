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
    
    func fetchData(medicine: String, completion: @escaping(_: MedicineResponse?, _: NSError?) -> Void) {
        alamofireManager.request(self.url + medicine.uppercased()).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).response { response in
            switch response.result {
            case .success:
                guard let jsonData = response.data, response.error == nil else {return}
                do {
                    let response = try JSONDecoder().decode(MedicineResponse.self, from: jsonData)
                    completion(response, nil)
                } catch let error as NSError {
                    completion(nil, error)
                }
            case .failure:
                guard let error = response.error as? NSError else {return}
                completion(nil, error)
            }
        }
    }
}
