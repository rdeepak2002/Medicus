const request = require('request-promise');
const express = require('express')
const path = require('path');
const shell = require('shelljs');

var app = express();

var port = process.env.PORT || 8080;

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res) {									// goes to default index.html page
	res.render('index');
})

app.get('/home', function(req, res) {								// returns home page
	res.sendFile(path.join(__dirname+'/public/pages/home.html'));
})

app.get('/getDisease', function(req, res) {							// function to get disease and sending it back using http response
	var exec = require('child_process').exec;
	var command = 'wolframscript Predictor.wls';
	var child;

	exec("pwd", (error, stdout, stderr) => {
		console.log(stdout);

		command += " " + stdout;

		child = exec(command, function (err1, out, err) {
	  		console.log('output: ' + out);
	  		console.log('error: ' + err);

	  		res.send(out);

	      	if (err1 !== null) {
	        	console.log('exec error: ' + err1);
	      	}
	    });
	})
})


app.listen(port, function() {
	console.log('app running')
})