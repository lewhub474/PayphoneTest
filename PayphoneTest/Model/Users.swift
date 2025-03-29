//
//  Users.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//
//

import Foundation
import RealmSwift

class User: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var email: String = ""
    @Persisted var phone: String = ""
    @Persisted var city: String = ""
    @Persisted var website: String = ""
    @Persisted var company: Company?  // Empresa del usuario, opcional por si es null en el JSON
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case address
        case website
        case company
    }
    
    enum AddressCodingKeys: String, CodingKey {
        case city
    }
    
    // Custom init para decodificar los valores anidados
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.website = try container.decode(String.self, forKey: .website)
        
        let addressContainer = try container.nestedContainer(keyedBy: AddressCodingKeys.self, forKey: .address)
        self.city = try addressContainer.decode(String.self, forKey: .city)

        self.company = try container.decodeIfPresent(Company.self, forKey: .company)
    }

    // Método para codificar (necesario para Codable)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(website, forKey: .website)

        var addressContainer = container.nestedContainer(keyedBy: AddressCodingKeys.self, forKey: .address)
        try addressContainer.encode(city, forKey: .city)

        try container.encodeIfPresent(company, forKey: .company)
    }
}

// Modelo para Company
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
