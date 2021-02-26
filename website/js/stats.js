fetch("/stats")
	.then((response) => response.json())
	.then((data) => {
        
        var html = ''

        for(var key in data){
            html += `<div class="stat"><span style="color:#c4c4c4;font-weight:600;">${key.toUpperCase()}:</span> <span style="color:rgb(255, 194, 64);">${data[key]}</span></div>`
        }

        document.getElementById("stats").innerHTML = html;

    });


