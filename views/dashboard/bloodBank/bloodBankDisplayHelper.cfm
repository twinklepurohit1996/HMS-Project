<cfoutput>
    <script>
       $(document).ready( function () 
       {
            $('##addCandidate').on('hidden.bs.modal', function () 
            {
                $("##candidateLabel").text("Add New Candidate")
                $("##bb").text("Insert");
                $("##id").val("0");
                $('##addCandidate form')[0].reset();
                $( "##addCandidateForm" ).validate().resetForm();

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
            )

            $("##addCandidateForm").validate
            ({
                rules:{
                    candidate_name:
                    {
                        required:true,
                        minlength:5,
                        maxlength:20,
                        validName: true,
                    },
                    candidate_type:
                    {
                        required:true,
                    },
                    mobile_number:
                    {
                        required:true,
                        minlength:10,
                        maxlength:10,
                        validMobile:true,
                        remote: {
                                    url: "bloodBank/mobCheck",
                                    type: "post",
                                    data:   {
                                                mobile_number: function() 
                                                {
                                                    return $("##mobile_number").val(); 
                                                },
                                                id: function() 
                                                {
                                                    return $("##id").val(); 
                                                }
                                            }
                                }
                    },
                    email:
                    {
                        required:true,
                        minlength:10,
                        maxlength:50,
                        remote: 
                        {
                            url: "bloodBank/emailCheck",
                            type: "post",
                            data:   {
                                        email: function() 
                                        {
                                            return $("##email").val(); 
                                        },
                                        id: function() 
                                        {
                                            return $("##id").val(); 
                                        }
                                    }
                        }
                    },
                    address:
                    {
                        required:true,
                        minlength:10,
                        maxlength:50,
                    },
                    dob:
                    {
                        required:true,
                    },
                    gender:
                    {
                        required:true,
                    },
                    blood_group_id:
                    {
                        required:true,
                    },
                    blood_unit:
                    {
                        required:true,
                    },
                    aadhar_number:
                    {
                        required:true,
                        minlength:12,
                        maxlength:12,
                        validAadhar:true,
                        remote: 
                        {
                            url: "bloodBank/aadharCheck",
                            type: "post",
                            data:   {
                                        aadhar_number: function() 
                                        {
                                            return $("##aadhar_number").val(); 
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
                    candidate_name:{
                        required:"Candidate Name is Required",
                        minlength:"Minimum Length is 5",
                        maxlength:"Maximum Length is 20",
                        validName:'Please enter a valid candidate name',
                    },
                    candidate_type:{
                        required:"Candidate Type is Required",
                    },
                    mobile_number:{
                        required:"Candidate Mobile Number is Required",
                        minlength:"Minimum Length is 10",
                        maxlength:"Maximum Length is 10",
                        validMobile:"Enter a valid mobile number",
                        remote:"Mobile Number Already Exist",
                    },
                    email:{
                        required:"Candidate Email is Required",
                        minlength:"Minimum Length is 10",
                        maxlength:"Maximum Length is 50",
                        remote: "Email Already Exist",
                    },
                    address:{
                        required:"Candidate Address is Required",
                        minlength:"Minimum Length is 10",
                        maxlength:"Maximum Length is 50",
                    },
                    dob:{
                        required:"Candidate Date of Birth is Required",
                    },
                    gender:{
                        required:"Candidate Gender is Required",
                    },
                    blood_group_id:{
                        required:"Candidate Blood Group is Required",
                    },
                    blood_unit:{
                        required:"Candidate Blood Unit is Required",
                    },
                    aadhar_number:{
                        required:"Candidate Aadhar Number is Required",
                        minlength:"Minimum Length is 12",
                        maxlength:"Maximum Length is 12",
                        validAadhar:"Please Enter a valid Aadhar Number",
                        remote:"Aadhar Number Already Exist",
                    },
            
                
                }
            
            });

            $('##candidateList').DataTable(
            {
                processing: true,
                serverSide: true,
                pageLength: 10,
                pagination: 'datatablePagination',
                ajax: {
                    url: 'bloodBank/indexData',
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
                    { data: 'candidate_name' },
                    { data: 'candidate_type' },
                    { data: 'blood_unit' },
                    { data: 'mobile_number' },
                    { data: 'gender' },
                    { data: 'blood_group_id' },
                    { data: 'dob' ,
                    render: function ( data) 
                        {
                        return moment(data).format("MM-DD-YYYY");
                        } },
                    { data: 'aadhar_number'},
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
        
      



       



    