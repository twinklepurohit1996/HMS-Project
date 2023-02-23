<cfoutput>
    <script>
       $(document).ready( function () 
       {
            $("##patient_password").attr("required", "true");                      
            $('##addPatient').on('hidden.bs.modal', function () 
            {
                $("##patientLabel").text("Add New Patient")
                $("##bb").text("Insert");
                $("##id").val("0");
                $('##addPatient form')[0].reset();
                $( "##addPatientForm" ).validate().resetForm();

            });
            $.validator.addMethod("validName", function (value, element, options){
                return /^[A-Za-z\s.]+$/.test(value);
            }
            );

            $.validator.addMethod("validMobile", function (value, element, options){
                return /^(\+\d{1,3}[- ]?)?\d{10}$/.test(value);
            }
            );

            $.validator.addMethod("validAadhar", function (value, element, options){
                return /^(\+\d{1,3}[- ]?)?\d{12}$/.test(value);
            }
            );

            $.validator.addMethod("validPassword", function (value, element, options){
                return /^(?=.*\d).{4,8}$/.test(value);
            }
            );

            $("##addPatientForm").validate
            ({
                rules:{
                    patient_name:
                    {
                        required:true,
                        minlength:5,
                        maxlength:20,
                        validName: true,
                    },
                    patient_mobile:
                    {
                        required:true,
                        minlength:10,
                        maxlength:10,
                        validMobile:true,
                        remote: {
                                    url: "patient/mobCheck",
                                    type: "post",
                                    data:   {
                                                patient_mobile: function() 
                                                {
                                                    return $("##patient_mobile").val(); 
                                                },
                                                id: function() 
                                                {
                                                    return $("##id").val(); 
                                                }
                                            }
                                }
                    },
                    patient_email:
                    {
                        required:true,
                        minlength:10,
                        maxlength:50,
                        remote: 
                        {
                            url: "patient/emailCheck",
                            type: "post",
                            data:   {
                                        patient_email: function() 
                                        {
                                            return $("##patient_email").val(); 
                                        },
                                        id: function() 
                                        {
                                            return $("##id").val(); 
                                        }
                                    }
                        }
                    },
                    patient_password:
                    {
                        minlength:4,
                        maxlength:8,
                    
                    },
                    patient_address:
                    {
                        required:true,
                        minlength:10,
                        maxlength:50,
                    },
                    patient_dob:
                    {
                        required:true,
                    },
                    patient_gender:
                    {
                        required:true,
                    },
                    patient_blood_group_id:
                    {
                        required:true,
                    },
                    patient_aadhar_no:
                    {
                        required:true,
                        minlength:12,
                        maxlength:12,
                        validAadhar:true,
                        remote: 
                        {
                            url: "patient/aadharCheck",
                            type: "post",
                            data:   {
                                        patient_aadhar_no: function() 
                                        {
                                            return $("##patient_aadhar_no").val(); 
                                        },
                                        id: function() 
                                        {
                                            return $("##id").val(); 
                                        }
                                    }
                        }
                    }
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
                        minlength:"Minimum Length is 5",
                        maxlength:"Maximum Length is 20",
                        validName:'Please enter a valid patient name',
                    },
                    patient_mobile:{
                        required:"Patient Mobile is Required",
                        minlength:"Minimum Length is 10",
                        maxlength:"Maximum Length is 10",
                        validMobile:"Enter a valid mobile number",
                        remote:"Mobile Number Already Exist",
                    },
                    patient_email:{
                        required:"Patient Email is Required",
                        minlength:"Minimum Length is 10",
                        maxlength:"Maximum Length is 50",
                        remote: "Email Already Exist",
                    },
                    patient_password:{
                        required:"Patient Password is Required",
                        minlength:"Minimum Length is 4",
                        maxlength:"Maximum Length is 8",
                    },
                    patient_address:{
                        required:"Patient Address is Required",
                        minlength:"Minimum Length is 10",
                        maxlength:"Maximum Length is 50",
                    },
                    patient_dob:{
                        required:"Patient Date of Birth is Required",
                    },
                    patient_gender:{
                        required:"Patient Gender is Required",
                    },
                    patient_blood_group_id:{
                        required:"Patient Blood Group is Required",
                    },
                    patient_aadhar_no:{
                        required:"patient Aadhar Number is Required",
                        minlength:"Minimum Length is 12",
                        maxlength:"Maximum Length is 12",
                        validAadhar:"Please Enter a valid Aadhar Number",
                        remote:"Aadhar Number Already Exist",
                    },
            
                
                }
            
            });

            $('##patientList').DataTable(
            {
                processing: true,
                serverSide: true,
                pageLength: 10,
                pagination: 'datatablePagination',
                ajax: {
                    url: 'patient/indexData',
                    data: function(d){
                        console.log(d);
                        var m = {};
                        m['draw'] = d.draw;
                        m["start"] = d.start;
                        m["length"] = d.length;
                        m["search"] = d.search.value;
                        m["order"] = d.columns[d.order[0].column].data + ' ' + d.order[0].dir;
                        return m;
                    }
                },
                columns: 
                [
                    { data: 'patient_name' },
                    { data: 'patient_mobile' },
                    { data: 'patient_email' },
                    { data: 'patient_gender' },
                    { data: 'name' },
                    { data: 'patient_dob' ,
                    render: function ( data) 
                        {
                        return moment(data).format("MM-DD-YYYY");
                        } },
                    { data: 'patient_aadhar_no'},
                    { data: 'id',render: function(data,type,row){
                        var eye = row.isActive == 1 ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'
                        return '<a href="javascript:void(0);" onclick="deletePatient('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a><a href="javascript:void(0);" onclick="editPatient('+data+')" ><i class="fa-solid fa-edit text-success" ></i></a>'				
                        }
                    },
                ],
            });
    
            
       
    });

    function editPatient(id){
          $.ajax({  url: 'patient/edit/id/'+id, 
              success: function(result){
                console.log(id)
                $( "##addPatientForm" ).validate().resetForm();
                  $("##patientLabel").text("Edit Patient")
                  $('##addPatient').modal('show');
                  $("##patient_password").removeAttr("required", "true");
                  $('##id').val(result.id);
                  $('##patient_name').val(result.patient_name);
                  $('##patient_email').val(result.patient_email);
                  $('##patient_mobile').val(result.patient_mobile);
                  $('##patient_address').val(result.patient_address);
                  $(`input:radio[value='${result.patient_gender}']`).attr('checked',true);
                  $('##patient_blood_group_id').val(result.patient_blood_group_id);
                  $('##patient_dob').val(moment(result.patient_dob).format("YYYY-MM-DD"));
                  $('##patient_aadhar_no').val(result.patient_aadhar_no);
                  $("##bb").text("Update"); 
              }
          });
    }

    function deletePatient(id)
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
                $.ajax({  url: 'patient/delete/id/'+id, 
                        success: function(result){
                            console.log(result);
                            if(result==false)
                            {
                                Swal.fire(
                                'Warning!',
                                'Appointment is already assigned this patient!!',
                                'warning')                          
                            }
                            else
                            {
                                Swal.fire(
                                'Deleted!',
                                'Your Patient has been deleted.',
                                'success')
                                $('##patientList').DataTable().ajax.reload();  
                                    
                            }
            }});
        }
    });

    }
    </script>
</cfoutput>
        
      



       



    