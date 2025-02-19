
iziToast.settings({
    position: 'topCenter',
})

function update_clock()
{
    const currentTime = new Date();
    const hours = currentTime.getHours().toString().padStart(2, '0');
    const minutes = currentTime.getMinutes().toString().padStart(2, '0');
    

    const timeString = `${hours}:${minutes}`;

    $('#comman-time').text(timeString);
    
}
$('#comman-date').text(moment().format('DD-MM-YYYY'))

setInterval(update_clock, 10000);

update_clock()


$('#logout').click(function () {


    
    iziToast.warning({
        timeout: false,
        title: 'Ohh',
        overlay: true,
        close: false,
        message: "Are you sure to logout",
        displayMode: 'once',
     
        zindex: 10000,
        position: 'center',
        buttons: [
            ['<button><b>No</b></button>', function (instance, toast) {
     
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
     
            }, true],
            
            ['<button><b>Yes</b></button>', function (instance, toast) {
     
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                
                window.location.href="/portal/logout"
     
            }, true],
        ],
    });

})