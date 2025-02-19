iziToast.settings({
    position: 'topCenter',
})
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
        success: function (res) {

        if (res.success == false){

                if (res.ErrorCode =="user_not_found"){
                        $('.login-inp').addClass('border-danger')
                        $(e.target)[0].reset()

                    iziToast.error({
                        title: 'User Not Found',
                        message: res.reason,
                    });
                }

                if (res.ErrorCode =="expiry_date"){
            
                    window.location.href='/portal/plan-expired?from=login-success'
                }
         }
         else{
            window.location.href='/portal/dashboard?from=login-success'
         }
           
          
           
        },
      
    });
    
}