$('document').ready(function() {
    alerts = {};
    

    window.addEventListener('message', function (event) {
        ShowNotif(event.data);
    });

    function ShowNotif(data) {
            var $notification = CreateNotification(data);
            $('.notif-container').append($notification);
            setTimeout(function() {
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove()
                });
            }, data.length != null ? data.length : 2500);
    }



    function CreateNotification(data) {
        var $notification = $(document.createElement('div'));
        //$notification.addClass('notification').addClass(data.type);
        $notification.addClass('notification').addClass(data.style);
        //$notification.html(data.text);
        if (data.style == 'officer-down') {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-player"><i class="fas fa-address-card"></i>' + data.info["player"] + '</div>\
            </div>');
        } else if (data.style == 'medic-down') {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-player"><i class="fas fa-address-card"></i>' + data.info["player"] + '</div>\
            </div>');
        } else if (data.style == 'backup-request') {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-player"><i class="fas fa-address-card"></i>' + data.info["player"] + '</div>\
            </div>');
        } else if (data.style == 'stolen-vehicle') {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-vehicleLabel"><i class="fas fa-car"></i>' + data.info["vehicle-label"] + '</div>\
            <div id="alert-vehiclePlate"><i class="fas fa-closed-captioning"></i>' + data.info["vehicle-plate"] + '</div>\
            </div>');
        } else if (data.style == 'traffic-violation') {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + ' (' + data.info["vehicle-speed"] + 'km/h)' + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-vehicleLabel"><i class="fas fa-car"></i>' + data.info["vehicle-label"] + '</div>\
            </div>');
        } else {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            </div>');
        }
        $notification.fadeIn();
        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function(css) {
                $notification.css(css, data.style[css])
            });
        }
        return $notification;
    }









    alerts.BaseAlert = function(style, info) {
        switch(style) {
            case 'ems':
               alerts.EMSAlert(info)
            break;
            case 'police':
                alerts.PoliceAlert(info)
            break;
            case 'backup-request':
                alerts.PoliceAlert(info)
            break;
            case 'stolen-vehicle':
                alerts.StolenVehicle(info)
            break;
            case 'traffic-violation':
                alerts.TrafficViolation(info)
            break;
            case 'robbery':
                alerts.RobberyAlert(info)
            break;
            case 'officer-down':
                alerts.OfficerDownAlert(info)
            break;
        }
    };

    alerts.PoliceAlert = function(info) {
        
        $('.alerts-wrapper').html('\
        <div class="police">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };

    alerts.EMSAlert = function(info) {
        //console.log(info["code"])
        $('.alerts-wrapper').html('\
        <div class="alerts ems">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-skull-crossbones"></i> ' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };

    alerts.RobberyAlert = function(info) {
        $('.alerts-wrapper').html('\
        <div class="robbery">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };

    alerts.BackupAlert = function(info) {
        $('.alerts-wrapper').html('\
        <div class="backup-request">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-player"><i class="fas fa-id-badge"></i>' + info["player"] + '</div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };
    
    alerts.StolenVehicle = function(info) {
        
        $('.alerts-wrapper').html('\
        <div class="stolen-vehicle">\
        <div class="content">\
        <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
        <div id="alert-vehicleLabel"><i class="fas fa-car"></i>' + data.info["vehicle-label"] + '</div>\
        <div id="alert-vehiclePlate"><i class="fas fa-closed-captioning"></i>' + data.info["vehicle-plate"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };

    alerts.TrafficViolation = function (info) {

        $('.alerts-wrapper').html('\
        <div class="traffic-violation">\
        <div class="content">\
        <div id="code">' + data.info["code"] + '</div><div id="alert-name">' + data.info["name"] + data.info["vehicle-speed"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
        <div id="alert-vehicleLabel"><i class="fas fa-car"></i>' + data.info["vehicle-label"] + '</div>\
        </div>').fadeIn(1000);

        setTimeout(HideAlert, 4500);
    };

    alerts.OfficerDownAlert = function(info) {
        $('.alerts-wrapper').html('\
        <div class="officer-down">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-player"><i class="fas fa-id-badge"></i>' + info["player"] + '</div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };


    function HideAlert() {
        $('.alerts-wrapper').fadeOut(1000);
    };

    /*window.addEventListener('message', function(event) {
        //console.log(event.data.action + " " + event.data.style)
        switch(event.data.action) {
            case 'display':
                //console.log("We've been called for this one")
                alerts.BaseAlert(event.data.style, event.data.info)
            break;
        }
    });*/
});