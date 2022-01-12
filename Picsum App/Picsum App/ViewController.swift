//
//  ViewController.swift
//  Picsum App
//
//  Created by Matthew Gray on 1/12/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "pictureCell"
    var items: [PicsumModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        PicsumInteractor.shared.retrieveImages(limit: 8) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                self.items = responseModel
                self.reload()
            case .failure(_):
                self.items = [] // expand on error state here
                self.reload()
            }
        }
    }

    func reload() {
        collectionView.reloadData()
    }
    
    // Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PicsumCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.downloaded(from: item.download_url)
        cell.label.text = item.author
        
        return cell
    }
}

