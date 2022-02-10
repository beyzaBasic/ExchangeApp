//
//  ConfirmationViewController.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

// MARK: - Class Bone
class ConfirmationViewController: UIViewController {
    // MARK: Attributes
    private var viewModel: ConfirmationViewModelProtocol

    // MARK: Properties

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: Cons & Decons
    init(viewModel: ConfirmationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        self.viewModel.confirmTapped()
    }
}
// MARK: - Set Up UI
extension ConfirmationViewController {
    private func setUpUI() {
        self.view.backgroundColor = .red
    }
}

