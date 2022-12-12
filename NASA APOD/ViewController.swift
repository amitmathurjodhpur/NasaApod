//
//  ViewController.swift
//  NASA APOD
//
//  Created by Amit Mathur on 12/12/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var galleryObjs: [NasaData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NASA Gallery"
        self.configureCollectionView()
        self.fetchGalleryData()
    }
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom:10, right: 5)
        layout.itemSize = CGSize(width: 110, height: 110)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func fetchGalleryData() {
        self.galleryObjs = DataManager.shared.dataObjs
        if self.galleryObjs.count > 0 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryObjs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCellIdentifier", for: indexPath) as? DataCollectionViewCell else { return UICollectionViewCell() }
        if let imageURL = self.galleryObjs[indexPath.item].url as String? {
            cell.imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let imageDetailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "imagedetailsVC") as? ImageDetailsViewController else { return }
        self.navigationController?.pushViewController(imageDetailsVC, animated: true)
    }
}
