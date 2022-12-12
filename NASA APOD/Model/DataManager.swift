//
//  DataManager.swift
//  NASA APOD
//
//  Created by Amit Mathur on 12/12/22.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var dataObjs: [NasaData] = []
    var currentSelectedImageIndex: Int?
    //Initializer access level change now
    private init() {
        
    }
    
    func configureGalleryData() {
        let jsonData = readLocalJSONFile(forName: "data")
        if let data = jsonData {
            if let responseObjs = parse(jsonData: data) as [NasaData]? {
                self.dataObjs = responseObjs.sorted(by: {($0.date).compare($1.date) == .orderedAscending })
            }
        }
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [NasaData]? {
        do {
            let decodedData = try JSONDecoder().decode(Array<NasaData>.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
