//
//  DoctorsListViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import UIKit

class DoctorsListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "DoctorsListTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "DoctorsListTableViewCell")

    }
}

extension DoctorsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsListTableViewCell", for: indexPath) as! DoctorsListTableViewCell
        cell.name.text = "yo"
        return cell
    }
    
    
}
