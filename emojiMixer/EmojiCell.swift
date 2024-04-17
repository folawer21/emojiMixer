//
//  EmojiCell.swift
//  emojiMixer
//
//  Created by Александр  Сухинин on 17.04.2024.
//

import UIKit


final class EmojiCell: UICollectionViewCell{
    
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emojiLabel)
        contentView.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("required init(coder: NSCoder)")
    }
    
    
}
