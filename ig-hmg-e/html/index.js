$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    let playingGame 
    let progress = 0;
    let fails = 0;
    let timerStarted = false;

    async function countdown() {
        //document.getElementById('timer').style.width = '480px';
        let timerWidth = '405';
        for (i = 0; i < 405; i++) {
            if (playingGame) {
                timerStarted = true;
                timerWidth = timerWidth - 1
                document.getElementById('timer').style.width = timerWidth + 'px';
                await sleep(8)
                if (timerWidth === 0) {
                    playingGame = false;
                    timerStarted = false;
                    $.post("https://ig-hmg-e/error", JSON.stringify({
                        error: "You took too long!"
                    }))
                }
            } else {
                timerStarted = false;
                break;
            }
        }
    }

    async function redColour(one, two, three, four, five, six) {
        document.getElementById(one).style.backgroundColor='rgb(255,0,0)';
        document.getElementById(two).style.backgroundColor='rgb(255,0,0)';
        document.getElementById(three).style.backgroundColor='rgb(255,0,0)';
        document.getElementById(four).style.backgroundColor='rgb(255,0,0)';
        document.getElementById(five).style.backgroundColor='rgb(255,0,0)';
        document.getElementById(six).style.backgroundColor='rgb(255,0,0)';
        await sleep(3000)
        document.getElementById(one).style.backgroundColor='';
        document.getElementById(two).style.backgroundColor='';
        document.getElementById(three).style.backgroundColor='';
        document.getElementById(four).style.backgroundColor='';
        document.getElementById(five).style.backgroundColor='';
        document.getElementById(six).style.backgroundColor='';
        countdown()
    }

    async function startGame() {
        arr = [];
        while(arr.length < 25){
            var r = Math.floor(Math.random() * 25) + 1;
            if(arr.indexOf(r) === -1) arr.push(r);
        }
        for (i = 1; i < 26; i++) {
            document.getElementById(i).style.backgroundColor='';
        }
        redColour(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5]);
        document.getElementById('timer').style.width = '405px';
        playingGame = true;
        progress = 0;
        fails = 0;
        while (playingGame) {
            await sleep(1)
            if (document.getElementById(arr[0]).style.backgroundColor == 'rgb(0, 255, 0)' && document.getElementById(arr[1]).style.backgroundColor == 'rgb(0, 255, 0)' && document.getElementById(arr[2]).style.backgroundColor == 'rgb(0, 255, 0)' && document.getElementById(arr[3]).style.backgroundColor == 'rgb(0, 255, 0)' && document.getElementById(arr[4]).style.backgroundColor == 'rgb(0, 255, 0)' && document.getElementById(arr[5]).style.backgroundColor == 'rgb(0, 255, 0)') {
                $.post("https://ig-hmg-e/error", JSON.stringify({
                    error: "Complete!"
                }))
                playingGame = false;
            } else if (document.getElementById(arr[6]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[7]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[8]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[9]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[10]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[11]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[12]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[13]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[14]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[15]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[16]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[17]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[18]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[19]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[20]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[21]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[22]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[23]).style.backgroundColor == 'rgb(0, 255, 0)' || document.getElementById(arr[24]).style.backgroundColor == 'rgb(0, 255, 0)') {
                $.post("https://ig-hmg-e/error", JSON.stringify({
                    error: "Failed!"
                }))
                playingGame = false;
            }
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                startGame()
            } else {
                display(false)
            }
        }
    })

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            playingGame = false
            $.post('https://ig-hmg-e/exit', JSON.stringify({}));
            return
        }
    };

    $('#1, #2, #3, #4, #5, #6, #7, #8, #9, #10, #11, #12, #13, #14, #15, #16, #17, #18, #19, #20, #21, #22, #23, #24, #25').click(function () {
        var i;
        if (playingGame && timerStarted) {
            for (i = 1; i < 26; i++) {
                if (this.id == i) {
                    document.getElementById(i).style.backgroundColor='rgb(0,255,0)';
                }
            }
        }
    });

})