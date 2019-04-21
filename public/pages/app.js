$(function() {												// wait for document to be ready
	getDisease();
});

function getDisease() {
	console.log("making http request");

	$.get("/getDisease", function(data, status) {			// make http request to getDisease
    	if(status == "success") {
    		$("#output").text(data);
    	}
    	else {
    		alert("Error making http request to server.");
    	}
	});
}