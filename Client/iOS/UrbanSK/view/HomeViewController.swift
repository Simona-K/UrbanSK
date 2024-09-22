//
//  HomeViewController.swift
//  UrbanSK
//
//  Created by Simona Kostovska on 6.09.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    let cellReuseIdentifier = "cell"
    let toMapDetails = "toMapDetails"
    let primaryColor = UIColor(red: 117/255, green: 192/255, blue: 182/255, alpha: 1)
    
    var dataSource: [UrbanPlan]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "UrbanSK"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveData()
    }
    
    @objc private func refresh(_ sender: Any?) {
        retrieveData()
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Повлечи за обнова на податоците")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func retrieveData() {
        let httpUrl = "http://192.168.1.246:4567/api/urbanPlans"
        guard let url = URL(string: httpUrl) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(UrbanPlansResponse.self, from: data)
                    self.dataSource = res.urbanPlans
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
        
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let dataSource = dataSource {
            cell.textLabel?.text = dataSource[indexPath.row].name
        }
        cell.selectedBackgroundView?.backgroundColor = primaryColor
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let dataSource = dataSource {
            self.performSegue(withIdentifier: toMapDetails, sender: dataSource[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! GoogleMapsViewController
        let urbanPlan = sender as! UrbanPlan
        nextVC.urbanPlan = urbanPlan
    }
    
}
