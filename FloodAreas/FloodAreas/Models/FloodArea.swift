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
    var rights: Copyright?
    var features: [Feature]?
}

struct Copyright: Codable {
    var copyright: String?
    var licence: String?
}

struct Feature: Codable {
    var type: String?
    var id: Int?
    var geometry: Geometry?
    var properties: Property?
}

struct Geometry: Codable {
    var type: String?
    var coordinates: [Double]?
    var collections: [Collection]?
}

struct Collection: Codable {
    var type: String?
    var coordinates: [Double]?
}

struct Property: Codable {
    var speedLimit: Float?
    var adviceA: String?
    var adviceB: String?
    var adviceC: String?
    var otherAdvice: String?
    var diversions: String?
    var roads: [Road]?
}

struct Road: Codable {
    var mainStreet: String?
    var suburb: String?
}
