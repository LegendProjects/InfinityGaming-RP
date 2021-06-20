$(function() {
    $('.header').text(config.HeaderText);
    $('.welcomeback').text(config.WelcomeBackText);

    $.each(config.items, function( key, value ) {
        $('.sidebar').append(
            '<div class="itemContainer" data-url="' + value.url + '">\
                <div class="iconContainer">\
                    <span class="icon"><i class="' + value.icon + '"></i></span>\
                </div>\
                <div class="itemTextContainer">\
                    <div class="itemTitle"><p>' + value.title + '</p></div>\
                    <div class="itemSub"><p>' + value.sub + '</p></div>\
                </div>\
            </div>'
        );
        if(value.default == true) {
            $('.webViewer').attr('src', value.url);            
        }
    });

    $('.sidebar').append(
        '<div class="itemContainer" data-url="close">\
            <div class="iconContainer">\
                <span class="icon"><i class="fas fa-times"></i></span>\
            </div>\
            <div class="itemTextContainer">\
                <div class="itemTitle"><p>' + config.CloseText + '</p></div>\
                <div class="itemSub"><p>' + config.CloseTextSub + '</p></div>\
            </div>\
        </div>'
    );

    $('.itemContainer').click(function() {
        if($(this).data('url') == "close") {
            fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST'
        }).then(resp => resp.json()).then(resp => console.log(resp));
        } else if($(this).data('url').includes("discord.gg")) {
            fetch(`https://${GetParentResourceName()}/discord`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    url: $(this).data('url')
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
        } else {
            $('.webViewer').attr('src', $(this).data('url'));            
        }
    });

    window.addEventListener('message', function(event) {
        var item = event.data;
        if(item.type == "showMOTD") {
            var username = item.username;
            $('.username').text(username);
            $('.container').show();
        } else if(item.type == "hideMOTD") {
            $('.container').hide();
        }
    })
})
