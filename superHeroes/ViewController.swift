//
//  ViewController.swift
//  superHeroes
//
//  Created by Глеб Москалев on 29.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var pickerView: UIPickerView!
    var imageView: UIImageView!
    
    let nameIdDictionary = JSONDataManager.getNameIdDictionary()
    let publisherNamesDictionary = JSONDataManager.getPublisherNamesDictionary()
    let apiManager = ApiManager()
    let publishedArray = Array(JSONDataManager.getPublisherNamesDictionary().keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.setValuesForKeys(["textColor": UIColor.white])
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        imageView = UIImageView()
        view.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageView.bottomAnchor.constraint(equalTo: pickerView.topAnchor),
        ])
    }
}

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return publisherNamesDictionary.keys.count
        }
        let published = Array(publisherNamesDictionary.keys)[pickerView.selectedRow(inComponent: 0)]
        if let namesHeroes = publisherNamesDictionary[published]{
            return namesHeroes.count
        }
        return 0
    }
    
    
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return Array(publisherNamesDictionary.keys)[row]
        }
        let publish = publishedArray[pickerView.selectedRow(inComponent: 0)]
        if let namesHeroes = publisherNamesDictionary[publish]{
            return namesHeroes[row]
        }
        return " "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            pickerView.reloadComponent(1)
            let publish = publishedArray[pickerView.selectedRow(inComponent: 0)]
            if let namesHeroes = publisherNamesDictionary[publish], let id = nameIdDictionary[namesHeroes[0]]{
                apiManager.getImage(id: id) { image in
                    if let image = image {
                        self.imageView.image = image
                    } else{
                        print("Failed to load image \(id)")
                    }
                }
            }
            if component == 1{
                let publish = publishedArray[pickerView.selectedRow(inComponent: 0)]
                if let namesHeroes = publisherNamesDictionary[publish], let id = nameIdDictionary[namesHeroes[row]]{
                    apiManager.getImage(id: id) { image in
                        if let image = image {
                            self.imageView.image = image
                        } else{
                            print("Failed to load image \(id)")
                        }
                    }
                } else {
                    print("ошибка!!!")
                }
            }
        }
    }
}


