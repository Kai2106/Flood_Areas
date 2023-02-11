//
//  FloorArea.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import Foundation

struct FloodArea: Codable {
    var type: String?
    var lastPublished: Int?
    var layerName: String?
    var rights: Right?
}

struct Right: Codable {
    var copyright: String?
    var licence: String?
}
