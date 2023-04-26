//
//  MainMenuController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 14.04.2023.
//

import UIKit

// TODO: - Some cleaning, refactoring into reusable code
class MainMenuController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let remainingBudget = UIButton()
    var hiddenLabels = false
    
    let expenses = UIButton()
    let income = UIButton()
    let trends = UIButton()
    
    let lastTransactions = UILabel()
    let transactionsTable = TransactionsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionsTable.rowsToReturn = 10;

        setupScrollingScreen()
        setupElementStyling()

        view.backgroundColor = .systemBackground
        title = "Home"
        
        #if DEBUG
        setupDevBorders()
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transactionsTable.reloadData()
    }
    
    func setupScrollingScreen() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        addGeneralConstraints(for: scrollView, to: view)
        addGeneralConstraints(for: stackView, to: scrollView, additionalConstraints: [
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 380 + CGFloat(transactionsTable.numberOfRows(inSection: 0)) * transactionsTable.rowHeight)
        ])
        
        setupElementsOnScroll()
    }
    
    func addGeneralConstraints(for subview: UIView, to superview: UIView, additionalConstraints: [NSLayoutConstraint] = []) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: superview.topAnchor),
            subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
        NSLayoutConstraint.activate(additionalConstraints)
    }
    
    func setupElementsOnScroll() {
        stackView.addSubview(remainingBudget)
        stackView.addSubview(expenses)
        stackView.addSubview(income)
        stackView.addSubview(trends)
        stackView.addSubview(lastTransactions)
        stackView.addSubview(transactionsTable)
    }
    
    func setupElementStyling() {
        setupBudget()
        setupExpenses()
        setupIncome()
        setupNavButtons()
        setupTrends()
        setupLastTransactions()
    }

    func setupBudget() {
        remainingBudget.addTarget(self, action: #selector(toggleLabels), for: .touchUpInside)
        
        remainingBudget.translatesAutoresizingMaskIntoConstraints = false
        remainingBudget.setTitleColor(UIColor.label, for: .normal)
        remainingBudget.setTitle("Budget: €12,345,678.90", for: .normal)
        remainingBudget.titleLabel?.font = .systemFont(ofSize: 28.0, weight: .bold)
        remainingBudget.contentVerticalAlignment = .top
        remainingBudget.contentHorizontalAlignment = .left
        
        NSLayoutConstraint.activate([
            remainingBudget.topAnchor.constraint(equalTo: stackView.topAnchor),
            remainingBudget.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remainingBudget.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9),
            remainingBudget.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupExpenses() {
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
        
        expenses.setTitle("• Expenses: €12,345,678.90", for: .normal)
        expenses.setTitleColor(UIColor.label, for: .normal)
        expenses.titleLabel?.font = .systemFont(ofSize: 20.0)
        expenses.contentHorizontalAlignment = .left
        expenses.contentVerticalAlignment = .top
        
        expenses.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            expenses.topAnchor.constraint(equalTo: remainingBudget.bottomAnchor, constant: -10),
            expenses.leftAnchor.constraint(equalTo: remainingBudget.leftAnchor, constant: 25.0),
            expenses.widthAnchor.constraint(equalTo: remainingBudget.widthAnchor, multiplier: 0.90),
            expenses.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupIncome() {
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
        
        income.setTitle("• Income: €12,345,678.90", for: .normal)
        income.setTitleColor(UIColor.label, for: .normal)
        income.titleLabel?.font = .systemFont(ofSize: 20.0)
        income.contentHorizontalAlignment = .left
        income.contentVerticalAlignment = .top
        
        
        income.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            income.topAnchor.constraint(equalTo: expenses.bottomAnchor, constant: -10),
            income.leftAnchor.constraint(equalTo: expenses.leftAnchor),
            income.widthAnchor.constraint(equalTo: expenses.widthAnchor),
            income.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupTrends() {
        trends.setTitle("Your expenses have grown up 87% since last week.", for: .normal)
        trends.titleLabel?.numberOfLines = 2
        trends.configuration?.titleLineBreakMode = .byTruncatingTail
        trends.setTitleColor(UIColor.label, for: .normal)
        trends.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        trends.titleLabel?.minimumScaleFactor = 0.5
        
        // TODO: de facut scaling automat in functie de cate trend-uri noi sunt
        // TODO: de implementat sistemul de trends
        
        trends.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trends.topAnchor.constraint(equalTo: income.bottomAnchor),
            trends.widthAnchor.constraint(equalTo: remainingBudget.widthAnchor),
            trends.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trends.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setupLastTransactions() {
        lastTransactions.text = "Last 5 transactions:"
        lastTransactions.font = UIFont.boldSystemFont(ofSize: 24.0)
        lastTransactions.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: de convertit la URLRequests, de implementat sistemul care ia UserDefaults pt numarul de rezultate
        NSLayoutConstraint.activate([
            lastTransactions.topAnchor.constraint(equalTo: trends.bottomAnchor),
            lastTransactions.widthAnchor.constraint(equalTo: remainingBudget.widthAnchor),
            lastTransactions.leftAnchor.constraint(equalTo: remainingBudget.leftAnchor),
            lastTransactions.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        setupTransactionsTable()
    }
    
    func setupTransactionsTable() {
        NSLayoutConstraint.activate([
            transactionsTable.topAnchor.constraint(equalTo: lastTransactions.bottomAnchor),
            transactionsTable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            transactionsTable.heightAnchor.constraint(equalToConstant: CGFloat(transactionsTable.numberOfRows(inSection: 0)) * transactionsTable.rowHeight),
            transactionsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        transactionsTable.didSelectItemHandler = { selectedRow in
            let transactionDetailsViewController = TransactionDetailsController()
            self.navigationController?.pushViewController(transactionDetailsViewController, animated: true)
        }
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
                                                message: "This action will close the application.\nYou will lose all active filters and the new invoice if you have any.",
                                                preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            exit(0)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        alertController.preferredAction = noAction
        present(alertController, animated: true)
    }
    
    @objc func rightBarButtonItemTapped() {
        let settingsController = SettingsController()
        settingsController.title = "Settings"
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @objc func toggleLabels() {
        hiddenLabels.toggle()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.expenses.alpha = self.hiddenLabels ? 0.0 : 1.0
            self.income.alpha = self.hiddenLabels ? 0.0 : 1.0
            self.income.frame.origin.y += self.hiddenLabels ? -40 : 40
            self.expenses.frame.origin.y += self.hiddenLabels ? -40 : 40
        })
    }
    
    
    func setupDevBorders() {
        remainingBudget.layer.borderWidth = 2
        remainingBudget.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        expenses.layer.borderColor = UIColor.secondaryLabel.cgColor
        expenses.layer.borderWidth = 2
        
        income.layer.borderColor = UIColor.secondaryLabel.cgColor
        income.layer.borderWidth = 2
        
        trends.layer.borderColor = UIColor.secondaryLabel.cgColor
        trends.layer.borderWidth = 2
        
        lastTransactions.layer.borderColor = UIColor.secondaryLabel.cgColor
        lastTransactions.layer.borderWidth = 2
        
        transactionsTable.layer.borderColor = UIColor.secondaryLabel.cgColor
        transactionsTable.layer.borderWidth = 2
    }
}
