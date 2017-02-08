//
//  GYQViewModel.swift
//  seven
//
//  Created by gengyongqiang on 16/11/25.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit



class GYQViewModel: NSObject {


    weak var delegate:GYQViewModelBind?
    override init() {
        super.init()

    }

    func hiddenIndicator() -> Void {
        self.delegate?.gyq_hidden(animation: true)
    }

}

