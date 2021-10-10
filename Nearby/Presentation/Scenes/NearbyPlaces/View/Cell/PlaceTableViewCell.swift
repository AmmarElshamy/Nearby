//
//  PlaceTableViewCell.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import UIKit

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
    }
    
    // MARK: Binding
    func bind(_ viewModel: PlaceCellViewModel) {
        placeNameLabel.text = viewModel.placeName
        placeAddressLabel.text = viewModel.placeAddress
    }
}
