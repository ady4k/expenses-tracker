//
//  MainMenuController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 14.04.2023.
//

import UIKit

class MainMenuController: UIViewController {

    let remainingBudget = UIButton()
    let expenses = UIButton()
    let income = UIButton()
    
    let trends = UIButton()
    
    let lastTransactions = UILabel()
    let transactionsTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupExpenses()
        setupIncome()
        setupNavButtons()
        setupTrends()
        setupLastTransactions()
        view.backgroundColor = .systemBackground
        title = "Home"
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transactionsTable.reloadData()
    }

    func setupButtons() {
        view.addSubview(remainingBudget)
        remainingBudget.addTarget(self, action: #selector(goToRemainingBudgetScreen), for: .touchUpInside)
        
        remainingBudget.translatesAutoresizingMaskIntoConstraints = false
        remainingBudget.setTitleColor(.black, for: .normal)
        remainingBudget.setTitle("Budget: ...$", for: .normal)
        remainingBudget.titleLabel?.font = .systemFont(ofSize: 32.0, weight: .bold)
        remainingBudget.contentVerticalAlignment = .top
        
        remainingBudget.layer.cornerRadius = 25.0
        remainingBudget.backgroundColor = .systemMint
        remainingBudget.layer.borderColor = UIColor.black.cgColor
        remainingBudget.layer.borderWidth = 1.5
        
        NSLayoutConstraint.activate([
            remainingBudget.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remainingBudget.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            remainingBudget.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -25.0),
            remainingBudget.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15)
        ])
    }
    
    func setupExpenses() {
        view.addSubview(expenses)
        
        let viewExpenses = UIAction(title: "View Expenses", image: UIImage(systemName: "list.bullet")) { (action) in
            // go to expenses menu controller
        }
        let addExpense = UIAction(title: "Add new Expense", image: UIImage(systemName: "plus.circle")) { (action) in
            // go to add new expense menu, also available from the main center button
        }
        let hideExpenses = UIAction(title: "Hide Number", image: UIImage(systemName: "eye")) { (action) in
            // hide the expenses number from the icon
        }
        
        let menu = UIMenu(title: "Expenses Options", options: .displayInline, children: [viewExpenses, addExpense, hideExpenses])
        // TODO: de implementat functionalitati pentru butoane
        expenses.menu = menu
        expenses.showsMenuAsPrimaryAction = true
        
        expenses.setTitle("Expenses:\n...$", for: .normal)
        expenses.titleLabel?.numberOfLines = 2
        expenses.setTitleColor(.black, for: .normal)
        expenses.titleLabel?.font = .systemFont(ofSize: 24.0)
        expenses.contentHorizontalAlignment = .center
        
        expenses.layer.cornerRadius = 25.0
        expenses.layer.borderColor = UIColor.black.cgColor
        expenses.layer.borderWidth = 1.5
        
        expenses.backgroundColor = .systemOrange
        expenses.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            expenses.topAnchor.constraint(equalTo: remainingBudget.bottomAnchor, constant: -40.0),
            expenses.leftAnchor.constraint(equalTo: remainingBudget.leftAnchor, constant: 25.0),
            expenses.widthAnchor.constraint(equalTo: remainingBudget.widthAnchor, multiplier: 0.40),
            expenses.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.10),
        ])
    }
    
    func setupIncome() {
        view.addSubview(income)
        
        let viewIncome = UIAction(title: "View Income", image: UIImage(systemName: "list.bullet")) { (action) in
            // go to expenses menu controller
        }
        let addIncome = UIAction(title: "Add new Income", image: UIImage(systemName: "plus.circle")) { (action) in
            // go to add new expense menu, also available from the main center button
        }
        let hideIncome = UIAction(title: "Hide Number", image: UIImage(systemName: "eye")) { (action) in
            // hide the expenses number from the icon
        }
        
        let menu = UIMenu(title: "Income Options", options: .displayInline, children: [viewIncome, addIncome, hideIncome])
        // TODO: de implementat functionalitati pentru butoane
        income.menu = menu
        income.showsMenuAsPrimaryAction = true
        
        income.setTitle("Income:\n...$", for: .normal)
        income.titleLabel?.numberOfLines = 2
        income.setTitleColor(.black, for: .normal)
        income.titleLabel?.font = .systemFont(ofSize: 24.0)
        income.contentHorizontalAlignment = .center
        
        income.layer.cornerRadius = 25.0
        income.layer.borderColor = UIColor.black.cgColor
        income.layer.borderWidth = 1.5
        
        income.backgroundColor = .systemPink
        income.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            income.topAnchor.constraint(equalTo: remainingBudget.bottomAnchor, constant: -40.0),
            income.rightAnchor.constraint(equalTo: remainingBudget.rightAnchor, constant: -25.0),
            income.widthAnchor.constraint(equalTo: remainingBudget.widthAnchor, multiplier: 0.40),
            income.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.10),
        ])
    }
    
    func setupTrends() {
        view.addSubview(trends)
        
        trends.setTitle("Your expenses have grown up 87% since last week.", for: .normal)
        trends.titleLabel?.numberOfLines = 2
        trends.configuration?.titleLineBreakMode = .byTruncatingTail
        trends.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        trends.titleLabel?.minimumScaleFactor = 0.5
        
        trends.layer.cornerRadius = 25.0
        trends.layer.borderColor = UIColor.black.cgColor
        trends.layer.borderWidth = 1.5
        // TODO: de facut scaling automat in functie de cate trend-uri noi sunt
        
        
        trends.backgroundColor = UIColor(red: 0.86, green: 0.68, blue: 0.42, alpha: 1.0)
        trends.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trends.topAnchor.constraint(equalTo: income.bottomAnchor, constant: 10.0),
            trends.widthAnchor.constraint(equalTo: remainingBudget.widthAnchor),
            trends.heightAnchor.constraint(equalTo: remainingBudget.heightAnchor),
            trends.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func setupLastTransactions() {
        view.addSubview(lastTransactions)
        
        lastTransactions.text = "Last 5 transactions:"
        lastTransactions.font = UIFont.boldSystemFont(ofSize: 20.0)
        lastTransactions.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastTransactions.topAnchor.constraint(equalTo: trends.bottomAnchor, constant: 20.0),
            lastTransactions.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.90),
            lastTransactions.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0)
        ])
        
        setupTransactionsTable()
    }
    
    func setupTransactionsTable() {
        view.addSubview(transactionsTable)
        transactionsTable.delegate = self
        transactionsTable.dataSource = self
        transactionsTable.rowHeight = 50
        transactionsTable.translatesAutoresizingMaskIntoConstraints = false
        transactionsTable.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.transactionIdentifier)
        
        NSLayoutConstraint.activate([
            transactionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            transactionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            transactionsTable.topAnchor.constraint(equalTo: lastTransactions.bottomAnchor, constant: 20.0),
            transactionsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupNavButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(MainMenuController.leftBarButtonItemTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(MainMenuController.rightBarButtonItemTapped))
    }
    
    @objc func leftBarButtonItemTapped() {
        let alertController = UIAlertController(title: "Are you sure you want to exit?",
                                                message: "",
                                                preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .destructive)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
            exit(0)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        alertController.preferredAction = yesAction
        present(alertController, animated: true)
    }
    
    @objc func rightBarButtonItemTapped() {
        let settingsController = SettingsController()
        settingsController.title = "Settings"
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @objc func goToRemainingBudgetScreen() {
        let nextScreen = AddInvoiceController()
        nextScreen.title = "Add Invoice"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

extension MainMenuController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: de implementat celulele tabelului bazate pe tranzactii
        // TODO: de implementat ViewController pentru celule
        if let transactionCell = transactionsTable.dequeueReusableCell(withIdentifier: TransactionViewCell.transactionIdentifier, for: indexPath) as? TransactionViewCell {
            transactionCell.self.layer.borderWidth = 2
            transactionCell.self.layer.borderColor = UIColor.red.cgColor
            
            return transactionCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15;
    }
    // TODO: de implementat
}

extension MainMenuController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionDetailsViewController = TransactionDetailsController()
        navigationController?.pushViewController(transactionDetailsViewController, animated: true)
    }
}
