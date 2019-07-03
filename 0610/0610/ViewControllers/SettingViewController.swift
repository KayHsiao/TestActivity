//
//  SettingViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var vcType: MyViewControllerType!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.backgroundColor = UIColor(named: "Green 2")
            navigationController?.navigationBar.barTintColor = UIColor(named: "Green 2")
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.backgroundColor = UIColor(hexString: "00B156")
            navigationController?.navigationBar.barTintColor = UIColor(hexString: "00B156")
        }

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension SettingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "我的收藏"
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "v1.0"
    }
}

extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

}
