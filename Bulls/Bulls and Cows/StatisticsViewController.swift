//
//  StatisticsViewController.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 11/04/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePieChart()
        populateBarChart()
    }
    
    private func populatePieChart() {
        let data = ["wins": 70, "loses": 30]
        var dataEntries = [PieChartDataEntry]()
        for (key, val) in data {
            let percent = Double(val)
            let entry = PieChartDataEntry(value: percent, label: key)
            dataEntries.append(entry)
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Legend")
        chartDataSet.colors = ChartColorTemplates.material()
        chartDataSet.sliceSpace = 2
        chartDataSet.selectionShift = 5
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.data = chartData
        pieChart.centerText = "Win/Lose Ratio"
        pieChart.chartDescription = nil
    }
    
    private func populateBarChart() {
        let data = [12, 4]
        let labels = ["Bulls", "Cows"]
        var bullsEntries: [BarChartDataEntry] = []
        var cowsEntries: [BarChartDataEntry] = []
        let fistEntry = BarChartDataEntry(x: Double(0), y: Double(data[0]))
        let seccondEntry = BarChartDataEntry(x: Double(1), y: Double(data[1]))
        bullsEntries.append(fistEntry)
        cowsEntries.append(seccondEntry)
        let chartDataSet = BarChartDataSet(values: bullsEntries, label: labels[0])
        let chartMoreDataSets = BarChartDataSet(values: cowsEntries, label: labels[1])
        chartDataSet.colors = ChartColorTemplates.joyful()
        var datasets = [BarChartDataSet]()
        datasets.append(chartDataSet)
        datasets.append(chartMoreDataSets)
        let chartData = BarChartData(dataSets: datasets)
        barChart.data = chartData
        barChart.xAxis.drawLabelsEnabled = false
        barChart.chartDescription = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pieChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
