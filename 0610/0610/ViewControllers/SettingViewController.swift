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

    let selectedBackgroundView = UIView()

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

        if #available(iOS 11.0, *) {
            selectedBackgroundView.backgroundColor = UIColor(named: "Green 3")
        } else {
            // Fallback on earlier versions
            selectedBackgroundView.backgroundColor = UIColor(hexString: "41D192")
        }
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
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "我的收藏"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "隱私權政策"
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }

        cell.selectedBackgroundView = selectedBackgroundView

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
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let myCollectedVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "MyCollectedViewController") as! MyCollectedViewController
            navigationController?.pushViewController(myCollectedVC)
        case 1:
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
