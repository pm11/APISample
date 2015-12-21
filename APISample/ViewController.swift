//
//  ViewController.swift
//  APISample
//
//  Created by shinichiro.todaka on 2015/12/18.
//
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainScheduler: SerialDispatchQueueScheduler = MainScheduler.sharedInstance
        let backgroundScheduler: OperationQueueScheduler = OperationQueueScheduler(operationQueue: NSOperationQueue())
        let request = FetchRepositoryRequest(userName: "pm11")
        button.rx_tap
            .subscribeOn(backgroundScheduler)
            .flatMap {
                return Session.rx_response(request)
            }
            .observeOn(mainScheduler)
            .subscribeNext { [unowned self] response in
                let r = response[0]
                self.resultLabel.text = "name: \(r.fullName!)\nurl: \(r.url!)\nicon: \(r.ownerAvaterUrl!)\nupdated_at: \(r.updatedAt!)"
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}