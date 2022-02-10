//
//  AppDelegateCoordinator.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

// MARK: - Class Bone
class HomeCoordinator: Coordinator {

    // MARK: Attributes
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    let router: Router

    func start(_ actionType: ExchangeActionType?, animated: Bool, onDismissed: (() -> Void)?) {
        let viewModel = HomeViewModel()
        viewModel.viewModelCoordinationDelegate = self
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        router.present(navigationController, animated: true)
    }

    required init(router: Router) {
        self.router = router
    }
}
// MARK: HomeViewModel Coordination Delegate
extension HomeCoordinator: HomeViewModelCoordinationDelegate {
    func presentCurrencySelectionScreen(_ viewController: HomeViewController)  {
        let router = ExchangeRouter(parentViewController: viewController)
        let coordinator = ExchangeCoordinator(router: router)
        self.startChild(.selection, coordinator, animated: true)
    }

    func presentConfirmationScreen(_ viewController: HomeViewController)  {
        let router = ExchangeRouter(parentViewController: viewController)
        let coordinator = ExchangeCoordinator(router: router)
        self.startChild(.confirmation, coordinator, animated: true)
    }
}

