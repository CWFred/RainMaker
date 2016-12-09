'use strict';
   
var cors = require('cors');


var Particle = require('particle-api-js');
const express = require('express');
const bodyParser = require('body-parser');
var request = require('request');
var token ;
var particle = new Particle();
var app = new express();

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



   
app.post('/tokens', (req, res) => {
    
    let login = req.body.login;
    let password = req.body.password; 
    
  particle.listAccessTokens({ username: req.body.login, password: req.body.password }).then(function(data) {
  console.log('data on listing access tokens: ', data);
}, function(err) {
  console.log('error on listing access tokens: ', err);
});
           res.sendStatus(200);
        
});






app.use(bodyParser.json({
    limit: '50mb'
}));

app.get('/', function (req, res) {
   console.log(req);
   res.send('Hello World');
});

var server = app.listen(3000);
   
   console.log("Example app listening at port 3000");
    

