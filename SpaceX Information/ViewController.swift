//
//  ViewController.swift
//  SpaceX Information
//
//  Created by Michael Filippini on 7/10/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var newsPanelsView: UICollectionView!
    
    let query = "https://api.spacexdata.com/v2/launches"
    var missions = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsPanelsView.dataSource = self
        newsPanelsView.delegate = self
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["error"] != "No results found" {
                    self.parse(json: json)
                    print(self.missions)
                    return
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func parse(json: JSON){
        for result in json[].arrayValue{
            let missionName = result["mission_name"].stringValue
            let rocketNum = result["flight_number"].stringValue
            let rocket = result["rocket"]
            let rocketType = rocket["rocket_name"].stringValue
            let details = result["details"].stringValue
            let mission = ["rocketNum":rocketNum, "missionName":missionName, "rocketType":rocketType, "details":details]
            missions.append(mission)
        }
        self.newsPanelsView.reloadData()
    }
    
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem the latest SpaceX launches",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        print(missions.count)
        print("\n\n")
        return missions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsPanelsView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewsCell
        cell.rocketNumber.text = "Flight No. \( (missions[indexPath.item])["rocketNum"]  ?? "ERROR")"
        cell.missionNameLabel.text = (missions[indexPath.item])["missionName"]
        cell.rocketTypeLabel.text = (missions[indexPath.item])["rocketType"]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailView", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "detailView"
        {
            let indexPath = sender as! IndexPath
            let dvc = segue.destination as! DetailView
            dvc.details = (missions[indexPath.item])["details"]!
        }
        
    }
    
}

