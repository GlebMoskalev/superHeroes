//
//  JSONDataManager.swift
//  superHeroes
//
//  Created by Глеб Москалев on 29.04.2024.
//

import Foundation

class JSONDataManager{
    static func getNameIdDictionary() -> [String: Int]{
        guard let filePath = Bundle.main.path(forResource: "name_id", ofType: "json") else {
               fatalError("Path not found")
           }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let nameIDs = try JSONDecoder().decode([NameIDJSON].self, from: jsonData)
            
            let nameIdDictionary = nameIDs.reduce(into: [String: Int]()) { result, nameId in
                result[nameId.name] = Int(nameId.id)
                
            }
            return nameIdDictionary
          } catch {
              fatalError("Error reading JSON file: \(error)")
          }
    }

    static func getPublisherNamesDictionary() -> [String: [String]]{
        guard let filePath = Bundle.main.path(forResource: "publisher", ofType: "json") else {
               fatalError("Path not found")
           }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let publisherNames = try JSONDecoder().decode([PublisherJSON].self, from: jsonData)
            
            let publisherNamesDictionary = publisherNames.reduce(into: [String: [String]]()) {result, publisherNames in
                result[publisherNames.publisher] = publisherNames.names
            }
            
            return publisherNamesDictionary
          } catch {
              fatalError("Error reading JSON file: \(error)")
          }
    }
}
