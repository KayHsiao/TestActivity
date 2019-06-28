//
//  HomeViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var vcType: MyViewControllerType!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "xinxi"), style: .plain, target: self, action: nil)







        requestManager.getTaipeiCafe { [weak self] (json) in
            log.info(json)
            guard let strongSelf = self else { return }
        }


//                let session = URLSession.shared
//
//                let url = URL(string: "https://cafenomad.tw/api/v1.2/cafes/taipei")!
//
//                let task = session.dataTask(with: url) { data, response, error in
//
//                    if error != nil || data == nil {
//                        print("Client error!")
//                        return
//                    }
//
//                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                        print("Server error!")
//                        return
//                    }
//
//                    guard let mime = response.mimeType, mime == "application/json" else {
//                        print("Wrong MIME type!")
//                        return
//                    }
//
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                        print(json)
//                    } catch {
//                        print("JSON error: \(error.localizedDescription)")
//                    }
//                }
//
//                task.resume()

        tableView.dataSource = self
        tableView.separatorStyle = .none

    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        
        return cell
    }
}
