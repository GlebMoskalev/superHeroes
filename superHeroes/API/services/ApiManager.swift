//
//  ApiManager.swift
//  superHeroes
//
//  Created by Глеб Москалев on 29.04.2024.
//

import Foundation
import UIKit

class ApiManager{
    private lazy var baseUrl = "https://www.superheroapi.com/api.php/3af7d3fb5d3f18a9dcd19e43dd1430ae/"
    
    func getAllInfoForSuperheroe(id: Int) -> AllInfoSuperheroes? {
        let semaphore = DispatchSemaphore(value: 0)
        var infoSuperHero: AllInfoSuperheroes?
        let task = URLSession.shared.dataTask(with:  URL(string: baseUrl + String(id))!) { data, response, error in
            if let data = data, let allInfoSuperHero = try? JSONDecoder().decode(AllInfoSuperheroes.self, from: data){
                infoSuperHero = allInfoSuperHero
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return infoSuperHero
    }
    
    func getImage(id: Int, completion: @escaping (UIImage?) -> Void){
        guard let allInfoSuperHero = getAllInfoForSuperheroe(id: id) else {fatalError("failed to get information about superheroes id: \(id)")}
        if let imageUrl = URL(string: allInfoSuperHero.image.url){
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        } else{
            completion(nil)
        }
    }
}
