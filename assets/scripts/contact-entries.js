
let contrie_table = new DataTable('#main-entries-table',{order:[[0,"desc"]]});



function SubmitNewContact(e) { 
    
   
    e.preventDefault()
    $(e.target).find('.btn-loader').removeClass('d-none')
    $(e.target).find(':submit').attr('disabled',true)
    

    var _formData=new FormData($(e.target)[0])
    _formData.append('csrfmiddlewaretoken',csrf_token)
    $.ajax({
        type: "POST",
        url: "submit-new-contact",
        data: _formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (response) {
            if (response.status.success){
                
                $('#add-new-contact-modal').modal('hide')
                
                contrie_table.row.add($(response.status.new_row)).draw(false)
                contrie_table.order([0,"desc"]).draw(false)
                iziToast.success({
                    title: 'Success',
                    message: 'New contact entrie added',
                     
                    position:"bottomCenter",
                });
                $(e.target)[0].reset()
               
            }
            else{
                

                iziToast.error({
                    timeout: 20000,
                    title: 'Error',
                    overlay: true,
                    close: false,
                    message: response.status.reason,
                    displayMode: 'once',
                 
                    zindex: 10000,
                    position: 'bottomCenter',
                    buttons: [
                        ['<button><b>OK</b></button>', function (instance, toast) {
                 
                            instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                 
                        }, true],
                        
                    ],
                });


            }
            
            $(e.target).find('.btn-loader').addClass('d-none')
            $(e.target).find(':submit').attr('disabled',false)
        },
        error : function (xhr, textStatus, error) {
            iziToast.error({
                title: 'Error',
                message: error,
                 
                position:"bottomCenter",
            });

            $(e.target).find('.btn-loader').addClass('d-none')
            $(e.target).find(':submit').attr('disabled',false)
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

        if(response.data.background_image != ''){
            $('.background-previw-view').removeClass('d-none')
            $('#edit-inp-background').addClass('d-none')

            $("#edit-background-pic-preview-img")[0].src=`${window.location.origin}/media/${response.data.background_image}`
        }
        else{
            $('.background-previw-view').addClass('d-none')
            $('#edit-inp-background').removeClass('d-none')

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

function edit_remove_btn(elm,inp_btn) {

    $(elm).closest('.view').addClass('d-none')
    $('#'+inp_btn).removeClass('d-none')
    
}
 function SubmitEditContact(e) { 
    
   
    e.preventDefault()
    $(e.target).find('.btn-loader').removeClass('d-none')
    $(e.target).find(':submit').attr('disabled',true)
    

    var _formData=new FormData($(e.target)[0])
    _formData.append('csrfmiddlewaretoken',csrf_token)
    _formData.append('id',edit_id)

    $.ajax({
        type: "POST",
        url: "edit-submit-contact-entrie",
        data: _formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (response) {
            if (response.status.success){
                
                $('#edit-contact-modal').modal('hide')
                console.log(response.status.updated_row)
                $(edit_row).html(response.status.updated_row.replace(/<tr[^>]*>/g, '').replace(/<\/tr>/g, ''))
                // contrie_table.row($(edit_row)).data(['2','2','44','55','33']).draw(false)
                contrie_table.order([0,"desc"]).draw(false)
                $('#main-entries-table').DataTable()
                iziToast.success({
                    title: 'Success',
                    message: 'New contact entrie added',
                     
                    position:"bottomCenter",
                });

               
            }
            else{
                

                iziToast.error({
                    timeout: 20000,
                    title: 'Error',
                    overlay: true,
                    close: false,
                    message: response.status.reason,
                    displayMode: 'once',
                 
                    zindex: 10000,
                    position: 'bottomCenter',
                    buttons: [
                        ['<button><b>OK</b></button>', function (instance, toast) {
                 
                            instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                 
                        }, true],
                        
                    ],
                });


            }

            $(e.target).find('.btn-loader').addClass('d-none')
            $(e.target).find(':submit').attr('disabled',false)
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

$('.form-close').click(function () {
   
    $(this).closest('form')[0].reset()
})

$('#export-as-excel').click(function () {
    // var table=document.getElementById('main-entries-table')

   
    // myClone = table.cloneNode(true);

    // $(myClone).find('#th-action').remove();
    // $(myClone).find('#td-action').remove();

    // $(myClone).find('#th-user').remove();
    // $(myClone).find('#td-user').remove();
    // $(myClone).find('#th-tick').remove();
    // $(myClone).find('#td-tick').remove();
    // $(myClone).find('thead > tr ').append('<th>Signature</th>')
    // $(myClone).find('tbody > tr ').append('<td></td>')
    
//      var elt = myClone

//      var wb = XLSX.utils.table_to_book(elt, { sheet: "sheet1" });
//      return true ?
//        XLSX.write(wb, { bookType: 'xlsx', bookSST: true, type: 'base64' }):
//        XLSX.writeFile(wb,'info-id-table.' +  'xlsx');
//     

})