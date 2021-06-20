var config = {
    HeaderText: 'Infinity Gaming (FiveM) | discord.gg/ig | InfinityGaming.CO.NZ',                                       /* Top Header Text */
    WelcomeBackText: 'Welcome,',                                                /* Welcome Back Text */
    CloseText: 'CLOSE',                                                         /* Close Button Text */
    CloseTextSub: 'Close this information panel.',                               /* Close Button Sub Text */
    items: [
        {
            title: 'Server Rules',                                              /* Button Title */                               
            sub: 'Please ensure you\'re aware of all our rules.',                         /* Button Sub Text */
            icon: 'fas fa-book',                                                /* Button Font Awesome Icon */
            url: 'https://infinitygaming.co.nz/topic/610-fivem-rules-guidelines/',                                           /* URL to Display */
            default: true,                                                      /* Is this the default page? */
        },
        {
            title: 'Player Guides',
            sub: 'Check out these guides to get you started.',
            icon: 'fas fa-info-circle',
            url: 'https://www.infinitygaming.co.nz/forum/42-guides/',
        },
        {
            title: 'Tebex Store',
            sub: 'Help support Infinity Gaming through our Tebex store.',
            icon: 'fas fa-shopping-basket',
            url: 'https://igrp.tebex.io',
        },
        {
            title: 'Discord',
            sub: 'Click here to join our Community discord.',
            icon: 'fab fab fa-discord',
            url: 'https://discord.gg/ig',
        },
        // {
        //     title: 'FiveM',
        //     sub: 'The coolest modification out there!',
        //     icon: 'fas fa-gamepad',
        //     url: 'https://fivem.net',                                       
        // },
    ],
}