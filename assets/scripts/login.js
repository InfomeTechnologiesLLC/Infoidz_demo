
$('.login-inp').change(function () {
    $(':submit').addClass('btn-danger')
    $('.error-message').addClass('d-none')
    $('.login-inp').removeClass('border-danger')
})

const ValidateLogin = (e) => {

    e.preventDefault()

    var _formData=new FormData($(e.target)[0])

    _formData.append('csrfmiddlewaretoken',csrf_token)
    $.ajax({
        type: "POST",
        url: "validate-user",
        data: _formData,
        
        dataType: "json",
        contentType: false,
        processData: false,
        success: function (response) {
            if(response.status){
                window.location.href='dashboard'
            }
            else{
                $('.error-message').removeClass('d-none')
                $('.login-inp').addClass('border-danger')
                $(e.target)[0].reset()
            }
            
        }
    });
    
}