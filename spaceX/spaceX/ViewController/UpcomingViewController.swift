//
//  UpcomingViewController.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import UIKit

class UpcomingViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblRockets: UITableView!
    
    // MARK: - Properties
    var arrRockets = [TestModelElement]()
    
    // MARK: - Life Cyc
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        setupTableview()
        ApiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblRockets.reloadData()
    }
    
    // MARK: - Functions
    func setupTableview() {
        tblRockets.register(UINib(nibName: "RocketListCell", bundle: nil), forCellReuseIdentifier: "RocketListCell")
        tblRockets.dataSource = self
        tblRockets.delegate = self
        tblRockets.reloadData()
    }
    
    func ApiCall() {
        showActivityIndicatory()
        viewmodel.getUpcomingLaunches { arrRocket in
            print(arrRocket)
            self.arrRockets = arrRocket
            DispatchQueue.main.async {
                self.hideActivityIndicatory()
                self.tblRockets.reloadData()
            }
        } fail: { msg in
            DispatchQueue.main.async {
                self.hideActivityIndicatory()
            }
            self.showErrorAlert(msg)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension UpcomingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrRockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RocketListCell") as? RocketListCell else { return .init() }
        let model = arrRockets[indexPath.row]
        cell.configCell(model: model)
        cell.btnStar.tag = indexPath.row
        cell.btnStar.isHidden = true
//        if viewmodel.getFavRocketsIds().contains(model.flightNumber!) {
//            cell.btnStar.isSelected = true
//        } else {
//            cell.btnStar.isSelected = false
//        }
//        cell.btnStar.addTarget(self, action: #selector(starButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rocketDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RocketDetailsVC") as? RocketDetailsVC else { return }
        rocketDetailsVC.selectedRocket = arrRockets[indexPath.row]
        rocketDetailsVC.index = indexPath.row
        rocketDetailsVC.isHideStar = true
        self.navigationController?.pushViewController(rocketDetailsVC, animated: true)
    }
}
