'use strict';
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
    npm install cors
    npm install particle-api-js
4)  hey, have fun okay buddy ?
*/

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

    
    
  var fnPr = particle.callFunction({ deviceId: devId, name: funcName, argument: 'D0:HIGH', auth: token });

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
   
console.log(devId);
console.log(token);
    
     dateobject = new Date(year, month-1, day, hour, minute, 0, 0 )
     dateobject.setHours(dateobject.getHours() + 4);
     let stringobj = dateobject.toString();
     console.log(stringobj);
    
    
    new CronJob(dateobject, function(){
        
            
  var fnPr = particle.callFunction({ deviceId: devId, name: funcName, argument: 'D0:HIGH', auth: token });

fnPr.then(
  function(data) {
    console.log('Function called succesfully:', data);
      res.send(JSON.stringify({'data' : data}));
  }, function(err) {
    console.log('An error occurred:', err);
  });
        
        
    console.log("Kaka santi");
        
}, null, true, "UTC");
    
});


app.use(bodyParser.json({
    limit: '50mb'
}));

app.get('/', function (req, res) {
   console.log(req);
   res.send('RainMaker server running on port 9000 on Ubuntu AWS EC2');
});

var server = app.listen(9000);
   
   console.log("RainMaker server running on port 9000");


