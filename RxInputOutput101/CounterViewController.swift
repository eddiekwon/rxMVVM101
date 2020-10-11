//
//  ViewController.swift
//  RxInputOutput101
//
//  Created by muzna on 2020/10/11.
//  Copyright © 2020 eddie. All rights reserved.
//

import UIKit
import RxSwift

class CounterViewController: UIViewController {

  @IBOutlet var countLabel: UILabel!
  @IBOutlet var plusButton: UIButton!
  @IBOutlet var subtractButton: UIButton!
  
  var disposeBag = DisposeBag()
  var viewModel = CounterViewModel()
  
  private lazy var input = CounterViewModel.Input(onPlus: plusButton.rx.tap.asObservable(), onMinus: subtractButton.rx.tap.asObservable())
  
  private lazy var output = viewModel.transform(input: input)
  
  override func viewDidLoad() {
      super.viewDidLoad()
      bindViewModel()
  }
  
  private func bindViewModel() {
    
    output.resultValue
      .map { String($0) }
      .drive(countLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

