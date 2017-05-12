
//Developped by Jean Piard (CodeWarriorFred)
//Date : December 9th 2016
//Title : Rainmaker Node Server.

/*
Before trying to use this server , install the following:
1) npm
2) node.js
3) run these commands to install the necessary libraries used 
    npm install cron
    npm install request
    npm install body-parser
    npm install express
    npm install particle-api-js
    npm insrall fs
4)  hey, have fun okay buddy ?
*/

//rest of the declaration
var cors = require('cors');
var Particle = require('particle-api-js');
const express = require('express');
const bodyParser = require('body-parser');
var request = require('request');
var token ;
var particle = new Particle();
var app = new express();
var dateobject = new Date();
var CronJob = require('cron').CronJob;
var fs = require('fs');
// very very very bad, the use of global variables is not at all recommended but could not for the life of me figure out how to get these five variables to work for the weather api post request. 
global.latitude = 0;
global.longitude = 0;
global.houroffset = 0;
global.precipitationProbability = 0;
global.temperatureAtLocation= 0; 
global.humidityAtLocation=0; 


app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.static(__dirname + '/public'));
app.use(bodyParser());
app.enable('trust proxy');

// Add headers
app.use(function (req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', 'http://uhaweb.hartford.edu');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Set to true if you need the website to include cookies in the requests sent
    // to the API (e.g. in case you use sessions)
    res.setHeader('Access-Control-Allow-Credentials', true);

    // Pass to next layer of middleware
    next();
});



app.post('/login', (req, res) => {
    
    let login = req.body.login;
    let password = req.body.password; 
    
   particle.login({username: req.body.login, password: req.body.password}).then(
  function(data){
    console.log('API call completed on promise resolve: ', data.body.access_token);
      var devicesPr = particle.listDevices({ auth: data.body.access_token });

devicesPr.then(
  function(devices){
    res.send(JSON.stringify({'accessToken' : data.body.access_token,'devices': devices.body}));
  },
  function(err) {
    console.log('List devices call failed: ', err);
  }
);
  },
        
  function(err) {
    console.log('API call completed on promise fail: ', err);
  }
);       
});

app.post('/functions', (req, res) => {
    
    let devId = req.body.devId;
    let token = req.body.access_token; 
    let funcName = req.body.func_name;

    
    
  var fnPr = particle.callFunction({ deviceId: devId, name: funcName, argument: '', auth: token });

fnPr.then(
  function(data) {
    console.log('Function called succesfully:', data);
      res.send(JSON.stringify({'data' : data}));
  }, function(err) {
    console.log('An error occurred:', err);
  });
     
});

app.post('/attributes', (req, res) => {
    
    let devId = req.body.devId;
    let token = req.body.access_token; 
    
    var devicesPr = particle.getDevice({ deviceId: devId, auth: token });

devicesPr.then(
  function(data){
    console.log('Device attrs retrieved successfully:', data);
      res.send(JSON.stringify({'data' : data.body}));
  },
  function(err) {
    console.log('API call failed: ', err);
  }
);
     
});

app.post('/value', (req, res) => {
    
    console.log("value test");
  
    let devId = req.body.devId;
    let token = req.body.access_token; 
    let variableName =  req.body.variableName;

    particle.getVariable({ deviceId: devId, name: variableName, auth: token }).then(function(data) {
  console.log('Device variable retrieved successfully:', data);
        
        res.send(JSON.stringify({'variableValue':data}));
        console.log(data);
        
}, function(err) {
  console.log('An error occurred while getting attrs:', err);
});
    
   
});

app.post('/schedule', (req, res) => {
    
    console.log("schedule test");
  
    let devId = req.body.devId;
    let token = req.body.access_token; 
    let funcName =  req.body.functionName;
    let args = req.body.argument;
    let year = req.body.year;
    let month = req.body.month; 
    let day =  req.body.day;
    let hour = req.body.hour;
    let minute = req.body.minute; 
    let offset = 4;
    global.latitude =  req.body.latitude;
    global.longitude = req.body.longitude;
    
   
console.log("Arguments:"+args);
console.log("Function_Name:"+funcName);
console.log("Device_ID:"+devId);
console.log("Access_token:"+token);
console.log("Lat:"+global.latitude);
console.log("Long:"+global.longitude);
    
    
        var apiSecretKey = "c616af2a21c4b7f2f066cce3f4b9a5a4"; 
    
    // request to the weather api for hour offset. 
request({
    url: "https://api.darksky.net/forecast/c616af2a21c4b7f2f066cce3f4b9a5a4/"+global.latitude+","+global.longitude,
    method: "GET",
    json: true
}, function (error, response, body){
    global.houroffset = -1 * response.body.offset;

    var dateobject = new Date(year, month-1, day, hour, minute, 0, 0 );
     dateobject.setHours(dateobject.getHours()+global.houroffset);
     let stringobj = dateobject.toString();
     console.log(stringobj);
    
    
    
    new CronJob(dateobject, function(){
        
        
        

        // this is where to put the logic for testing for the weather. 
        // make call to darksky weather api
        // get GPS coordinates , and time 
        // if precipitation probability is higher than 75%, 
        //don't turn on the actuator 
        // the average temperature and soil humity are also tested here. 
        // This is gonna be pretty simple. 
        
    var apiSecretKey = "c616af2a21c4b7f2f066cce3f4b9a5a4"; 
    
    // request to the weather api for precipitation, temperature and humidity. 
request({
    url: "https://api.darksky.net/forecast/c616af2a21c4b7f2f066cce3f4b9a5a4/"+global.latitude+","+global.longitude,
    method: "GET",
    json: true
}, function (error, response, body){
    show_results(response,funcName,token,devId,args);
});
        
        
  
}, null, true, "UTC");
        
});
});
     
    

function show_results(response,funcname,authentication,deviceID,argument) {
    
    console.log(response.body.currently);
    
    global.precipitationProbability = response.body.currently.precipProbability*100;
    
    //for presentation
    //global.precipitationProbability = 100;
    
    
    global.temperatureAtLocation = response.body.currently.temperature;
    global.humidityAtLocation = response.body.currently.humidity;
    global.houroffset = -1 * response.body.offset; 
    
    
    console.log("Precipitation Probability in the next hour:"+global.precipitationProbability);
    console.log("Temperature in Fahrenheit at gps coordinates:"+global.temperatureAtLocation);
    console.log("Air humidity at gps coordinates:"+global.humidityAtLocation);
    console.log("Timezone offset at gps coordinates:"+global.houroffset);
    
    if(global.precipitationProbability > 0.8 || global.temperatureAtLocation < 33 || global.humidityAtLocation > 80){console.log("Not Opening Valve");}
    else{
        console.log("Opening Valve");
       var fnPr = particle.callFunction({ deviceId:deviceID, name:funcname, argument:argument, auth:authentication });

fnPr.then(
  function(data) {
    console.log('Function called succesfully:', data);
  }, function(err) {
    console.log('An error occurred:', err);
  }); 
        
    }
  
    
}


app.use(bodyParser.json({
    limit: '50mb'
}));

app.get('/', function (req, res) {
   console.log(req);
   res.send('RainMaker server running on port 9000 on Ubuntu AWS EC2');
});


var server = app.listen(9000);
   
console.log("RainMaker server running on port 9000");


