//
//  Examples.swift
//  ScrollableGraphView
//
//  Created by Cameron Mcleod on 2019-07-24.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import Foundation
import UIKit

class Examples : ScrollableGraphViewDataSource {
    // MARK: Data Properties
    
    private var numberOfDataItems = 29
    
    // Data for graphs with a single plot
    private lazy var barPlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
    
    // Data for graphs with multiple plots
    private lazy var blueLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 50)
    private lazy var orangeLinePlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 40, shouldIncludeOutliers: false)
    
    // Labels for the x-axis
    
    private lazy var xAxisLabels: [String] =  self.generateSequentialLabels(self.numberOfDataItems, text: "FEB")
    
    // MARK: ScrollableGraphViewDataSource protocol
    // #########################################################
    
    // You would usually only have a couple of cases here, one for each
    // plot you want to display on the graph. However as this is showing
    // off many graphs with different plots, we are using one big switch
    // statement.
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        switch(plot.identifier) {
            
        // Data for the graphs with a single plot
        case "bar":
            return barPlotData[pointIndex]
        // Data for MULTI graphs
        case "multiBlue":
            return blueLinePlotData[pointIndex]
        case "multiOrange":
            return orangeLinePlotData[pointIndex]
        case "multiSum":
            return (blueLinePlotData[pointIndex] + orangeLinePlotData[pointIndex])
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        // Ensure that you have a label to return for the index
        return xAxisLabels[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return numberOfDataItems
    }
    
    // Multi plot v2
    // min: 0
    // max: determined from active points
    // The max reference line will be the max of all visible points
    func createMultiPlotGraphTwo(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the line plot.
        let blueLinePlot = LinePlot(identifier: "multiBlue")
        
        blueLinePlot.lineWidth = 1
        blueLinePlot.lineColor = UIColor.init(hexString: "#16aafc")
        blueLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        blueLinePlot.shouldFill = true
        blueLinePlot.fillType = ScrollableGraphViewFillType.solid
        blueLinePlot.fillColor = UIColor.init(hexString: "#16aafc").withAlphaComponent(0.5)
        
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        
        // Setup the second line plot.
        let orangeLinePlot = LinePlot(identifier: "multiOrange")
        
        orangeLinePlot.lineWidth = 1
        orangeLinePlot.lineColor = UIColor.init(hexString: "#ff7d78")
        orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        orangeLinePlot.shouldFill = true
        orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
        orangeLinePlot.fillColor = UIColor.init(hexString: "#ff7d78").withAlphaComponent(0.5)
        
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        
        // Setup the sum line plot.
        let sumLinePlot = LinePlot(identifier: "multiSum")
        
        sumLinePlot.lineWidth = 2
        sumLinePlot.lineColor = UIColor.init(hexString: "#ffffff")
        sumLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        sumLinePlot.shouldFill = false
        
        sumLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
        
        // Setup the graph
        graphView.backgroundFillColor = UIColor.init(hexString: "#333333")
        
        graphView.dataPointSpacing = 40
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        
        graphView.shouldRangeAlwaysStartAtZero = true
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: blueLinePlot)
        graphView.addPlot(plot: orangeLinePlot)
        graphView.addPlot(plot: sumLinePlot)
        
        return graphView
    }
    
    // min: 0
    // max: 100
    // Will not adapt min and max reference lines to range of visible points
    func createBarGraph(_ frame: CGRect) -> ScrollableGraphView {
        
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the plot
        let barPlot = BarPlot(identifier: "bar")
        
        barPlot.barWidth = 25
        barPlot.barLineWidth = 1
        barPlot.barLineColor = UIColor.init(hexString: "#777777")
        barPlot.barColor = UIColor.init(hexString: "#555555")
        
        barPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        barPlot.animationDuration = 1.5
        
        // Setup the reference lines
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        // Setup the graph
        graphView.backgroundFillColor = UIColor.init(hexString: "#333333")
        
        graphView.shouldAnimateOnStartup = true
        
        graphView.rangeMax = 100
        graphView.rangeMin = 0
        
        // Add everything
        graphView.addPlot(plot: barPlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        return graphView
    }
    
    // MARK: Data Generation
    
    func reload() {
        // Currently changing the number of data items is not supported.
        // It is only possible to change the the actual values of the data before reloading.
        // numberOfDataItems = 30
        
        // data for graphs with a single plot
        barPlotData = self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
        
        // data for graphs with multiple plots
        blueLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 50)
        orangeLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 40, shouldIncludeOutliers: false)
        
        // update labels
        xAxisLabels = self.generateSequentialLabels(self.numberOfDataItems, text: "MAR")
    }
    
    private func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
        var data = [Double]()
        for i in 0 ..< numberOfItems {
//            var randomNumber = Double(arc4random()).truncatingRemainder(dividingBy: max)
//
//            if(shouldIncludeOutliers) {
//                if(arc4random() % 100 < 10) {
//                    randomNumber *= 3
//                }
//            }
            let randomNumber : Double
            if i % 5 == 0 {
                randomNumber = Double(arc4random_uniform(5))
            } else {
                randomNumber = Double(5)
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateRandomData(_ numberOfItems: Int, variance: Double, from: Double) -> [Double] {
        
        var data = [Double]()
        for i in 0 ..< numberOfItems {
            
//            let randomVariance = Double(arc4random()).truncatingRemainder(dividingBy: variance)
//            var randomNumber = from
//
//            if(arc4random() % 100 < 50) {
//                randomNumber += randomVariance
//            }
//            else {
//                randomNumber -= randomVariance
//            }
            let randomNumber : Double
            if i % 5 == 0 {
                randomNumber = Double(arc4random_uniform(5))
            } else {
                randomNumber = Double(5)
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateSequentialLabels(_ numberOfItems: Int, text: String) -> [String] {
        var labels = [String]()
        for i in 0 ..< numberOfItems {
            labels.append("\(text) \(i+1)")
        }
        return labels
    }
}
