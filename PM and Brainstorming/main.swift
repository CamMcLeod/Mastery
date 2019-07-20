
import Foundation
import CoreLocation



struct Goal {
    var id: String
    var name: String
    var purpose: String
    var dateOfBirth: Date
    var targetDate: Date?
    var planList: [String]  // list of id's for Plan
    
//    func percentComplete() -> Float {
//
//        let completePlans = planList.filter { (plan) -> Bool in
//            plan.isComplete
//            }.count
//        return  Float(completePlans) / Float(planList.count)
//
//    }
}


struct Plan {
    var id: String
    var name: String
    var dateOfBirth: Date
    var isComplete: Bool
    var preRequisitePlans: [String]?  // list of id's for Plan
    var targetCompletionDate: Date
    var taskList: [String]  // listi of id's for Tasks
    var purpose: String
}

struct User {
    var id: String
    var name: String
    var goals: [String]   // list of id's for Goals
    // auth values
}


struct Task {
    var id: String
    var name: String
    var taskDescription: String
    var isComplete: Bool
    var dateOfBirth: Date
    var dateOfActivity: Date
    var lengthOfActivity: Float
    var deadline: Date
    var timeEstimate: Float
    var location: CLLocation?
    var preRequisiteTasks : [String]?  // list of id's for Tasks
    
    // what is the difference between lengthOfActivity and timeEstimate?
    
}







var goalList: [String]  //list that takes in class Goal





var t1 = Task(id: UUID().uuidString,
              name: "watch lectures",
              taskDescription: "complete first 5 videos",
              isComplete: false,
              dateOfBirth: Date.init(),
              dateOfActivity: Date.init(timeIntervalSinceNow: 3600),
              lengthOfActivity: 2,
              deadline: Date.init(timeIntervalSinceNow: 3600),
              timeEstimate: 2,
              location: nil,
              preRequisiteTasks: nil)

var t2 = Task(id: UUID().uuidString,
              name: "practice assignment",
              taskDescription: "complete assignment 1",
              isComplete: false,
              dateOfBirth: Date.init(),
              dateOfActivity: Date.init(timeIntervalSinceNow: 3600),
              lengthOfActivity: 2,
              deadline: Date.init(timeIntervalSinceNow: 3600),
              timeEstimate: 2,
              location: nil,
              preRequisiteTasks: nil)

var t3 = Task(id: UUID().uuidString,
              name: "create storyboard",
              taskDescription: "create all the views that will be needed using sketch",
              isComplete: false,
              dateOfBirth: Date.init(),
              dateOfActivity: Date.init(timeIntervalSinceNow: 45000),
              lengthOfActivity: 1,
              deadline: Date.init(timeIntervalSinceNow: 45000),
              timeEstimate: 1,
              location: nil,
              preRequisiteTasks: nil)

var t4 = Task(id: UUID().uuidString,
              name: "create fake data",
              taskDescription: "need to create fake data to test before starting",
              isComplete: false,
              dateOfBirth: Date.init(),
              dateOfActivity: Date.init(timeIntervalSinceNow: 3600),
              lengthOfActivity: 2.5,
              deadline: Date.init(timeIntervalSinceNow: 3600),
              timeEstimate: 2.5,
              location: nil,
              preRequisiteTasks: nil)

var amirCourse = Plan(id: UUID().uuidString,
                  name: "Amir Course",
                  dateOfBirth: Date.init(),
                  isComplete: false,
                  preRequisitePlans: nil,
                  targetCompletionDate: Date.init(timeIntervalSinceNow: 15000),
                  taskList: [t1.id, t2.id],
                  purpose: "Learn to make an app")

var lhl = Plan(id: UUID().uuidString,
           name: "final project",
           dateOfBirth: Date.init(),
           isComplete: false,
           preRequisitePlans: nil,
           targetCompletionDate: Date.init(timeIntervalSinceNow: 3600),
           taskList: [t3.id, t4.id],
           purpose: "finish the bootcamp")


var goal1 = Goal(id: UUID().uuidString,
             name: "learn iOS",
             purpose: "I want to be a programmer",
             dateOfBirth: Date.init(),
             targetDate: Date.init(timeIntervalSinceNow: 3600),
             planList: [])



goal1.planList = [amirCourse.id, lhl.id]





