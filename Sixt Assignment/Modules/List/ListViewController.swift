//
//  ListViewController.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import UIKit
import Kingfisher

protocol ListViewInput {
    func refreshView()
    
    func scrollTo(_ indexPath: IndexPath, _ animated: Bool)
}

protocol ListViewOutput {
    func setUpView()
    
    func numberOfSections() -> Int
    
    func numberOfItems(in section: Int) -> Int?
    
    func viewModelForIndexPath(for index: IndexPath) -> CarListViewModel?
    
    func signalVisibleItemChanged(to indexPath:IndexPath)
}

class ListViewController: UIViewController {

    // MARK:- Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter : ListViewOutput?
}

extension ListViewController {
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.setUpView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}



extension ListViewController: ListViewInput {
    func scrollTo(_ indexPath: IndexPath, _ animated: Bool) {
        self.collectionView.scrollToItem(at: indexPath, at: .left, animated: animated)
    }
    
    func refreshView() {
        self.collectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.numberOfItems(in: section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let vm = self.presenter?.viewModelForIndexPath(for: indexPath) {
            (cell as! ListCollectionViewCell).licensePlate.text = vm.licensePlateDisplay!
            (cell as! ListCollectionViewCell).nameLbl.text = vm.nameDisplay!
            (cell as! ListCollectionViewCell).makeLbl.text = vm.makeModelDisplay!
            (cell as! ListCollectionViewCell).txTypeLbl.text     = vm.txTypeDisplay!
            (cell as! ListCollectionViewCell).fuelTypeLbl.text     = vm.fuelTypeDisplay!
            (cell as! ListCollectionViewCell).fuelMeterLbl.text     = vm.fuelMeterDisplay!
            (cell as! ListCollectionViewCell).cleanlinessLbl.text     = vm.cleanlinessDisplay!
            (cell as! ListCollectionViewCell).imgView.kf.setImage(with: vm.imageUrl!, placeholder: Image(named: "car_placeholder"))
                    }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.bounds.size.width, height:180.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}

extension ListViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first else {
            return
        }
        self.presenter?.signalVisibleItemChanged(to: indexPath)
    }
}

