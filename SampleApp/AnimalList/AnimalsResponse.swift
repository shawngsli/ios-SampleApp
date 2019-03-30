//
//  AnimalsResponse.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/30.
//  Copyright © 2019 shawnli. All rights reserved.
//

import Foundation

class AnimalsResponse: Decodable {
    let result: AnimalsResult
    
    struct AnimalsResult: Decodable {
        let results: [Animal]
    }
}
