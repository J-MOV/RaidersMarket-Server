fetch("/stats")
	.then((response) => response.json())
	.then((data) => console.log(data));
