//
//  UserDetailViewController.swift
//  Kite
//
//  Created by kishan kumar on 14/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import UIKit
import RxSwift

class UserDetailViewController:UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var modifiedOnLabel: UILabel!
    
    var userUrl = ""
    let viewModel = UserViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: UIViewController lifecycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User"
        subscribeTheViewModel()
        
        NetworkHelper.getUserFromURL(url: userUrl) { [weak self] (json, error) in
            self?.viewModel.parseJsonData(json: json)
        }
    }
    
    // MARK: Private method
    
    private func subscribeTheViewModel() {
        Observable.zip(viewModel.idSubject,
                       viewModel.nameSubject,
                       viewModel.emailSubject,
                       viewModel.createdOnSubject,
                       viewModel.modifiedOnSubject)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (id, name, email, createdOn, modifiedOn) in
                self!.idLabel.text = id
                self?.nameLabel.text = name
                self?.emailLabel.text = email
                self?.createdOnLabel.text = createdOn
                self?.modifiedOnLabel.text = modifiedOn
            })
            .disposed(by: disposeBag)
        
        viewModel.imageSubject.observeOn(MainScheduler.instance).subscribe(onNext:  { [weak self] image in
            self?.userImage.image = image
        }).disposed(by: disposeBag)
    }
    
}
