//
//  TableNumberViewController.swift
//  CoordinatorExample
//
//  Created by William Wishart on 01/10/2017.
//  Copyright © 2017 William Wishart. All rights reserved.
//
import Foundation
import UIKit

public protocol TableNumberViewControllerDelegate: class {
    func tableNumberViewControllerDidTapClose(_ tableNumberViewController: TableNumberViewController)
    func tableNumberViewController(_ tableNumberViewController: TableNumberViewController, didSelectTableNumber tableNumber: String)
}

public class TableNumberViewController: UITableViewController {
    
    private let services: Services
    
    public weak var delegate: TableNumberViewControllerDelegate?
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeButtonTapped))
        return closeBarButtonItem
    }()
    
    private let tableNumbers = [
        "A1",
        "A2",
        "B1",
        "B2"
    ]
    
    public init(services: Services) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Select Table"
        self.navigationItem.leftBarButtonItem = self.closeBarButtonItem
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeButtonTapped(sender: UIBarButtonItem) {
        self.delegate?.tableNumberViewControllerDidTapClose(self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // I like slightly larger cells 😃
        self.tableView.rowHeight = 50
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tableNumber = self.tableNumbers[indexPath.row]
        self.delegate?.tableNumberViewController(self, didSelectTableNumber: tableNumber)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let drinkType = self.tableNumbers[indexPath.row]
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = drinkType
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableNumbers.count
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

