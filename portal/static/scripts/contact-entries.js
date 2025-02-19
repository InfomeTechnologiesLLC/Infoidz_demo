
iziToast.settings({
    position: 'topCenter',
})

const urlParams = new URLSearchParams(window.location.search);

if (urlParams.get('from')){


    if (urlParams.get('from') == 'submission-success'){

        iziToast.success({
            title: 'New Contact',
            message: 'You have successfully contact added',
        });
        
    }

    if (urlParams.get('from') == 'edit-submission-success'){

        iziToast.success({
            title: 'Edit Contact',
            message: 'You have successfully edited contact',
        });
        
    }

    urlParams.delete('from','1')

    window.history.replaceState({},"",'/portal/contact-entries')
}



let contrie_table = new DataTable('#main-entries-table',{order:[[0,"desc"]]});



function SubmitNewContact(e) {
    e.preventDefault();

    $(e.target).find('.btn-loader').removeClass('d-none');
    $(e.target).find(':submit').attr('disabled', true);

    var card_id = $('.template-style.active').attr('card-id');
    var _formData = new FormData($(e.target)[0]);

    // var croppedProfilePic = $('#cropped-profile-pic').cropper('getCroppedCanvas').toDataURL('image/jpeg'); 


    // _formData.append('cropped-profile-pic', croppedProfilePic);
    _formData.append('social_links', JSON.stringify(social_medias_array));
    _formData.append('card-id', card_id);
    _formData.append('csrfmiddlewaretoken', csrf_token);

    $.ajax({
        type: "POST",
        url: "/portal/submit-new-contact",
        data: _formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (response) {
            if (response.success) {
                let entry_id = response.entry_id;

                var cardIdInt = parseInt(card_id, 10);

                if (cardIdInt !== 1 && cardIdInt !== 2 && cardIdInt !== 3 &&  cardIdInt !== 4 && cardIdInt !== 5 && cardIdInt !== 6 && cardIdInt !== 7 && cardIdInt !== 8 && cardIdInt !== 9 && cardIdInt !== 10 && cardIdInt !== 11 && cardIdInt !== 12) {
                    iziToast.question({
                        timeout: false,
                        overlay: true,
                        displayMode: 'once',
                        id: 'question',
                        zindex: 99999,
                        title: 'Do you want to customize the card?',
                        message: 'The details have been saved. Would you like to preview or go back to the table?',
                        position: 'center',
                        buttons: [
                            ['<button><b>Yes, Preview</b></button>', function (instance, toast) {
                                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                                window.location.href = `/app/preview-card/${card_id}?edit_id=${entry_id}`;
                            }, true],
                            ['<button>No, Go to Table</button>', function (instance, toast) {
                                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                                window.location.href = '/portal/contact-entries?from=submission-success';
                            }]
                        ]
                    });
                }
                else {
                    window.open(`/app/preview-card/${card_id}?edit_id=${entry_id}`, '_blank');
                    window.location.href = '/portal/contact-entries?from=submission-success';
                }

            } else {
                iziToast.error({
                    timeout: false,
                    title: response.errorCode === 'contact_limit' ? 'Limit Exceeded' : 'Error',
                    overlay: true,
                    message: response.reason,
                    displayMode: 'once',
                    zindex: 10000,
                    position: 'center',
                    buttons: [
                        ['<button><b>OK</b></button>', function (instance, toast) {
                            instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                        }, true],
                    ],
                });
            }

            $(e.target).find('.btn-loader').addClass('d-none');
            $(e.target).find(':submit').attr('disabled', false);
        },
        error: function (xhr, textStatus, error) {
            iziToast.error({
                title: 'Error',
                message: error || 'An unexpected error occurred.',
                position: "bottomCenter",
            });

            $(e.target).find('.btn-loader').addClass('d-none');
            $(e.target).find(':submit').attr('disabled', false);
        }
    });
}




