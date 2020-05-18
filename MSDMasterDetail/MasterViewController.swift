//
//  MasterViewController.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/7/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import UIKit
import RxSwift

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    var viewModel = ItunesListViewModel()
    var kMediaInfoTableViewCell = "MediaInfoTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        setupView()
    }
    

    private func setupView() {
        viewModel.getItunesSearch()
        setupTableView()
        setupObservables()
    }
    
    private func setupObservables() {
        viewModel.onDataChanged = {
            self.tableView.reloadData()
        }
    }
    private func setupTableView() {
        let nib = UINib(nibName: kMediaInfoTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kMediaInfoTableViewCell)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
//        super.viewWillAppear(animated)
//    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let primaryKey = viewModel.getPrimaryKey(at: indexPath.row)
                if let detailViewController = segue.destination as? DetailViewController {
                    // Pass the item to the detail view controller for editing.
                    detailViewController.primaryKey = primaryKey
               }
           }
       }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let lblDateStamp = UILabel()
        lblDateStamp.frame = CGRect(x: 0, y: 0, width: viewHeader.frame.size.width, height: viewHeader.frame.size.height)
        lblDateStamp.font = UIFont.systemFont(ofSize: 15)
        lblDateStamp.textAlignment = .center
        lblDateStamp.backgroundColor = .gray
        lblDateStamp.textColor = .white
        
        if let dateStamp = DateStamp().getDateStamp() {
            lblDateStamp.text = "Last visit was \(dateStamp)"
        }
        else {
            lblDateStamp.text = "Hello! This is your first visit!"
        }
        viewHeader.addSubview(lblDateStamp)
        
        return viewHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mediaInfoViewModel = viewModel.viewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: kMediaInfoTableViewCell, for: indexPath) as! MediaInfoTableViewCell
        cell.configure(with: mediaInfoViewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
}

