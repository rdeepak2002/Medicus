var express = require('express')
const path = require('path');

var app = express();

var port = process.env.PORT || 8080;

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res) {
	res.render('index');
})

app.get('/home', function(req, res) {
	res.sendFile(path.join(__dirname+'/public/pages/home.html'));
})

app.listen(port, function() {
	console.log('app running')
})