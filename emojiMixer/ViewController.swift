//
//  ViewController.swift
//  emojiMixer
//
//  Created by Александр  Сухинин on 17.04.2024.
//

import UIKit

final class ViewController: UIViewController {
 
    
    let emojes = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    private var visibleEmojes = [String]()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var undoBarItem = UIBarButtonItem(title: "undo", style: .plain, target: self, action: #selector(undoButtonTapped))
        undoBarItem.tintColor = .blue
        var addBarItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addBarItem.tintColor = .blue
        
        navigationItem.leftBarButtonItem = undoBarItem
        navigationItem.rightBarButtonItem = addBarItem
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "emoji")
        
        view.addSubview(collectionView)
        
        activateConstaraits()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func activateConstaraits(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func add(emoji: String){
        guard visibleEmojes.count < emojes.count else {return }
        visibleEmojes.append(emoji)
        
        collectionView.performBatchUpdates{
            let index = IndexPath(row: visibleEmojes.count - 1 , section: 0)
            collectionView.insertItems(at: [index])
        }
        
    }
    
    private func undo(){
        guard visibleEmojes.count > 0 else {return }
        let index = visibleEmojes.count - 1
        visibleEmojes.removeLast()
        
        collectionView.performBatchUpdates{
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    @objc private func undoButtonTapped(){
        undo()
    }
    
    @objc private func addButtonTapped(){
        let emoji = emojes[Int.random(in: 0..<emojes.count)]
        add(emoji: emoji)
        
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleEmojes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emoji", for: indexPath) as? EmojiCell else {
            return UICollectionViewCell()
        }
        
        cell.emojiLabel.text = emojes[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 2.5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