var t5: Task = Task(id: UUID().uuidString,
                       name: "run 1 mile",
                       taskDescription: "run 1 mile",
                       isComplete: false,
                       dateOfBirth: Date.init(),
                       dateOfActivity: Date.init(timeIntervalSinceNow: 3600),
                       lengthOfActivity: 1,
                       deadline: Date.init(timeIntervalSinceNow: 3600),
                       timeEstimate: 1,
                       location: nil,
                       preRequisiteTasks: nil)
var t6: Task = Task(id: UUID().uuidString,
                    name: "run 2 mile",
                    taskDescription: "run 2 miles",
                    isComplete: false,
                    dateOfBirth: Date.init(),
                    dateOfActivity: Date.init(timeIntervalSinceNow: 3600),
                    lengthOfActivity: 1,
                    deadline: Date.init(timeIntervalSinceNow: 3600),
                    timeEstimate: 1,
                    location: nil,
                    preRequisiteTasks: [t5.id])

var t7: Task = Task(id: UUID().uuidString,
                    name: "deadlift",
                    taskDescription: "get a new PR with deadlift",
                    isComplete: true,
                    dateOfBirth: Date.init(),
                    dateOfActivity: Date.init(timeIntervalSinceNow: 120),
                    lengthOfActivity: 0.45,
                    deadline: Date.init(timeIntervalSinceNow: 3600),
                    timeEstimate: 1,
                    location: nil,
                    preRequisiteTasks: nil)

var t8: Task = Task(id: UUID().uuidString,
                    name: "squat",
                    taskDescription: "squat like a pro",
                    isComplete: false,
                    dateOfBirth: Date.init(),
                    dateOfActivity: Date.init(timeIntervalSinceNow: 4200),
                    lengthOfActivity: 1,
                    deadline: Date.init(timeIntervalSinceNow: 4200),
                    timeEstimate: 1,
                    location: nil,
                    preRequisiteTasks: nil)

var t9: Task = Task(id: UUID().uuidString,
                    name: "hip flexor stretch",
                    taskDescription: "they are too tight",
                    isComplete: true,
                    dateOfBirth: Date.init(),
                    dateOfActivity: Date.init(),
                    lengthOfActivity: 0.2,
                    deadline: Date.init(),
                    timeEstimate: 0.2,
                    location: nil,
                    preRequisiteTasks: nil)

var t10: Task = Task(id: UUID().uuidString,
                     name: "glutes",
                     taskDescription: "them glutes are too tight",
                     isComplete: true,
                     dateOfBirth: Date.init(),
                     dateOfActivity: Date.init(),
                     lengthOfActivity: 1,
                     deadline: Date.init(),
                     timeEstimate: 1,
                     location: nil,
                     preRequisiteTasks: nil)


var run = Plan(id: UUID().uuidString,
           name: "running",
           dateOfBirth: Date.init(),
           isComplete: false,
           preRequisitePlans: nil,
           targetCompletionDate: Date.init(timeIntervalSinceNow: 50000),
           taskList: [t5.id, t6.id],
           purpose: "Be faster than a cheetah?")

var strengthTraining = Plan(id: UUID().uuidString,
                        name: "Stregth Training",
                        dateOfBirth: Date.init(),
                        isComplete: false,
                        preRequisitePlans: nil,
                        targetCompletionDate: Date.init(timeIntervalSinceNow: 45000),
                        taskList: [t7.id, t8.id],
                        purpose: "outlift a gorilla")



var stretch = Plan(id: UUID().uuidString,
               name: "stretching",
               dateOfBirth: Date.init(),
               isComplete: false,
               preRequisitePlans: [strengthTraining.id],
               targetCompletionDate: Date.init(timeIntervalSinceNow: 238289372987),
               taskList: [t9.id, t10.id],
               purpose: "be as nimble as a ballerina")


var goal2 = Goal(id: UUID().uuidString,
                 name: "fitness",
                 purpose: "Become a beast",
                 dateOfBirth: Date.init(),
                 targetDate: Date.init(timeIntervalSinceNow: 120000),
                 planList: [run.id,
                            strengthTraining.id,
                            stretch.id])


goalList = [goal1.id, goal2.id]




var myUser = User (id: UUID().uuidString,
                   name: "Ekam",
                   goals: goalList)


print ("The user is:\n\(myUser.goals.count)")

//dump(myUser)
