# Mastery

Mastery is a goal tracking app. The application allows the user to create goals and tasks for those goals. When the user wishes to commit time to intentional focus on a task, they choose an amount of time to focus on the task, then begin a session of directed focus.

My reponsibilities in the project included completion of the "Today's Tasks" and focus side of the app, as well as designing the icon picker view, Xibs and animations. 

We needed the icons of each task to represent the goal they belonged to (consistent color scheme) and have their design easily reflect to the user the completion of the task as well as the purpose of the task itself. This lead us to a task icon and  "task ring" design. The icon and ring widget was designed to be color coded to the tasks corresponding goal color. Below is the icon selection view and animation:

![Alt Text](readme%20files/selectIcon.gif)

Below are the various animations of the icon and "task ring" widget:

![Alt Text](readme%20files/animationSample.gif)

Below is the landing screen of the "Today's Tasks" side of the app. This is where the user can see tasks they have created which are available to complete today. When a user creates a task they decide which days of the week they are available to work on it, this is reflected in this view. 

Tasks can be sorted by priority and by deadline. Priority is represented by the fractional fill of the task ring out of 10. Deadline is represented by a task ring whose arc is masked depending on time remaining to the task deadline:

![Alt Text](readme%20files/Sort.gif)

In the below image there is a task "fence" where the user has chosen a 25 minute focus time:

![Alt Text](readme%20files/4-inch%20Screenshot%201.jpg)

In the below image the user has completed their task "weightlifting" and has moved on to their mandatory 5 minute break. If the user sends the app to the background or locks their phone, the app will send a notification when the break is over:

![Alt Text](readme%20files/4-inch%20Screenshot%202.jpg)

A user can start a session for a task: 

![Alt Text](readme%20files/startASession.gif)

When the task ends the user begins a mandatory break:

![Alt Text](readme%20files/sessionEnds.gif)

The user can then add a note for the recorded session:

![Alt Text](readme%20files/addANote1.gif)
![Alt Text](readme%20files/addANote2.gif)
