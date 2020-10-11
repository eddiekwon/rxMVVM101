
import Foundation
import RxSwift
import RxCocoa

final class CounterViewModel: ViewModelType {
  let disposeBag = DisposeBag()
  
  struct Input {
    var onPlus: Observable<Void>
    var onMinus: Observable<Void>
  }
  
  struct Output {
    var resultValue: Driver<Int>
  }
  
  func transform(input: Input) -> Output {
    let counted = BehaviorRelay(value: 0)
    input.onPlus
      .subscribe(onNext: { _ in
        counted.accept(counted.value + 1)
      }).disposed(by: disposeBag)
    
    input.onMinus
      .subscribe(onNext: { _ in
          counted.accept(counted.value - 2)
        }).disposed(by: disposeBag)
      
    return Output.init(resultValue: counted.asDriver(onErrorJustReturn: 0))
  }
  
}
 