var edit_id=0
var edit_row;
 function onEditEntire (elm) {
    var id=$(elm).attr('edit-entire-id')
    edit_id=id
    edit_row=$(elm).closest('tr')
    $('.edit-get-loader').removeClass('d-none')
   $.ajax({
    type: "GET",
    url: "get-contact-entire-detail",
    data: {id:id},
    dataType: "json",
    success: function (response) {
        $('.edit-get-loader').addClass('d-none')
        console.log(response)
        $('#edit-name').val(response.data.name)
        $('#edit-personal-number').val(response.data.personal_number)
        $('#edit-office-number').val(response.data.office_number)
        $('#edit-whatsapp-number').val(response.data.whatsapp_number)
        $('#edit-email').val(response.data.email)
        $('#edit-website').val(response.data.website)
        $('#edit-location').val(response.data.location)
        $('#edit-address').val(response.data.address)
        $('#edit-designation-name').val(response.data.designation)
        $('#edit-company-name').val(response.data.company_name)

        if(response.data.profile_pic != ''){
            $('.profile-previw-view').removeClass('d-none')
            $('#edit-inp-profile-pic').addClass('d-none')

            $("#edit-profile-pic-preview-img")[0].src=`${window.location.origin}/media/${response.data.profile_pic}`
            
        }
        else{
            $('.profile-previw-view').addClass('d-none')
            $('#edit-inp-profile-pic').removeClass('d-none')

        }

        if(response.data.cover_image != ''){
            $('.cover-previw-view').removeClass('d-none')
            $('#edit-inp-cover').addClass('d-none')

            $("#edit-cover-pic-preview-img")[0].src=`${window.location.origin}/media/${response.data.cover_image}`
            
        }
        else{
            $('.cover-previw-view').addClass('d-none')
            $('#edit-inp-cover').removeClass('d-none')

        }

        
        // $('#edit-')
        
    },
    error : function (xhr, textStatus, error) {
        iziToast.error({
            title: 'Error',
            message: error,
             
            position:"bottomCenter",
        });
    }
   });
}

// function edit_remove_btn(elm,name) {

//     $(elm).closest('.edit-file-inp-view').addClass('d-none')
//     $(`[name=${name}]`).removeClass('d-none')
    
// }

function SubmitEditContact(e) { 
    e.preventDefault();

    $(e.target).find('.btn-loader').removeClass('d-none');
    $(e.target).find(':submit').attr('disabled', true);

    var card_id = $('.template-style.active').attr('card-id');
    console.log('Card ID:', card_id);  

    var _formData = new FormData($(e.target)[0]);
    _formData.append('social_links', JSON.stringify(social_medias_array));
    _formData.append('card-id', card_id);
    _formData.append('csrfmiddlewaretoken', csrf_token);
    _formData.append('id', $(e.target).attr('edit-id'));

    $.ajax({
        type: "POST",
        url: "/portal/edit-submit-contact-entrie",
        data: _formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (response) {
            if (response.success) {
                var cardIdInt = parseInt(card_id, 10);
                if (cardIdInt !== 1 && cardIdInt !== 2 && cardIdInt !== 3 && cardIdInt !== 4 && cardIdInt !== 5 && cardIdInt !== 6 && cardIdInt !== 7 && cardIdInt !== 8 && cardIdInt !== 9 && cardIdInt !== 10 && cardIdInt !== 11 && cardIdInt !== 12) {
                    iziToast.question({
                        timeout: false,
                        overlay: true,
                        close: false,
                        displayMode: 'once',
                        zindex: 99999,
                        title: 'Success',
                        message: 'Do you want to customize the card?',
                        position: 'center',
                        buttons: [
                            ['<button><b>Yes</b></button>', function (instance, toast) {
                                var editId = $(e.target).attr('edit-id');
                                var previewUrl = `/app/preview-card/${card_id}/?edit_id=${editId || ''}`;
                                window.location.href = previewUrl;
                                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                            }, true],  
                            ['<button>No</button>', function (instance, toast) {
                                window.location.href = '/portal/contact-entries?from=edit-submission-success';
                                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                            }]
                        ],
                    });
                }
                else {
                    var editId = $(e.target).attr('edit-id');
                    window.open(`/app/preview-card/${card_id}/?edit_id=${editId || ''}`, '_blank')
                    window.location.href = '/portal/contact-entries?from=edit-submission-success';
                }

                $(e.target)[0].reset();
            } else {
                iziToast.error({
                    timeout: false,
                    title: response.errorCode === 'contact_limit' ? 'Limit Exceeded' : 'Error',
                    overlay: true,
                    message: response.reason,
                    displayMode: 'once',
                    zindex: 10000,
                    position: 'center',
                    buttons: [
                        ['<button><b>OK</b></button>', function (instance, toast) {
                            instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                        }, true],
                    ],
                });
            }

            $(e.target).find('.btn-loader').addClass('d-none');
            $(e.target).find(':submit').attr('disabled', false);
        }
    });
}



