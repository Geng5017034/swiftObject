//
//  ViewController.swift
//  swiftObject
//
//  Created by gengyongqiang on 17/2/8.
//  Copyright © 2017年 speedoflight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setViewModel(to: viewModel)

        
    }

    override func bindedViewModel() {
        super.bindedViewModel()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

