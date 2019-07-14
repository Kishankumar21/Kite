//
//  UserListViewController.swift
//  Kite
//
//  Created by kishan kumar on 13/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private struct Strings {
    static let title = "User List"
    static let url = "https://api.github.com/users"
    static let cellIdentifier = "UserCollectionViewCell"
    static let collectionViewNibName = "UserCollectionViewCell"
    static let storyBoardName = "Main"
    static let userDetailViewControllerIdentifier = "UserDetailViewController"
}

class UserListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    let viewModel = UserListViewModel()
    
    // MARK: UIViewController lifecycle method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.title
        collectionView.register(UINib(nibName: Strings.collectionViewNibName, bundle: nil),
                                forCellWithReuseIdentifier: Strings.cellIdentifier)
        
        NetworkHelper.getUserListFromURL(url: Strings.url) { [weak self] (json, error) in
            guard let json = json else { return }
            self?.viewModel.parseJsonData(json: json)
        }
        
        viewModel.usersSubject.bind(to:
            collectionView.rx.items(cellIdentifier: Strings.cellIdentifier,
                                    cellType: UserCollectionViewCell.self)) { (row, model, cell) in
                                        cell.configureCell(with: model)
            }.disposed(by: disposeBag)
        
        collectionView.rx
            .modelSelected(UserModel.self)
            .subscribe(onNext: { [weak self] model in
                let uiStoryboard = UIStoryboard(name: Strings.storyBoardName, bundle: nil)
                let vc = uiStoryboard.instantiateViewController(withIdentifier: Strings.userDetailViewControllerIdentifier)
                guard let viewController = vc as? UserDetailViewController else {
                    return
                }
                viewController.userUrl = model.userURL
                self?.navigationController?.pushViewController(vc, animated: false)
                
            })
            .disposed(by: disposeBag)
    }
}

