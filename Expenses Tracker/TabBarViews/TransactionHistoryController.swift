//
//  TransactionHistoryController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 16.04.2023.
//

import UIKit
import LocalAuthentication

class TransactionHistoryController: UIViewController {
    let transactionsTable = TransactionsTableView()
    var appliedFilters: [String] = []
    var shouldAuthenticate = true
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Transactions"
        self.navigationItem.title = "Transactions History"
        
        setupBlurView()
        transactionsTable.rowsToReturn = 50;
        setupTransactionsTable()
        setupNavButtons()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transactionsTable.reloadData()
        
        if (shouldAuthenticate == true) {
            authenticate()
        }
    }
    
    func setupBlurView() {
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        view.addSubview(blurView)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupTransactionsTable() {
        view.addSubview(transactionsTable)
        
        NSLayoutConstraint.activate([
            transactionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            transactionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            transactionsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            transactionsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        transactionsTable.didSelectItemHandler = { selectedRow in
            let transactionDetailViewController = TransactionDetailsController()
            self.navigationController?.pushViewController(transactionDetailViewController, animated: true)
        }
        transactionsTable.isScrollEnabled = true
    }
    
    func setupNavButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset Filters",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(TransactionHistoryController.leftBarButtonItemTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply Filters",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(TransactionHistoryController.rightBarButtonItemTapped))
    }
    
    @objc func leftBarButtonItemTapped() {
        let alertController = UIAlertController(title: "Reset table filters?",
                                                message: "This action will remove all the filters that have been applied.\nThis action cannot be undone.",
                                                preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.appliedFilters = []
            self.transactionsTable.reloadData()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        alertController.preferredAction = yesAction
        present(alertController, animated: true)
    }
    
    @objc func rightBarButtonItemTapped() {
        // TODO: Table requests and filtering logic
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        let reason = "Accesing this feature requires FaceID authentication"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    DispatchQueue.main.async {
                        self.shouldAuthenticate = false
                        self.removeBlur()
                    }
                } else {
                    DispatchQueue.main.async {
                        (self.tabBarController as? TabBarController)?.switchToMainMenuTab()
                    }
                    print(error?.localizedDescription ?? "Authentication failed")
                }
            }
        } else {
            print(error?.localizedDescription ?? "Face ID is not supported")
        }
    }
    
    func removeBlur() {
        blurView.removeFromSuperview()
        self.navigationController?.navigationBar.isHidden = false
    }
}
