<cfoutput>
    <script>
       $(document).ready( function () {
        $("##doctor_password").attr("required", "true");   
        $("##image").attr("required", "true");

        $("##imageText").hide();
        $('##addDoctor').on('hidden.bs.modal', function () {
                $("##doctorLabel").text("Add New Doctor")
                $("##bb").text("Insert");
                $("##id").val("0");
                $('##addDoctor form')[0].reset();
                $( "##addDoctorForm" ).validate().resetForm();

        });

        $.validator.addMethod("validName", function (value, element, options){
            return /^[A-Za-z\s.]+$/.test(value);
        }
        );

        $.validator.addMethod("validMobile", function (value, element, options){
            return /^(\+\d{1,3}[- ]?)?\d{10}$/.test(value);
        }
        );

        $.validator.addMethod("validPassword", function (value, element, options){
            return /^(\+\d{1,3}[- ]?)?\d{10}$/.test(value);
        }
        );

        $.validator.addMethod("validFees", function (value, element, options){
            return /^[0-9]*$/.test(value);
        }
        );
        
        $("##addDoctorForm").validate({
        rules:{
            doctor_name:{
                required:true,
                minlength:5,
                maxlength:20,
                validName: true
            },
            doctor_education:{
                required:true,
                minlength:2,
                maxlength:100,
            },
            doctor_mobile:{
                required:true,
                minlength:10,
                maxlength:10,
                validMobile:true,
                remote: {
                url: "doctor/mobCheck",
                type: "post",
                data: {
                    doctor_mobile: function() {
                        return $("##doctor_mobile").val(); 
                    },
                    id: function() {
                        return $("##id").val(); 
                    }
                }
            }
            },
            doctor_fees:{
                required:true,
                minlength:2,
                maxlength:10,
                validFees:true,
            },
            doctor_address:{
                required:true,
                minlength:10,
                maxlength:50,
            },
            doctor_email:{
                required:true,
                minlength:10,
                maxlength:50,
                remote: {
                url: "doctor/emailCheck",
                type: "post",
                data: {
                    doctor_email: function() {
                        return $("##doctor_email").val(); 
                    },
                    id: function() {
                        return $("##id").val(); 
                    }
                }
            }
            },
            doctor_password:{
            
                minlength:5,
                maxlength:100,
                
            },
            doctor_dob:{
                required:true,
            },
         
            doctor_department_id:{
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
            doctor_name:{
                required:"Doctor Name is Required",
                minlength:"Minimum Length is 5",
                maxlength:"Maximum Length is 20",
                validName:'Please enter a valid doctor name',
            },
            doctor_education:{
                required:"Doctor Education is Required",
                minlength:"Minimum Length is 2",
                maxlength:"Maximum Length is 100",
            },
            doctor_mobile:{
                required:"Doctor Mobile is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 10",
                validMobile:"Enter a valid mobile number",
                remote:"Mobile Number Already Exist!!!",
            },
            doctor_fees:{
                required:"Doctor Fees is Required",
                minlength:"Minimum Length is 2",
                maxlength:"Maximum Length is 10",
                validFees:"Please Enter a valid doctor fees",
            },
            doctor_address:{
                required:"Doctor Address is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 100",
            },
            doctor_email:{
                required:"Doctor Email is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 50",
                remote: "Email address Already Exist!!!",
            },
            doctor_password:{
                required:"Doctor Password is Required",
                minlength:"Minimum Length is 5",
                maxlength:"Maximum Length is 20",
            },
            doctor_dob:{
                required:"Doctor Date of Birth is Required",
            },
           image:{
                required:"Doctor Image is Required",
            },
            doctor_department_id:{
                required:"Doctor Department is Required",
            },
        }
         
    });

    $('##doctorList').DataTable({
		processing: true,
        serverSide: true,
		pageLength: 10,
		pagination: 'datatablePagination',
		ajax: {
			url: 'doctor/indexData',
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
           
            { data: 'doctor_name' },
            {data:'doctor_image', 
			render: function ( data) 
				{
				return '<img src="includes/upload/doctor/'+data+'" width="30" height="30">' 
				}
            },
            { data: 'doctor_mobile' },
            { data: 'doctor_email' },
            { data: 'doctor_fees'},
            { data: 'doctor_dob' ,
			render: function ( data) 
				{
				return moment(data).format("MM-DD-YYYY");
				} },
            { data: 'department_name' },
            { data: 'id',render: function(data,type,row){
                var eye = row.isActive == 1 ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'
				return '<a href="javascript:void(0);" id="isActive"  onclick="hideDoctor('+data+')"><i class="'+eye+'"></i></a><a href="javascript:void(0);" onclick="deleteDoctor('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a><a href="javascript:void(0);" onclick="editDoctor('+data+')" ><i class="fa-solid fa-edit text-success" ></i></a>'				
			}
        },
        ],
	});


    

    $('##image').change(function(){
            const file = this.files[0];
            if (file){
            let reader = new FileReader();
            reader.onload = function(event){
                $('##imgPreview').attr('src', event.target.result);
            }
            reader.readAsDataURL(file);
            }
        });
    
});


    

function hideDoctor(data){
        $.ajax({url:'doctor/changeStatus/id/'+data,
            success: function(result){
                $('##doctorList').DataTable().ajax.reload();
            }
    });
}
    function deleteDoctor(id)
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
                $.ajax({  url: 'doctor/delete/id/'+id, 
                        success: function(result){
                            Swal.fire(
                                'Deleted!',
                                'Your doctor has been deleted.',
                                'success')
                                $('##doctorList').DataTable().ajax.reload();
                    }});
        }
    });

    }


 
    function editDoctor(id){
    $.ajax({  url: 'doctor/edit/id/'+id, 
        success: function(result){
            $( "##addDoctorForm" ).validate().resetForm();
            $("##doctorLabel").text("Edit Doctor")
            $('##addDoctor').modal('show');
            $("##doctor_password").removeAttr("required", "true");
            $("##image").removeAttr("required", "true");
            $("##imageText").show();
            $("##imgPreview").hide();

            $('##id').val(result.id);
            $('##doctor_name').val(result.doctor_name);
            $('##doctor_education').val(result.doctor_education);
            $('##imageText').val(result.doctor_image);
            $('##doctor_fees').val(result.doctor_fees);
            $('##doctor_mobile').val(result.doctor_mobile);
            $('##doctor_address').val(result.doctor_address);
            $('##doctor_email').val(result.doctor_email);
            $('##doctor_dob').val(moment(result.dob).format("YYYY-MM-DD"));
            $('##doctor_department_id').val(result.doctor_department_id);
            $("##bb").text("Update"); 
    }});
}
  




</script>
</cfoutput>
    