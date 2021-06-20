Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000*5)
		
        exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-primary alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fas fa-info-circle faa-bounce animated\"></i><strong>Skills System</strong><br>Indulge yourself into our skills system.<br>We have 10 skills to offer with more coming soon for your enjoyment!<br>Tutorials are avaliable on our forums.<br>https://www.infinitygaming.co.nz/</div>", type = "info", timeout = 9000, layout = "centerLeft", queue = "left"})

        Citizen.Wait(60000*5)

        exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-primary alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fas fa-info-circle faa-bounce animated\"></i><strong>Whitelisted Employment</strong><br>Looking to become a Police Officer?<br>Want to help people as a Paramedic?<br>Fill out an application on the forums.<br>https://www.infinitygaming.co.nz/</div>", type = "info", timeout = 9000, layout = "centerLeft", queue = "left"})

        Citizen.Wait(60000*5)

        exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-primary alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fas fa-info-circle faa-bounce animated\"></i><strong>Tutorials & Guides</strong><br>Kickstart your adventure by checking out our guides on the forums.<br>https://www.infinitygaming.co.nz/</div>", type = "info", timeout = 9000, layout = "centerLeft", queue = "left"})

        Citizen.Wait(60000*5)

        exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-primary alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fas fa-info-circle faa-bounce animated\"></i><strong>Get Involved</strong><br>Looking to join the staff team?<br>Want to help with server development?<br>https://www.infinitygaming.co.nz/</div>", type = "info", timeout = 9000, layout = "centerLeft", queue = "left"})
        
        Citizen.Wait(60000*5)
        
        exports.pNotify:SendNotification({text = "<div class=\"alert fade alert-simple alert-primary alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show\" role=\"alert\" data-brk-library=\"component__alert\"><i class=\"start-icon fas fa-info-circle faa-bounce animated\"></i><strong>What button does what?</strong><br>Type /keybinds to see a list of key-mapping for our server.</div>", type = "info", timeout = 9000, layout = "centerLeft", queue = "left"})

    end
end)