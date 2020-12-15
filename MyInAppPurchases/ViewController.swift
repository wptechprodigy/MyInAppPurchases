//
//  ViewController.swift
//  MyInAppPurchases
//
//  Created by waheedCodes on 15/12/2020.
//

import StoreFrontKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
    }
    
    func createButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .systemGreen
        button.setTitle("Upgrade", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.size.width,
                                          height: view.frame.size.width))
        
        let imageView = UIImageView(image: UIImage(named: "header"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        header.clipsToBounds = true
        header.addSubview(imageView)
        let storeViewController = SFKMultiNonConsumableViewController(
            with: [
                .nonConsumable(
                    productID: "com.example.premium",
                    viewModel: StoreFrontProductViewModel(
                        icon: UIImage(systemName: "crown"),
                        iconTintColor: .systemPink)
                ),
                .nonConsumable(
                    productID: "com.example.gold",
                    viewModel: StoreFrontProductViewModel(
                        icon: UIImage(systemName: "star"),
                        iconTintColor: .systemBlue)
                ),
            ],
            header: header
        ) { (result) in
            switch result {
            case .success(let productID):
                print(productID)
                break
            case .failure(let error):
                print("Failed: \(error)")
                break
            }
        }
        
        storeViewController.title = "Upgrade"
        storeViewController.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(storeViewController, animated: true)
    }
    
}

