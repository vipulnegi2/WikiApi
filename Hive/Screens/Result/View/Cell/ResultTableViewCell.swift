//
//  ResultTableViewCell.swift
//  Hive
//
//  Created by Vipul Negi on 10/04/23.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureWidthConstraint: NSLayoutConstraint!

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: ResultCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            subTitleLabel.text = cellViewModel?.subTitle
            pictureView.downloaded(from: cellViewModel?.imageUrl ?? "")
            pictureWidthConstraint.constant = cellViewModel?.width ?? 0.0
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subTitleLabel.text = nil
        pictureView.image = nil
    }
    
}
