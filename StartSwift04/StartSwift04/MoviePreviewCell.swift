//
//  MoviePreviewCell.swift
//  StartSwift04
//
//  Created by Winn on 2017/12/20.
//  Copyright © 2017年 Winn. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

extension MoviePreviewCell {
    
    func uploadUI() {
        guard let model = album else {
            return
        }
        
        iconImageView.sd_setImage(with: URL(string: model.image_url), placeholderImage: UIImage(named: "placeholder.png"))
        
        nameLabel.text = model.title
    }
}


class MoviePreviewCell: UITableViewCell {
    
    let iconImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()

    
    var album: MovieDetailModel? {
        didSet {
            uploadUI()
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            contentView.addSubview(iconImageView)
            contentView.addSubview(nameLabel)
            makeConstraints()
            
        }
    }
    
    func makeConstraints() {
        iconImageView.snp.makeConstraints { (maker) in
//             maker.edges.equalToSuperview().inset(UIEdgeInsetsMake(20, 0, 0, 0))
            
            maker.top.equalToSuperview().offset(30)
            maker.right.equalToSuperview()
            maker.left.equalToSuperview()
            maker.height.equalTo(contentView.snp.width)

        }
        
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(5)
            maker.right.equalToSuperview().offset(-10)
            maker.left.equalToSuperview().offset(10)
            maker.height.equalTo(18)
        }
        
    }
    

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
