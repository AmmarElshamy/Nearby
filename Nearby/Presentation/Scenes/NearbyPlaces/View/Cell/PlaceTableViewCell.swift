//
//  PlaceTableViewCell.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import UIKit
import Kingfisher

class PlaceTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet var containerView: ShadowView!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var placeAddressLabel: UILabel!
    
    // MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        placeImageView.layer.cornerRadius = 8
        placeImageView.layer.masksToBounds = true
    }
    
    // MARK: Binding
    func bind(_ viewModel: PlaceCellViewModel) {
        placeNameLabel.text = viewModel.placeName
        placeAddressLabel.text = viewModel.placeAddress
        setImage(with: viewModel.placePhoto)
    }
    
    private func setImage(with urlString: String?) {
        let url = URL(string: urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        placeImageView.kf.setImage(with: url, placeholder: UIImage(named: "image_place_holder"))
    }
}
