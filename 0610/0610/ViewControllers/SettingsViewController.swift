//
//  SettingViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var vcType: MyViewControllerType!

    let selectedBackgroundView = UIView()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? .default : .black
        
        navigationController?.navigationBar.backgroundColor = Theme.current.navigationBar
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Theme.current.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        if #available(iOS 11.0, *) {
            selectedBackgroundView.backgroundColor = UIColor(named: "Green 3")
        } else {
            // Fallback on earlier versions
            selectedBackgroundView.backgroundColor = UIColor(hexString: "41D192")
        }
    }

    fileprivate func applyTheme() {
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()

        self.setupNavigationBar()

        self.tabBarController?.tabBar.barTintColor = Theme.current.tabBar
        self.tabBarController?.tabBar.tintColor = Theme.current.tint
        self.tabBarController?.tabBar.unselectedItemTintColor = Theme.current.tabBarUnSelected
    }
}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "我的收藏"
            cell.textLabel?.textColor = Theme.current.tableViewCellLightText
            cell.backgroundColor = Theme.current.tableViewCellBackgorund
            cell.selectedBackgroundView = selectedBackgroundView

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.titleLabel.text = "夜間模式"
            cell.delegate = self


            if UserDefaults.standard.bool(forKey: "kIsDarkTheme") {
                cell.switch.setOn(true, animated: false)
            } else {
                cell.switch.setOn(false, animated: false)
            }

            cell.backgroundColor = Theme.current.tableViewCellBackgorund
//            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "隱私權政策"
            cell.textLabel?.textColor = Theme.current.tableViewCellLightText
            cell.backgroundColor = Theme.current.tableViewCellBackgorund
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        default:
            assertionFailure("no match cell with type")
        }

        let cell = UITableViewCell()
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "v1.0"
    }

}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let myCollectedVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "MyCollectedViewController") as! MyCollectedViewController
            navigationController?.pushViewController(myCollectedVC)
        case 2:
            if let url = URL(string: "https://www.privacypolicies.com/privacy/view/83496ea793b852bb13f0f53d58711c6e") {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        default:
            break
        }
    }

}

extension SettingsViewController: SwitchTableViewCellDelegate {

    func switchTheme() {
        applyTheme()
    }

}
