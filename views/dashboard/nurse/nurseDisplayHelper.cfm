<cfoutput>
    <script>
       $(document).ready( function () {
        $("##nurse_password").attr("required", "true");   
        $("##image").attr("required", "true");

        $("##imageText").hide();
        $('##addNurse').on('hidden.bs.modal', function () {
                $("##nurseLabel").text("Add New Nurse")
                $("##bb").text("Insert");
                $("##id").val("0");
                $('##addNurse form')[0].reset();
                $( "##addNurseForm" ).validate().resetForm();

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
        
        $("##addNurseForm").validate({
        rules:{
            nurse_name:{
                required:true,
                minlength:5,
                maxlength:20,
                validName: true
            },
            nurse_education:{
                required:true,
                minlength:2,
                maxlength:100,
            },
            nurse_mobile:{
                required:true,
                minlength:10,
                maxlength:10,
                validMobile:true,
                remote: {
                url: "nurse/mobCheck",
                type: "post",
                data: {
                    nurse_mobile: function() {
                        return $("##nurse_mobile").val(); 
                    },
                    id: function() {
                        return $("##id").val(); 
                    }
                }
            }
            },
            nurse_address:{
                required:true,
                minlength:10,
                maxlength:50,
            },
            nurse_email:{
                required:true,
                minlength:10,
                maxlength:50,
                remote: {
                url: "nurse/emailCheck",
                type: "post",
                data: {
                    nurse_email: function() {
                        return $("##nurse_email").val(); 
                    },
                    id: function() {
                        return $("##id").val(); 
                    }
                }
            }
            },
            nurse_password:{
            
                minlength:5,
                maxlength:100,
                
            },
            nurse_dob:{
                required:true,
            },
         
            nurse_department_id:{
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
            nurse_name:{
                required:"Nurse Name is Required",
                minlength:"Minimum Length is 5",
                maxlength:"Maximum Length is 20",
                validName:'Please enter a valid nurse name',
            },
            nurse_education:{
                required:"Nurse Education is Required",
                minlength:"Minimum Length is 2",
                maxlength:"Maximum Length is 100",
            },
            nurse_mobile:{
                required:"Nurse Mobile is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 10",
                validMobile:"Enter a valid mobile number",
                remote:"Mobile Number Already Exist!!!",
            },
            nurse_address:{
                required:"Nurse Address is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 100",
            },
            nurse_email:{
                required:"Nurse Email is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 50",
                remote: "Email address Already Exist!!!",
            },
            nurse_password:{
                required:"Nurse Password is Required",
                minlength:"Minimum Length is 5",
                maxlength:"Maximum Length is 20",
            },
            nurse_dob:{
                required:"Nurse Date of Birth is Required",
            },
           image:{
                required:"Nurse Image is Required",
            },
            nurse_department_id:{
                required:"Nurse Department is Required",
            },
        }
         
    });

    $('##nurseList').DataTable({
		processing: true,
        serverSide: true,
		pageLength: 10,
		pagination: 'datatablePagination',
		ajax: {
			url: 'nurse/indexData',
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
           
            { data: 'nurse_name' },
            {data:'nurse_image', 
			render: function ( data) 
				{
				return '<img src="includes/upload/nurse/'+data+'" width="30" height="30">' 
				}
            },
            { data: 'nurse_mobile' },
            { data: 'nurse_email' },
            { data: 'nurse_dob' ,
			render: function ( data) 
				{
				return moment(data).format("MM-DD-YYYY");
				} },
            { data: 'department_name' },
            {data:'id',render: function(data,type,row){
                var eye = row.isActive == 1 ? 'fa-solid fa-eye' : 'fa-solid fa-eye-slash'
                    return '<a href="javascript:void(0);" id="isActive"  onclick="hideNurse('+data+','+row.isActive+', \''+row.nurse_name+'\')"><i class="'+eye+'"></i></a>';
            }},
            { data: 'id',render: function(data,type,row){
				return '<a href="javascript:void(0);" onclick="deleteNurse('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a><a href="javascript:void(0);" onclick="editNurse('+data+')" ><i class="fa-solid fa-edit text-success" ></i></a>'				
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

function hideNurse(data,isActive,nurse_name){
    var deptTitle="Nurse Status";
        var deptText= `Would You like to active ${nurse_name}?`;
        var deptBtn="Yes, activate it!";
        if(isActive==1)
        {
            deptTitle="Nurse Status";
            deptText= `Would You like to deActive ${nurse_name}?`;
            deptBtn="Yes, deActivate it!";
        }
        Swal.fire({
        title: deptTitle,
        text: deptText,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '##3085d6',
        cancelButtonColor: '##d33',
        confirmButtonText:  deptBtn
        }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({url:'nurse/changeStatus/id/'+data,
                success: function(result){
                    $('##nurseList').DataTable().ajax.reload();
                }
            });
        }
        })
            
          

       
}
    function deleteNurse(id)
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

                $.ajax({  url: 'nurse/delete/id/'+id, 
                        success: function(result){
                            Swal.fire(
                                'Deleted!',
                                'Your nurse has been deleted.',
                                'success')
                                $('##nurseList').DataTable().ajax.reload();
                    }});
        }
    });

    }


 
    function editNurse(id){
    $.ajax({  url: 'nurse/edit/id/'+id, 
        success: function(result){
            console.log(result);

            $( "##addNurseForm" ).validate().resetForm();
            $("##nurseLabel").text("Edit Nurse")
            $('##addNurse').modal('show');
            $("##nurse_password").removeAttr("required", "true");
            $("##image").removeAttr("required", "true");
            $("##imageText").show();
            $("##imgPreview").hide();

            $('##id').val(result.id);
            $('##nurse_name').val(result.nurse_name);
            $('##nurse_education').val(result.nurse_education);
            $('##imageText').val(result.nurse_image);
            $('##nurse_mobile').val(result.nurse_mobile);
            $('##nurse_address').val(result.nurse_address);
            $('##nurse_email').val(result.nurse_email);
            $('##nurse_dob').val(moment(result.dob).format("YYYY-MM-DD"));
            $('##nurse_department_id').val(result.nurse_department_id);
            $("##bb").text("Update"); 
    }});
}
  




</script>
</cfoutput>
    