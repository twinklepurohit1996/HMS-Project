<cfoutput>
    <script>
       $(document).ready( function () {     
        
        $.validator.addMethod("validNumber", function (value, element, options){
            return /^[0-9]*$/.test(value);
        }
        );
            $('##addDept').on('hidden.bs.modal', function () {
                $("##deptLabel").text("Add New Department")
                $("##bb").text("Insert");
                $("##id").val("0");
                $('##addDept form')[0].reset();
                $( "##addDepartmentForm" ).validate().resetForm();
            });

            $.validator.addMethod("validName", function (value, element, options){
                return /^[A-Za-z\s.]+$/.test(value);
            });

           
            $("##addDepartmentForm").validate({
                rules:{
                    departmentName:{
                        required:true,
                        minlength:5,
                        maxlength:50,
                        validName:true,
                        remote: {
                        url: "department/deptNameCheck",
                        type: "post",
                        data: {
                            departmentName: function() {
                                return $("##departmentName").val(); 
                            },
                            id: function() {
                                return $("##id").val(); 
                            }
                        }
                    }
                    },
                    departmentDetails:{
                        required:true,
                        minlength:100,
                        maxlength:500,
                    },
                    department_bed_total:{
                        required:true,
                        validNumber:true,
                    },
                },
                messages:{
                    departmentName:{
                        required:"Department Name is Required",
                        minlength:"Minimum Length is 5",
                        maxlength:"Maximum Length is 50",
                        validName:'Please enter a valid department name',
                        remote:"Department Name Already Exist!!!",
                    },
                    departmentDetails:{
                        required:"Department Details is Required",
                        minlength:"Minimum Length is 100",
                        maxlength:"Maximum Length is 500",
                    },
                    department_bed_total:{
                        required:"Department Bed Total Number is required",
                        validNumber:"Please Enter a valid bed number!!",
                    },
                }
            });

    
            $('##deptList').DataTable({
                processing: true,
                serverSide: true,
                pageLength: 10,
                pagination: 'datatablePagination',
                ajax: {
                    url: 'department/indexData',
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
                columDefs:[{ className: "text-truncate" , "targets":[1]},],
                columns: [
                    { data: 'department_name' },
                    { data: 'department_details' },
                    { data: 'department_bed_total'},
                    { data: 'id',render: function(data,type,row){
                        var eye = row.isActive == 1 ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'
                        return '<a href="javascript:void(0);" id="isActive" onclick="hideDept('+data+')"><i class="'+eye+'"></i></a>'				
                    }},
                    { data: 'id',render: function(data,type,row){
                        return '<a href="javascript:void(0);" onclick="deleteDept('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a><a href="javascript:void(0);" onclick="editDept('+data+')" ><i class="fa-solid fa-edit text-success" ></i></a>'				
                    }},
                ],
            });
        });

function deleteDept(id){
        console.log(id);
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
                $.ajax({  url: 'department/delete/id/'+id, 
                        success: function(result){
                            console.log(result);
                            if(result==true)
                            {
                                Swal.fire(
                                'Warning!',
                                'Department is already assigned to a doctor!!',
                                'warning')                               
                            }
                            else
                            {
                                Swal.fire(
                                'Deleted!',
                                'Your department has been deleted.',
                                'success')
                                $('##deptList').DataTable().ajax.reload();
                            }
                    }
                });
            }
        });
    }

    function hideDept(data){
        $.ajax({url:'department/changeStatus/id/'+data,
            success: function(result){
                $('##deptList').DataTable().ajax.reload();
            }
        });
    }

    function editDept(id){
        $.ajax({  url: 'department/edit/id/'+id, 
            success: function(result){
                $( "##addDepartmentForm" ).validate().resetForm();
                $("##deptLabel").text("Edit Department")
                $('##addDept').modal('show');
                $('##id').val(result.id);
                $('##departmentName').val(result.department_name);
                $('##departmentDetails').val(result.department_details);
                $('##department_bed_total').val(result.department_bed_total);
                $("##bb").text("Update");
        }});
    }
</script>
</cfoutput>
    