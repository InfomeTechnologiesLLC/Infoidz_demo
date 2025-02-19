

const urlParams = new URLSearchParams(window.location.search);


if (urlParams.get('from') == 'login-success'){
    iziToast.success({
        title: 'Logged',
        message: 'You have successfully logged in',
    });
    urlParams.delete('from','1')

    window.history.replaceState({},"",'/portal/dashboard')
}