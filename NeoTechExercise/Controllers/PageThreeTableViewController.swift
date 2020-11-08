//
//  PageTwoTableViewController.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit
import Charts

class PageThreeTableViewController: UITableViewController, ChartViewDelegate {

    @IBOutlet weak var view_Chart: LineChartView!
    
    var array_HistoricalData = [HistoricalDataModel]()
    var portfolio = PortfolioModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Education"
        self.fetchHistoricalData()
    }
    
    func fetchHistoricalData() {
        ApiCalls.fetchHistoricalData { [self] (results) in
            for result in results {
                self.array_HistoricalData.append(HistoricalDataModel.init(data: result))
            }
            self.setupChart()
        } errorCallback: { (error) in
            
        }
    }
    
    func setupChart() {
        self.view_Chart.delegate = self
        let leftAxis = view_Chart.leftAxis
        leftAxis.axisMaximum = 30000
        leftAxis.axisMinimum = 0
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        let xAxis = view_Chart.xAxis
        xAxis.axisMaximum = 1575289350
        xAxis.axisMinimum = 1086048000
        xAxis.valueFormatter = DateValueFormatter()
        
        let limitLine = ChartLimitLine(limit: 24000, label: "Target Ammount $24,000")
        limitLine.lineWidth = 2
        limitLine.lineDashLengths = [5,5]
        limitLine.labelPosition = .topLeft
        limitLine.lineColor = .lightGray
        limitLine.valueFont = .systemFont(ofSize: 10)
        
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(limitLine)
        
        view_Chart.rightAxis.enabled = false
        
        view_Chart.dragXEnabled = true
        view_Chart.dragEnabled = true
        view_Chart.legend.form = .circle
        view_Chart.xAxis.labelPosition = .bottom
        view_Chart.chartDescription?.enabled = false
        view_Chart.xAxis.drawAxisLineEnabled = false
        self.updateChartData()
        
        view_Chart.animate(xAxisDuration: 2)
    }
    
    func updateChartData() {
        self.view_Chart.data = nil
        self.setDataCount()
    }
    
    func setDataCount() {
        
        var array_ChartDataEntrySet1 = [ChartDataEntry]()
        var array_ChartDataEntrySet2 = [ChartDataEntry]()
        for item in self.array_HistoricalData {
            array_ChartDataEntrySet1.append(ChartDataEntry.init(x: Double(item.dateJs) ?? 0, y: item.smartWealthValue))
            array_ChartDataEntrySet2.append(ChartDataEntry.init(x: Double(item.dateJs) ?? 0, y: item.benchmarkValue))
        }

        let set1 = LineChartDataSet(entries: array_ChartDataEntrySet1, label: "Smart Weather")
        set1.drawIconsEnabled = false
        set1.setColor(UIColor.systemGreen)
        set1.lineWidth = 2
        set1.circleRadius = 0
        set1.drawValuesEnabled = false
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(entries: array_ChartDataEntrySet2, label: "Bench Mark")
        set2.drawIconsEnabled = false
        set2.setColor(UIColor.darkGray)
        set2.circleRadius = 0
        set2.lineWidth = 2
        set2.drawValuesEnabled = false
        set2.drawCircleHoleEnabled = false

        let data = LineChartData.init(dataSets: [set1,set2])

        self.view_Chart.data = data
    }
}

// MARK: - Table view data source
extension PageThreeTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        (cell.viewWithTag(1) as? UILabel)?.applyBoldFont()
        (cell.viewWithTag(2) as? UILabel)?.applyRegularFont(ofSize: 12)
        (cell.viewWithTag(2) as? UILabel)?.textColor = .darkGray
        
        switch indexPath.row {
            case 0:
                (cell.viewWithTag(1) as? UILabel)?.text = "ID"
                (cell.viewWithTag(2) as? UILabel)?.text = portfolio.id
            case 1:
                (cell.viewWithTag(1) as? UILabel)?.text = "Created At"
                (cell.viewWithTag(2) as? UILabel)?.text = portfolio.createdAt
            case 2:
                (cell.viewWithTag(1) as? UILabel)?.text = "Risk Score"
                (cell.viewWithTag(2) as? UILabel)?.text = "\(portfolio.modifiedRiskScore)"
            case 3:
                (cell.viewWithTag(1) as? UILabel)?.text = "Invertment Type"
                (cell.viewWithTag(2) as? UILabel)?.text = portfolio.investmentType
            default:
                break
        }

        return cell
    }
}
