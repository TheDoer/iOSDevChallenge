//
//  allUserParser.swift
//  TheiOSChallenge
//
//  Created by Adonis Rumbwere on 19/7/2021.
//

import Foundation

//struct Parser {
//
//    func fetchUserNames(completon: @escaping ([PurpleData]) -> Void){
//        let api = URL(string: ALL_USERS)
//
//        URLSession.shared.dataTask(with: api!) {
//            data, response, error in
//
//            if error != nil {
//                print("Error\(error?.localizedDescription)")
//                return
//            }
//            do {
//                let result = try JSONDecoder().decode([PurpleData].self, from: data!)
//                print(result)
//
//                completon(result)
//
//            } catch {
//                print("Didnt work")
//
//            }
//        }.resume()
//    }
//}
