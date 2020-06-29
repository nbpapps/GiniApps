//
//  LowOrangeCollectionViewCell.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

final class LowOrangeCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "LowOrangeCollectionViewCell"
    
    let textLabel = NBPLabel(textAlignment: .center, fontSize: 20.0, weight: .regular, color: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("no storyboard")
    }
    
    private func configure() {
        self.backgroundColor = .orange
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupCell(with text : String) {
        textLabel.text = text
    }
}
