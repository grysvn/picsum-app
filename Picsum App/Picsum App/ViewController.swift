//
//  ViewController.swift
//  Picsum App
//
//  Created by Matthew Gray on 1/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    let reuseIdentifier = "pictureCell"
    var items: [PicsumModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PicsumInteractor.shared.retrieveImages(limit: 100) { [weak self] result in
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
        
    }
}

