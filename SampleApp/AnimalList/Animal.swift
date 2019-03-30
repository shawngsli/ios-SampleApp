//
//  Animal.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/30.
//  Copyright © 2019 shawnli. All rights reserved.
//

import Foundation

class Animal: Decodable {
    let name: String
    let imageUrl: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case name = "A_Name_Ch"
        case imageUrl = "A_Pic01_URL"
        case description = "A_Interpretation"
    }
}
