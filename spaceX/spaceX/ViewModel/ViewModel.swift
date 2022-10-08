//
//  ViewModel.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import Foundation

// Global Property
var viewmodel = ViewModel()

class ViewModel {
    
    var arrRockets = [TestModelElement]()
    var arrUpcomingLaunches = [TestModelElement]()
    private var arrFavRockets = [TestModelElement]()
    
    func getRockets(success: @escaping ((TestModel)->()), fail: @escaping ((String)->())) {
        var req = URLRequest(url: URL(string: "https://api.spacexdata.com/v3/launches")!)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: req) { Data, Response, error in
            if error != nil {
                fail(error?.localizedDescription ?? "Error")
                return
            }
            guard let data = Data else {
                fail(error?.localizedDescription ?? "Error")
                return
            }
            do {
                let json = try JSONDecoder().decode(TestModel.self, from: data )
                print(json)
                self.arrRockets = json
                success(json)
            } catch let error {
                fail(error.localizedDescription)
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getUpcomingLaunches(success: @escaping ((TestModel)->()), fail: @escaping ((String)->())) {
        var req = URLRequest(url: URL(string: "https://api.spacexdata.com/v3/launches/upcoming")!)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: req) { Data, Response, error in
            if error != nil {
                fail(error?.localizedDescription ?? "Error")
                return
            }
            guard let data = Data else {
                fail(error?.localizedDescription ?? "Error")
                return
            }
            do {
                let json = try JSONDecoder().decode(TestModel.self, from: data )
                print(json)
                self.arrUpcomingLaunches = json
                success(json)
            } catch let error {
                fail(error.localizedDescription)
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func addAndRemoveFav(model: TestModelElement) {
        if arrFavRockets.count > 0{
            for i in arrFavRockets {
                if i.flightNumber == model.flightNumber {
                    if let idx = arrFavRockets.firstIndex(where: { $0.flightNumber == model.flightNumber }) {
                        arrFavRockets.remove(at: idx)
                    }
                } else {
                    arrFavRockets.append(model)
                }
            }
        } else {
            arrFavRockets.append(model)
        }

    }
    
    func getFavRockets() -> [TestModelElement] {
        return arrFavRockets
    }
    
    func getFavRocketsIds() -> [Int] {
        return arrFavRockets.map { model in
            return model.flightNumber!
        }
    }
}
