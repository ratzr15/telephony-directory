//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   LoadingView
//  Description      :   Loader view for UI
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//---------------------------------------------------------------------------------------------------------------------------------------

import UIKit
import SnapKit

final class LoadingView: UIView {

    override var isHidden: Bool {
        didSet {
            isHidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
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
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
