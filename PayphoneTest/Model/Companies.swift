//
//  Companies.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import Foundation
import RealmSwift

class Company: Object, Codable {
    @Persisted var name: String = ""
    @Persisted var catchPhrase: String = ""
    @Persisted var bs: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}
