//
//  ViewController.swift
//  Project10
//
//  Created by Edwin Cardenas on 2/14/23.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCVC else { fatalError("Unable to dequeue PersonCell") }
        
        cell.name.text = "\(indexPath.item)"
        
        return cell
    }

}