function onDelteEntrie(elm) {
    iziToast.warning({
        timeout: false,
        title: 'Are you sure you want to delete this?',
        overlay: true,
        close: false,
        message: "You can't undo it!",
        displayMode: 'once',
     
        zindex: 10000,
        position: 'center',
        buttons: [
            ['<button><b>No</b></button>', function (instance, toast) {
     
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
     
            }, true],
            
            ['<button><b>Yes</b></button>', function (instance, toast) {
     
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                edit_id=$(elm).attr('entire-id')
                console.log(edit_id)
                $.ajax({
                    type: "POST",
                    url: "delete-contact-entrie",
                    data:{id:edit_id,'csrfmiddlewaretoken':csrf_token} ,
                    dataType: "json",
                    success: function (response) {
                        if (response.status.success){
                            contrie_table.row($(elm).closest('tr')).remove().draw(false)
                        }
                        else{
                            iziToast.error({
                                title: 'Error',
                                message: "somethin wrong !",
                                 
                                position:"bottomCenter",
                            });
                        }
                        
                    },
                    error:function (t,r,e) {
                        iziToast.error({
                            title: 'Error',
                            message: e,
                             
                            position:"bottomCenter",
                        });
                    }
                });
     
            }, true],
        ],
    });
    
}

function copyContactLink(elm) {

    let link=`${window.location.protocol}//${window.location.host}${$(elm).attr('link')}`

    navigator.clipboard.writeText(link).then(()=>{
        iziToast.success({
            title: 'Copied',
            message: "Contact Link Copied",         
            position:"topCenter",
        });
    })
    
}
$('.form-close').click(function () {
   
    $(this).closest('form')[0].reset()
})



$('#add-social-link-save').click(function (e) { 
    
    var social_media_id=$('#add-social-media-select').val()
    var social_media_text=$('#add-social-media-select').text()
    var social_media_link=$('#add-social-media-link').val()
    var social_media_icon=$('#add-social-media-select').find(':selected').attr('s-icon')


    if (social_media_link == '' || social_media_link == null ){

        iziToast.error({
            title: 'Warning',
            message: 'Please fill the link field to save',
        });

        return false
    }

    social_medias_array.push({
        'social_media_id':social_media_id,
        'social_media_name':social_media_text,
        'social_media_link':social_media_link,
        'social_media_icon':social_media_icon
    })


    renderSocialLinks(social_medias_array)
    

    $('#add-social-link-modal').modal('hide')

    $('#add-social-media-link').val('')
   

});

$('.template-style').click(function () {

    // var card_id=$(this).attr('card-id')

    $('.template-style').removeClass('active')

    $(this).addClass('active')

})


function renderSocialLinks(array) {
    $('#social-medias-links').html('')
    
    array.forEach(function(element,index){
      
        $('#social-medias-links').append(
            `  <div class="d-flex mb-1">
               <div class="col-2 align-items-center d-flex" style="background-color: rgba(128, 128, 128, 0.383);">
   
                   <i class="${element.social_media_icon}"></i>
   
               </div>
               <a href="${element.social_media_link}" targe="_blank" class="form-control text-primary col-8 text-truncate" > ${element.social_media_link} </a>
               <div class="col-2 align-items-center d-flex" style="background-color: rgba(128, 128, 128, 0.383);">
   
               <i class="fa-solid fa-trash text-danger" onclick="onRemoveLink(this)" index="${index}"></i>
   
               </div>
               </div>`
        )
    });

    if(array.length == 0 ){
        $('#social-medias-links').html('<p class="text-muted text-center mt-2">No links added</p>')
    }
}
function onRemoveLink(elm) {
    var index=$(elm).attr('index')
    if (index >= 0) {
        social_medias_array.splice( index, 1 );
    }

    renderSocialLinks(social_medias_array)
}
