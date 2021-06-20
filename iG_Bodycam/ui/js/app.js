$(document).ready(function(){
    
    $(".bodycamEMS").hide();
    window.addEventListener("message", function(event){
        if(event.data.open == true)
        {
            $(".bodycamEMS").fadeIn();
            document.getElementById("data").innerHTML = event.data.date;
            // document.getElementById("stopien").innerHTML = event.data.ranga;
            document.getElementById("dane").innerHTML = event.data.daneosoby;
        }
        else if(event.data.open == false) 
        {
            $(".bodycamEMS").fadeOut();
        }
    })
});