//
//  SNSFeedView.swift
//  Alarming
//
//  Created by Jae Heo on 18/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import UIKit

class SNSFeedView: UIView {
    private let xibName = "SNSFeedView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
