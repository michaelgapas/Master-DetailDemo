//
//  UIView+Custom.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/17/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//



import UIKit
extension UIView {
    
    func makeRoundedCornerViews(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
