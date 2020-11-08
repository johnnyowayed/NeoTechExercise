//
//  PageOneTableViewController.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit

class PageOneTableViewController: UITableViewController {
    
    var array_TableData = [PortfolioModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        self.fetchData()
    }
    
    private func fetchData() {
        ApiCalls.fetchPortfolios { (results) in
            for result in results {
                self.array_TableData.append(PortfolioModel.init(data: result))
            }
            self.tableView.reloadData()
        } errorCallback: { (error) in
           
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.array_TableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        (cell.viewWithTag(1) as? UILabel)?.text = self.array_TableData[indexPath.row].name
        (cell.viewWithTag(2) as? UILabel)?.text = "$" + "\(self.array_TableData[indexPath.row].balance)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(identifier: "PageTwo") as? PageTwoViewController else { return }
        vc.portfolio = self.array_TableData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
