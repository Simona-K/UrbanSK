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
//        let httpUrl = "http://localhost:4567/api/urbanPlans"
//        guard let url = URL(string: httpUrl) else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                do {
//                    let res = try JSONDecoder().decode(UrbanPlansResponse.self, from: data)
//                    self.dataSource = res.urbanPlans
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                        self.refreshControl.endRefreshing()
//                    }
//                } catch let error {
//                    print(error)
//                }
//            }
//        }
//        task.resume()
        
        let tileset1 = Tileset.init(tilesetId: "alexgizh.54t5f5qx", urbanPlanId: "skopjeMalRing", name: "План Град Скопља", released: "1930")
        let tileset2 = Tileset.init(tilesetId: "alexgizh.6e25di4e", urbanPlanId: "skopjeMalRing", name: "ДУП Мал Ринг", released: "2012")
        let skMalRing = UrbanPlan.init(urbanPlanId: "skopjeMalRing", name: "Скопје - Мал ринг", latitude: "41.995942", longitude: "21.431805", zoom: "15", tilesets: [tileset1, tileset2])
        
        let tileset3 = Tileset.init(tilesetId: "alexgizh.3biwsv4p", urbanPlanId: "ilinden", name: "Касарна Илинден", released: "2010")
        let ilinden = UrbanPlan.init(urbanPlanId: "ilinden", name: "Касарна Илинден", latitude: "42.019552", longitude: "21.419701", zoom: "15", tilesets: [tileset3])

        let tileset4 = Tileset.init(tilesetId: "alexgizh.diphmywp", urbanPlanId: "skopjeGolemRingZapad", name: "ДУП Голем Ринг - Запад", released: "2006")
        let skGolemRing = UrbanPlan.init(urbanPlanId: "skopjeGolemRingZapad", name: "Скопје - Голем ринг Запад", latitude: "41.995640", longitude: "21.426908", zoom: "15", tilesets: [tileset4])

        
        
        self.dataSource = [skMalRing, ilinden, skGolemRing]
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()

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
        let nextVC = segue.destination as! MapViewController
        let urbanPlan = sender as! UrbanPlan
        nextVC.urbanPlan = urbanPlan
    }
    
}
