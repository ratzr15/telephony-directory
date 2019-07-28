//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ErrorView
//  Description      :   Err view for UI
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//---------------------------------------------------------------------------------------------------------------------------------------

import UIKit

final class ErrorView: UIView {

    override var isHidden: Bool {
        didSet {
            messageLabel.isHidden = isHidden
        }
    }
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
