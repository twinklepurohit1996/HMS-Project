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
        $(".datepicker").datepicker({startDate: 'd',autoclose: true}).datepicker("setDate",'now');
        $('##addAppointment').on('hidden.bs.modal', function () {
            $( "##addAppointmentForm" ).validate().resetForm();
                $('##addAppointmentForm')[0].reset();
                $(".datepicker").datepicker({startDate: 'd',autoclose: true}).datepicker("setDate",'now');

            });
        $("##addAppointmentForm").validate({
            rules:{
                patient_name:{
                    required:true,
                },
                department_name:{
                    required:true,
                },
                doctor_name:{
                    required:true,
                },
                appointment_date:{
                    required:true,
                }, 
            },
            highlight: function(element) {   // <-- fires when element has error
                $(element).closest('.form-select').removeClass('has-success').addClass('has-error');
            },
            unhighlight: function(element) { // <-- fires when element is valid
                $(element).closest('.form-select').removeClass('has-error').addClass('has-success');
            },
            messages:{
                patient_name:{
                    required:"Patient Name is Required",
                },
                department_name:{
                    required:"Department Name is Required",
                },
                doctor_name:{
                    required:"Doctor Name is Required",
                },
                appointment_date:{
                    required:"Appointment Date is Required",
                },
            }  
        });

         $("##department_name").change(function(){
            var department_Id = $("##department_name option:selected").val();
            $.ajax({url:'appointment/getDoctor/id/'+department_Id,
                success: function(result){
                    var html = '<option value="" >Select Doctor</option>';
                    $.each(result, function( data, value ) {
                        html += "<option  value="+value.id+">"+value.doctor_name+"</option>";
                    });
                    $('##doctor_name').html(html);
                }
            });
         }); 
        $('##appointmentList').DataTable({
            processing: true,
            serverSide: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            ajax: {
                url: 'appointment/indexData',
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
                { data: 'patient_name' },
                { data: 'department_name' },
                {data: 'doctor_name'},
                {data:'patient_token_id'},
                {data: 'appointment_date',
                render: function ( data) 
                    {
                    return moment(data).format("MM-DD-YYYY");
                    }},
                {data: 'appointment_time',
                render: function ( data) 
                    {
                    return moment(data).format("hh:mm:ss");
                    }},
                { data: 'id',render: function(data){
                    return '<a href="javascript:void(0);" onclick="deleteAppointment('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a>'				
                }},
            ],
	    });
    });



        function deleteAppointment(id)
    {
        Swal.fire({
        title: 'Are you sure ?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '##3085d6',
        cancelButtonColor: '##d33',
        confirmButtonText: 'Yes, delete it!'
        }).then((result) => 
        {
            if (result.isConfirmed) 
            {
                $.ajax({  url: 'appointment/delete/id/'+id, 
                        success: function(result){
                            Swal.fire(
                                'Deleted!',
                                'Your appointment has been deleted.',
                                'success')
                                $('##appointmentList').DataTable().ajax.reload();
                    }});
        }
    });

    }


    


    


 
    
  




</script>
</cfoutput>
    