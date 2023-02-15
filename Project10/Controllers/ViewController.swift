//
//  ViewController.swift
//  Project10
//
//  Created by Edwin Cardenas on 2/14/23.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else { fatalError("Unable to dequeue PersonCell") }
        
        let person = people[indexPath.item]
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        
        cell.name.text = person.name
        cell.imageView.image = UIImage(contentsOfFile: path.path(percentEncoded: true))
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.borderColor = UIColor(white: 0, alpha: 0.9).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak person, weak ac] _ in
            guard let personName = ac?.textFields?[0].text else { return }
            
            person?.name = personName
            
            self?.collectionView.reloadData()
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        
        people.append(person)
        
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
