//
//  FocusViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

class FocusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    enum CurrentMode {
        case focusMode
        case breakMode
    }
    
    var taskID : UUID?
    var task = Task()
    var taskPredicate: NSPredicate?
    
    let FOCUS_TIME = 10
    let BREAK_TIME = 5
    var currentCounter = 10
    var timer = Timer()
    var isTimerRunning = false
    var hasStarted = false
    var currentMode = CurrentMode.focusMode
    var taskSessions: [(Date,Int)] = []
    var newTaskSessions: [(Date,Int)] = []
    var sessionStartTime = Date()
    var fromBreak = false
    
    //MARK: - UI Outlets
    
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var previousSessionsTable: UITableView!
    @IBOutlet weak var playButton: PausePlayButton!
    @IBOutlet weak var pauseButton: PausePlayButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var testImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseByResign), name: UIApplication.willResignActiveNotification, object: nil)

        // TEST TASK
        let task1 = Task(context: PersistenceService.context)
        task1.name = "Be Cool"
        task1.taskDescription = "I just want to be everyone's friend and like have super cool parteeees."
        task1.isComplete = false
        task1.daysAvailable = Array.init(repeating: true, count: 7)
        task1.deadline = NSDate(timeIntervalSinceNow: 10000)
        task1.priority = Int16(7)
        task1.id = UUID()
        task1.taskDatesAndDurations = [Date(timeIntervalSinceNow: -3600): 360, Date(timeIntervalSinceNow: -14400): 1500]
        PersistenceService.saveContext()
        self.taskID = task1.id
        
        // Do any additional setup after loading the view.
        self.previousSessionsTable.delegate = self
        self.previousSessionsTable.dataSource = self
        
        previousSessionsTable.layer.borderWidth = 5
        previousSessionsTable.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        previousSessionsTable.layer.cornerRadius = 15.0
        
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
        
        // set up previous sessions
        if let sessions = task.taskDatesAndDurations {
            self.taskSessions = sortSessionsByDate(sessions: sessions)
        }

        currentCounter = FOCUS_TIME
        
        // set up buttons
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        
        self.playButton.addTarget(self, action: #selector(popStartingAlert), for: .touchDown)
        self.pauseButton.addTarget(self, action: #selector(popStartingAlert), for: .touchDown)
        
        self.taskNameLabel.text = self.task.name
        self.testImageLabel.text = self.task.name
        
        self.timerLabel.text = FOCUS_TIME.secondsToHoursMinutesSeconds()
        
        self.previousSessionsTable.reloadData()
        self.finishButton.isEnabled = false
        
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return newTaskSessions.count
        } else {
            return taskSessions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "previousSession") as! PreviousSessionCell
        let row = indexPath.row
        
        if indexPath.section == 1 {
            cell.configure(with: taskSessions[row].0, duration: taskSessions[row].1)
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.configure(with: newTaskSessions[row].0, duration: newTaskSessions[row].1)
        }
        
        
        
        
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        if newTaskSessions.count > 0 {
            
            let message  = "If you cancel now, your new sessions will not save. Do you want to still cancel?"
            let alertController = UIAlertController(title: task.name, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "No", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated:true)
            }))
            
            formatAlertController(alertController: alertController)
            formatAlertText(alertController: alertController, text: self.taskNameLabel.text!, size: 22, font: "AvenirNext-Bold", forKey: "attributedTitle")
            formatAlertText(alertController: alertController, text: message, size: 18, font: "AvenirNext-Regular", forKey: "attributedMessage")
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.dismiss(animated:true)
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        UIApplication.shared.isIdleTimerDisabled = false
        if segue.identifier == "finishSession" {
            
            let overviewVC = segue.destination as! OverviewViewController
            overviewVC.newTaskSessions = newTaskSessions
            overviewVC.taskID = taskID
            
        }
    }
    
    @objc func pauseByResign() {
        
        switch currentMode {
            
        case .focusMode:
            
            if isTimerRunning {
                startStopTimer()
            }
            
        case .breakMode:
            // add local notification in case user does not return in time after break
            
            return
            
        }
    }
    
    // MARK: - Private Functions
    
    private func startStopTimer () {
        
        animatePausePlay(isRunning: isTimerRunning)
        animateTimer()
        
        if !hasStarted {
            hasStarted = true
            UIApplication.shared.isIdleTimerDisabled = true
            UserDefaults.standard.set(Date(), forKey:"TaskStartTime")
            sessionStartTime = UserDefaults.standard.object(forKey: "TaskStartTime") as! Date
        }
        
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
        
        if currentCounter > 0 {
            currentCounter = currentCounter - 1
            timerLabel.text = currentCounter.secondsToHoursMinutesSeconds()
        } else {
            
            startStopTimer()
            
            switch currentMode {
                
            case .focusMode:
                self.currentCounter = BREAK_TIME
                self.timerLabel.text = self.currentCounter.secondsToHoursMinutesSeconds()
                currentMode = .breakMode
                popFocusDoneAlert()
                
            case .breakMode:
                currentCounter = FOCUS_TIME
                timerLabel.text = self.currentCounter.secondsToHoursMinutesSeconds()
                hasStarted = false
                fromBreak = true
                popStartingAlert()
                self.pauseButton.isEnabled = true
                currentMode = .focusMode
                
            }
        }

    }
    
    
    //MARK: - Alerts
    
    @objc func popStartingAlert() {
        if !hasStarted {
            var alertTitle : String?
            if fromBreak {
                alertTitle = "Break Over"
                fromBreak = false
            } else {
                alertTitle = task.name
            }
            let message  = "Are you ready to start a new session?"
            let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "No", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                self.finishButton.isEnabled = false
                self.hasStarted = true
                self.sessionStartTime = Date()
                self.startStopTimer()
            }))
            
            formatAlertController(alertController: alertController)
            formatAlertText(alertController: alertController, text: self.taskNameLabel.text!, size: 22, font: "AvenirNext-Bold", forKey: "attributedTitle")
            formatAlertText(alertController: alertController, text: message, size: 18, font: "AvenirNext-Regular", forKey: "attributedMessage")

            self.present(alertController, animated: true, completion: nil)
            
        } else {
            startStopTimer()
        }
    }
    

    
   func popFocusDoneAlert() {
    
        let message  = "Session Complete! Take a mandatory break or press Finish to save session."
        let alertController = UIAlertController(title: task.name, message: message, preferredStyle: .alert)
    
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            self.pauseButton.isEnabled = false
            self.finishButton.isEnabled = true
            
            self.previousSessionsTable.beginUpdates()
            self.newTaskSessions.insert((self.sessionStartTime,self.FOCUS_TIME), at: 0)
            self.previousSessionsTable.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            self.previousSessionsTable.endUpdates()
            self.startStopTimer()
            
        }))
    
        formatAlertController(alertController: alertController)
        formatAlertText(alertController: alertController, text: self.taskNameLabel.text!, size: 22, font: "AvenirNext-Bold", forKey: "attributedTitle")
        formatAlertText(alertController: alertController, text: message, size: 18, font: "AvenirNext-Regular", forKey: "attributedMessage")
    
        self.present(alertController, animated: true, completion: nil)
    
    }

    
    func formatAlertController(alertController: UIAlertController) {
        alertController.view.tintColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        alertController.view.layer.borderWidth = 3
        alertController.view.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        alertController.view.layer.cornerRadius = 15.0
        alertController.view.clipsToBounds = true
    }
    
    func formatAlertText(alertController: UIAlertController, text: String, size: CGFloat, font: String, forKey: String) {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont(name: font, size: size)!])
        alertController.setValue(myMutableString, forKey: forKey)
    }
    
    // MARK: - Private Functions
    
    private func sortSessionsByDate (sessions:[Date:Int]) ->[(Date,Int)] {
        
        return sessions.sorted { (arg0, arg1) -> Bool in
            
            let (key2, _) = arg1
            let (key1, _) = arg0
            
            return key1.timeIntervalSince(key2) < 0
        }
    }
    
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

