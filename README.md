# RainMaker
Capstone Design Project with Particle Electron Board  

This application uses Particle Electron 3g boards to wirelessly actuate valves connected to them. 
Developped for Ios 10 using Swift 3 , the application is able to display information about the valve such as the humidity of the soil in which it is , the air humidity , the percent chance of rainfall etc. All this information is used to automate the opening and closing of the valves without human interaction. 

The application also enables the user to view in real time the position of the board connected to the valve on a map as well as the users location. This allows the user to physically walk to a specific valve if needed. 

The backend of the application is in Node.Js and serves as an intermediary between the Particle Cloud where all of the functions of the Particle Board are exposed and the Ios Application. This server can be found in the Particle.js file in the repo. 

The code for the Particle Board can be found in the ParticleC.txt file.(C/C++) 

In order to run this project: 
1) Create a server where the Particle.js server is being run. 
2) Flash Electron Board using ParticleC.txt code using their online editor at : build.particle.io
3) Change the code in application to point to newly created server.
4) Install all Cocoapods(JTCalendar , SwiftyJson, Alamofire, ToastSwift, Spark)
5) Run Application. 

Quick Video Presentation : https://www.youtube.com/watch?v=aktC0xdgK00

