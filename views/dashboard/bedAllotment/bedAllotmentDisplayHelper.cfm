<cfoutput>
    <script>
    function doctorSelect(id=0){
        var department_Id = $("##department_name").val();
        console.log(department_Id );
        $.ajax({url:'appointment/getDoctor',
        data: {"id" : department_Id},    
        success: function(result){
                var html = '<option value="" >Select Doctor</option>';
                $.each(result, function( data, value ) {
                    var selected = id > 0 ? 'selected' : '';
                    html += "<option "+selected+" value="+ parseInt(value.id)+">"+value.doctor_name+"</option>";
                });
                $('##doctor_name').html(html);
            }
        });
    }
    $(document).ready( function () {
           $("##start_date").datepicker({startDate: 'd',autoclose: true}).datepicker("setDate",'now');
           $("##end_date").datepicker({startDate: 'd',autoclose: true});


            $('##addAppointment').on('hidden.bs.modal', function () {
                $( "##addAppointmentForm" ).validate().resetForm();
                    $('##addAppointmentForm')[0].reset();
                    $(".datepicker").datepicker({startDate: 'd',autoclose: true}).datepicker("setDate",'now');

                });
            $("##bedAllotmentForm").validate({
                rules:{
                    patient_id:{
                        required:true,
                    },
                    department_id:{
                        required:true,
                    },
                    bed_number:{
                        required:true,
                    },
                    start_date:{
                        required:true,
                    },
                    end_date:{
                        required:true,
                    }, 
                },
                highlight: function(element) 
                {  
                    $(element).closest('.form-select').removeClass('has-success').addClass('has-error');
                },
                unhighlight: function(element) 
                { 
                    $(element).closest('.form-select').removeClass('has-error').addClass('has-success');
                },
                messages:{
                    patient_id:{
                        required:"Patient Name is Required",
                    },
                    department_id:{
                        required:"Department Name is Required",
                    },
                    bed_number:{
                        required:"Doctor Name is Required",
                    },
                    start_date:{
                        required:"Start Date is Required",
                    },
                    end_date:{
                        required:"End Date is Required",
                    },
                }  
            });

      $("##department_id").change(function(){
                var department_Id = $("##department_id option:selected").val();
                console.log(department_Id);
                $.ajax({url:'bedAllotment/getBed/id/'+department_Id,
                    success: function(result){
                        console.log(result);
                        var html = '<option value="" >Select Bed Number</option>';
                        $.each(result, function( data, value ) {
                            for(i=1;i<=value.department_bed_total;i++)
                            {
                                html += "<option  value="+i+">"+i+"</option>";
                            }
                        });
                        $('##bed_number').html(html);
                    }
                });
                $.ajax({url:'bedAllotment/getPatient/id/'+department_Id,
                    success: function(result){
                        console.log(result);
                        var html = '<option value="" >Select Patinet</option>';
                        $.each(result, function( data, value ) {
                                html += "<option  value="+value.patient_id+">"+value.patient_name
+"</option>";
                        });
                        $('##patient_id').html(html);
                    }
                });
            });  

         /*    $("##department_id").change(function(){
                var department_Id = $("##department_id option:selected").val();
                // console.log(department_Id);
                $.ajax({url:'bedAllotment/getPatient/id/'+department_Id,
                    success: function(result){
                        console.log(result);
                        var html = '<option value="" >Select Patinet</option>';
                        $.each(result, function( data, value ) {
                                html += "<option  value="+value.patient_id+">"+value.patient_id+"</option>";
                        });
                        $('##bed_number').html(html);
                    }
                });
            }); */


            $('##bedAllotmentList').DataTable({
                processing: true,
                serverSide: true,
                pageLength: 10,
                pagination: 'datatablePagination',
                ajax: {
                    url: 'bedAllotment/indexData',
                    data: function(d){
                        var m = {};
                        m['draw'] = d.draw;
                        m["start"] = d.start;
                        m["length"] = d.length;
                        m["search"] = d.search.value;
                        m["order"] = d.columns[d.order[0].column].data + ' ' + d.order[0].dir;
                        return m;
                    }
                },
                columns: [
                    { data: 'patient_token_id' },
                    { data: 'patient_name' },
                    {data: 'department_name'},
                    { data: 'id',render: function(data){
                        // console.log(data);
                        return '<a href="javascript:void(0);"><button  class="btn-success mx-3">Admit</button><button class="btn-danger">Discharge</button></i></a>'				
                    }},
                ],
            });
    });



    //     function deleteAppointment(id)
    // {
    //     Swal.fire({
    //     title: 'Are you sure ?',
    //     text: "You won't be able to revert this!",
    //     icon: 'warning',
    //     showCancelButton: true,
    //     confirmButtonColor: '##3085d6',
    //     cancelButtonColor: '##d33',
    //     confirmButtonText: 'Yes, delete it!'
    //     }).then((result) => 
    //     {
    //         if (result.isConfirmed) 
    //         {
    //             $.ajax({  url: 'appointment/delete/id/'+id, 
    //                     success: function(result){
    //                         Swal.fire(
    //                             'Deleted!',
    //                             'Your appointment has been deleted.',
    //                             'success')
    //                             $('##appointmentList').DataTable().ajax.reload();
    //                 }});
    //     }
    // });

    // }


    


    


 
    
  




</script>
</cfoutput>
    