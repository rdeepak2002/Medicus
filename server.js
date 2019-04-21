const express = require('express')
const path = require('path');
const shell = require('shelljs');

var app = express();

var port = process.env.PORT || 8080;

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res) {
	res.render('index');
})

app.get('/home', function(req, res) {
	var exec = require('child_process').exec;
	var command = 'wolframscript Predictor.wls';
	var child;

	child = exec(command,
   		function (error, stdout, stderr) {
      		console.log('stdout: ' + stdout);
      		console.log('stderr: ' + stderr);
      	if (error !== null) {
        	console.log('exec error: ' + error);
      	}
    });

	res.sendFile(path.join(__dirname+'/public/pages/home.html'));
})

app.listen(port, function() {
	console.log('app running')
})