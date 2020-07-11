//
//  DataManager.swift
//  UserDetails
//
//  Created by Ayush Suri on 11/07/20.
//  Copyright © 2020 Ayush Suri. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdateData(_ dataManager : DataManager, data: Welcome)
    func didFailWithError(error : Error)
}

struct DataManager {
    
    let urlString = "https://jsonplaceholder.typicode.com/users"
    var delegate : DataManagerDelegate?
    
    func fetchData() {
        performRequest(with : urlString)
    }
    
    func performRequest(with url: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let dataUser = self.parseJSON(safeData){
                        self.delegate?.didUpdateData(self, data: dataUser)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func parseJSON(_ userData : Data) -> Welcome? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Welcome.self, from: userData)
//            let id = decodedData[0].id
//            let name = decodedData[0].name
//            let email = decodedData.
//            let phone = decodedData.phone
//            let city = decodedData.address.city
//            let street = decodedData.address.street
//            let suite = decodedData.address.suite
//            let zipcode = decodedData.address.zipcode
//            let lat = decodedData.address.geo.lat
//            let lng = decodedData.address.geo.lng
//            
//            let geo = GeoModel(lat: lat, lng: lng)
//            let address = AddressModel(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo)
//            let uData = UserModel(id: id, name: name, email: email, address: address, phone: phone)
//            return uData
            return decodedData
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
