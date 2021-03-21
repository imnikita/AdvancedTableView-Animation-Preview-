//
//  CardCell.swift
//  AdvancedTableView
//
//  Created by Nikita Popov on 21.03.2021.
//

import UIKit

class CardCell: UITableViewCell {
    
    
    var cellData: CellData? {
        didSet{
            guard let cellData = cellData else { return }
            featureImageView.image = cellData.image
            titleLabel.text = cellData.title
            
        }
    }
    
    private let featureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 2
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        
        return lable
    }()
    
    private let infoText: UITextView = {
        let infoText = UITextView()
        infoText.translatesAutoresizingMaskIntoConstraints = false
        infoText.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        infoText.isEditable = false
        infoText.backgroundColor = .clear
        infoText.text = "This is some test text from the infoText propertie of CardCell class."
        
        return infoText
    }()
    
    private var imageHeightClosed: NSLayoutConstraint!
    private var imageHeightOpen: NSLayoutConstraint!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        contentView.addSubview(featureImageView)
        featureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        featureImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        featureImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        imageHeightOpen = featureImageView.heightAnchor.constraint(equalToConstant: 140)
        imageHeightClosed = featureImageView.heightAnchor.constraint(equalToConstant: 20)
        
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: featureImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        contentView.addSubview(infoText)
        infoText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -4).isActive = true
        infoText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        infoText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        
    }
    
    func animate() {
        imageHeightOpen.isActive = false
        imageHeightClosed.isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.imageHeightClosed.isActive = false
            self.imageHeightOpen.isActive = true
            
            UIView.animate(withDuration: 0.3, delay: 0.15, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
        
    }
    
    
}
