//
//  FavoritesViewController.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tblRockets: UITableView!
    
    // MARK: - Properties
    var arrRockets = [TestModelElement]()
    
    // MARK: - Life Cyc
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites Rockets"
        setupTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(viewmodel.arrRockets)
        arrRockets = viewmodel.getFavRockets()
        self.tblRockets.reloadData()
    }
    
    // MARK: - Functions
    func setupTableview() {
        tblRockets.register(UINib(nibName: "RocketListCell", bundle: nil), forCellReuseIdentifier: "RocketListCell")
        tblRockets.dataSource = self
        tblRockets.delegate = self
        tblRockets.reloadData()
    }
    
    @objc func starButtonClicked(sender: UIButton) {
        print(sender.tag)
        viewmodel.addAndRemoveFav(model: arrRockets[sender.tag])
        arrRockets = viewmodel.getFavRockets()
        self.tblRockets.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrRockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RocketListCell") as? RocketListCell else { return .init() }
        let model = arrRockets[indexPath.row]
        cell.configCell(model: model)
        cell.btnStar.tag = indexPath.row
        
        if viewmodel.getFavRocketsIds().contains(model.flightNumber!) {
            cell.btnStar.isSelected = true
        } else {
            cell.btnStar.isSelected = false
        }
        cell.btnStar.addTarget(self, action: #selector(starButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rocketDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RocketDetailsVC") as? RocketDetailsVC else { return }
        rocketDetailsVC.selectedRocket = arrRockets[indexPath.row]
        rocketDetailsVC.index = indexPath.row
        self.navigationController?.pushViewController(rocketDetailsVC, animated: true)
    }
}
