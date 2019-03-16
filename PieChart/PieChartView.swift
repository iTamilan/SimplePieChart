import UIKit

struct Slice {
    let color: UIColor
    let value: CGFloat
}

struct PieData {
    let slices: [Slice]
    let totalValue: CGFloat
    let remainingColor: UIColor
    let weight: CGFloat
}

class PieChartView: UIView {
    
    var pieData: PieData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        plotChart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        plotChart()
    }
    
    func plot(pieData: PieData) {
        self.pieData = pieData
        plotChart()
    }
    
    func plotChart() {
        
        guard let pieData = pieData else {
            return
        }
        
        layer.sublayers?.removeAll()
        
        var fromAngle = -CGFloat(Double.pi * 0.5)
        
        for slice in pieData.slices {
            let percent =  min(slice.value / pieData.totalValue, 1.0)
            let toAngle = fromAngle + (CGFloat(Double.pi * 2) * percent)
            plotChart(fromAngle: fromAngle, toAngle: toAngle, color: slice.color)
            fromAngle = toAngle
        }
        plotChart(fromAngle: fromAngle, toAngle: CGFloat(Double.pi * 1.5), color: pieData.remainingColor)
    }
    
    func plotChart(fromAngle: CGFloat, toAngle: CGFloat, color: UIColor) {
        guard let pieData = pieData else {
            return
        }
        
        let lineWidth = (bounds.height/2.0) * pieData.weight
        let minSize = min(bounds.height, bounds.width) - lineWidth
        let xOrigin = bounds.width/2.0
        let yOrigin = bounds.height/2.0
        let arcCenter = CGPoint(x: xOrigin, y: yOrigin)
        
        let circlePath = UIBezierPath(arcCenter: arcCenter,
                                      radius: minSize/2.0,
                                      startAngle: fromAngle,
                                      endAngle: toAngle,
                                      clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = color.cgColor
        //you can change the line width
        shapeLayer.lineWidth = lineWidth
        
        layer.addSublayer(shapeLayer)
        clipsToBounds = true
    }
}
