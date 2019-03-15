//
//  ViewController.swift
//  PieChart
//
//  Created by Tamilarasu on 15/03/19.
//  Copyright © 2019 Tamilarasu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let pieChart = PieChartView()
    var percent = 11
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pieChart)
        layoutPieChart()
        pieChart.backgroundColor = UIColor.brown.withAlphaComponent(0.3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let slice = Slice(color: UIColor.blue, value: 500.0)
        let slice1 = Slice(color: UIColor.orange, value: 100.0)
        let pieData = PieData(slices: [slice, slice1], totalValue: 600.0, remainingColor: UIColor.green, weight: 0.7)
        
        pieChart.plot(pieData: pieData)
    }
    
    func layoutPieChart() {
        percent -= 1
        let size = percent * 30
        pieChart.frame = CGRect(x: 0, y: 0, width: size, height: size)
        
    }
    
    @IBAction func buttonSelect(_ sender: Any) {
        
        layoutPieChart()
    }
}
