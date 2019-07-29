//
//  FocusViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData




class FocusViewController: UIViewController {
    
    enum CurrentMode {
        case focusMode
        case breakMode
    }
    
    var taskID : UUID?
    var task = Task()
    var taskPredicate: NSPredicate?
    
    static let FOCUS_TIME = 1500
    static let BREAK_TIME = 300
    
    var currentCounter = FOCUS_TIME
    var timer = Timer()
    var isTimerRunning = false
    var hasStarted = false
    var currentMode = CurrentMode.focusMode
    var sessionStartTime : Date?
    
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var previousSessionsTable: UITableView!
    @IBOutlet weak var playButton: PausePlayButton!
    @IBOutlet weak var pauseButton: PausePlayButton!
    
    @IBOutlet weak var testImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TEST TASK
        let task1 = Task(context: PersistenceService.context)
        task1.name = "Be Cool"
        task1.taskDescription = "I just want to be everyone's friend and like have super cool parteeees."
        task1.isComplete = false
        task1.daysAvailable = Array.init(repeating: true, count: 7)
        task1.deadline = NSDate(timeIntervalSinceNow: 10000)
        task1.priority = Int16(7)
        task1.id = UUID()
        PersistenceService.saveContext()

        // Do any additional setup after loading the view.
        
        // make sure id is UUID
        guard let id = self.taskID else {
            print("id not UIID")
            return
        }

        // fetch task from UUID
            
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        do {
            let taskFromID =  try PersistenceService.context.fetch(fetchRequest)[0]
            self.task = taskFromID
        } catch {
            print("Oh no, there is no data to load")
        }

        // set up buttons
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        
        self.playButton.addTarget(self, action: #selector(startStopTimer), for: .touchDown)
        self.pauseButton.addTarget(self, action: #selector(startStopTimer), for: .touchDown)
        
        self.taskNameLabel.text = self.task.name
        self.testImageLabel.text = self.task.name
        
        timerLabel.text = FocusViewController.FOCUS_TIME.secondsToMinutesSeconds()
        sessionStartTime = Date()
        
    }
    // MARK: - Actions
    
    @IBAction func finishPressed(_ sender: UIButton) {
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
        }
        
    }
    
    // MARK: - Private Functions
    
    @objc private func startStopTimer () {
        
        animatePausePlay(isRunning: isTimerRunning)
        animateTimer()
        switch isTimerRunning {
        case false:
            isTimerRunning = true
             timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
        case true:
            isTimerRunning = false
            timer.invalidate()

        }
    }
    
    @objc private func updateTimer() {
        
        currentCounter = currentCounter - 1
        timerLabel.text = currentCounter.secondsToMinutesSeconds()

    }
    
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Animations
    
    private func animatePausePlay(isRunning: Bool) {
        
        switch isRunning {
        case false:
            self.playButton.isHidden = true
            self.pauseButton.isHidden = false
            self.pauseButton.animatePlayPause()
        case true:
            self.playButton.isHidden = false
            self.pauseButton.isHidden = true
            self.playButton.animatePlayPause()
        }
    }
    
    func animateTimer() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.1
        pulseAnimation.repeatCount = 1
        
        let startScale: Float = 0.4
        let stopScale: Float = 1.0
        
        pulseAnimation.fromValue = NSNumber(value: startScale as Float)
        pulseAnimation.toValue = NSNumber(value: stopScale as Float)
        pulseAnimation.autoreverses = true
        pulseAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.timerLabel.layer
        layer.add(pulseAnimation, forKey:"pulseLabel")
    }

}

