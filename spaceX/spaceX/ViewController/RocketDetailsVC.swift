//
//  RocketDetailsVC.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import UIKit
import Kingfisher

class RocketDetailsVC: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var clvImages: UICollectionView!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblNoImage: UILabel!
    
    @IBOutlet weak var lblnationality: UILabel!
    @IBOutlet weak var lblmanufacturer: UILabel!
    @IBOutlet weak var lblpayload_type: UILabel!
    @IBOutlet weak var lblpayload_mass_kg: UILabel!
    @IBOutlet weak var lblpayload_mass_lbs: UILabel!
    
    // MARK: - Properties
    var selectedRocket: TestModelElement?
    var index: Int!
    var isHideStar = false
    let HARIZONTAL_SPCE_IMAGE: CGFloat          = 0
    let VERTICAL_SPCE_IMAGE: CGFloat            = 0
    
    // MARK: - Life Cyc
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = selectedRocket?.rocket?.rocketName ?? ""
        setupClvview()
        setupUI()
    }
    
    // MARK: - Functions
    func setupUI() {
        let imgCount = self.selectedRocket?.links?.flickrImages?.count ?? 0
        lblNoImage.isHidden = imgCount > 0 ? true : false
        btnStar.isHidden = isHideStar
        if viewmodel.getFavRocketsIds().contains((selectedRocket?.flightNumber!)!) {
            btnStar.isSelected = true
        } else {
            btnStar.isSelected = false
        }
        lblDesc.text = selectedRocket?.details ?? ""
        if let payload = selectedRocket?.rocket?.secondStage?.payloads?.first {
            lblnationality.text = payload.nationality ?? ""
            lblmanufacturer.text = payload.manufacturer ?? ""
            lblpayload_type.text = payload.payloadType ?? ""
            lblpayload_mass_kg.text =  String(payload.payloadMassKg ?? 0.0)
            lblpayload_mass_lbs.text = String(payload.payloadMassLbs ?? 0.0)
        }
    }
    
    func setupClvview() {
        clvImages.register(UINib(nibName: "RocketImageCell", bundle: nil), forCellWithReuseIdentifier: "RocketImageCell")
        clvImages.isPagingEnabled = true
        clvImages.dataSource = self
        clvImages.delegate = self
        clvImages.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction func onBtnStarClick(_ sender: UIButton) {
        viewmodel.addAndRemoveFav(model: selectedRocket!)
        if viewmodel.getFavRocketsIds().contains((selectedRocket?.flightNumber!)!) {
            btnStar.isSelected = true
        } else {
            btnStar.isSelected = false
        }
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RocketDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedRocket?.links?.flickrImages?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketImageCell", for: indexPath) as? RocketImageCell else {
            return UICollectionViewCell()
        }
        let url = URL(string: self.selectedRocket?.links?.flickrImages?[indexPath.row] ?? "")
        cell.imgRocket.kf.setImage(with: url, placeholder: UIImage(named: "ic_rocket"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RocketDetailsVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return HARIZONTAL_SPCE_IMAGE }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return VERTICAL_SPCE_IMAGE }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: clvImages.frame.width, height: clvImages.frame.height)
    }

}
