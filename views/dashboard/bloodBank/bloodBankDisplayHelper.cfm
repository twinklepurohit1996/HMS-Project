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
                    { data: 'name' },
                    { data: 'dob' ,
                    render: function ( data) 
                        {
                        return moment(data).format("MM-DD-YYYY");
                        } },
                    { data: 'aadhar_number'},
                    { data: 'id',render: function(data,type,row){
                        var eye = row.isActive == 1 ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'
                        return '<a href="javascript:void(0);" onclick="deleteCandidate('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a><a href="javascript:void(0);" onclick="editCandidate('+data+')" ><i class="fa-solid fa-edit text-success" ></i></a>'				
                        }
                    },
                ],
            });
    
            
       
    });

    function editCandidate(id){
          $.ajax({  url: 'bloodBank/edit/id/'+id, 
              success: function(result){
                console.log(id)
                $( "##addCandidateForm" ).validate().resetForm();
                  $("##candidateLabel").text("Edit Candidate")
                  $('##addCandidate').modal('show');
                  $('##id').val(result.id);
                  $('##candidate_name').val(result.candidate_name);
                  $('##candidate_type').val(result.candidate_type);
                  $('##mobile_number').val(result.mobile_number);
                  $('##aadhar_number').val(result.aadhar_number);
                  $('##email').val(result.email);
                  $('##blood_unit').val(result.blood_unit);
                  $(`input:radio[value='${result.gender}']`).attr('checked',true);
                  $('##blood_group_id').val(result.blood_group_id);
                  $('##dob').val(moment(result.dob).format("YYYY-MM-DD"));
                  $('##address').val(result.address);
                  $("##bb").text("Update"); 
              }
          });
    }

    function deleteCandidate(id)
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
                $.ajax({  url: 'bloodBank/delete/id/'+id, 
                        success: function(result){
                            Swal.fire(
                                'Deleted!',
                                'Your blood Bank record has been deleted.',
                                'success')
                                $('##candidateList').DataTable().ajax.reload();
                    }});
        }
    });

    }
    </script>
</cfoutput>
        
      



       



    