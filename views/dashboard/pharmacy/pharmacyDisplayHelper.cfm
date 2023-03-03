<cfoutput>
    <script>
       $(document).ready( function () {

        $('##addMedicine').on('hidden.bs.modal', function () {
                $("##medicineLabel").text("Add New Medicine")
                $("##bb").text("Insert");
                $("##id").val("0");
                $('##addMedicine form')[0].reset();
                $( "##addMedicineForm" ).validate().resetForm();

        });

        
    $("##addMedicineForm").validate({
        rules:{
            medicine_name:{
                required:true,
                minlength:5,
                maxlength:20,
            },
            medicine_company:{
                required:true,
                minlength:2,
                maxlength:20,
            },
            medicine_quantity:{
                required:true,
                minlength:1,
            },
            medicine_maufacturing_date:{
                required:true,
            },
            medicine_expiry_date:{
                required:true,               
            },
            medicine_description:{
                required:true,
                minlength:10,
                maxlength:100,
            }, 
        },
        highlight: function(element) {   // <-- fires when element has error
                $(element).closest('.form-select').removeClass('has-success').addClass('has-error');
            },
            unhighlight: function(element) { // <-- fires when element is valid
                $(element).closest('.form-select').removeClass('has-error').addClass('has-success');
            },
        messages:{
            medicine_name:{
                required:"Medicine Name is Required",
                minlength:"Minimum Length is 5",
                maxlength:"Maximum Length is 20",
            },
            medicine_company:{
                required:"Medicine Company is Required",
                minlength:"Minimum Length is 2",
                maxlength:"Maximum Length is 20",
            },
            medicine_quantity:{
                required:"Medicine Quantity  is Required",
                minlength:"Minimum Length is 1",
            },
            medicine_expiry_date:{
                required:"Medicine Expiry Date is Required",
            },
            medicine_maufacturing_date:{
                required:"Medicine Maufacturing Date is Required",
            },
            medicine_description:{
                required:"Medicine Description is Required",
                minlength:"Minimum Length is 10",
                maxlength:"Maximum Length is 100",
            },
        }
    });
      
        
        
        $('##pharmacyList').DataTable({
		processing: true,
        serverSide: true,
		pageLength: 10,
		pagination: 'datatablePagination',
		ajax: {
			url: 'pharmacy/indexData',
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
           
            { data: 'medicine_name' },
            {data:'medicine_company'},
            { data: 'medicine_quantity' },
            { data: 'medicine_maufacturing_date',
			render: function ( data) 
				{
				return moment(data).format("MM-DD-YYYY");
				} 
            },
            { data: 'medicine_expiry_date' ,
			render: function ( data) 
				{
				return moment(data).format("MM-DD-YYYY");
				} 
            },
            { data: 'medicine_description' },
            { data: 'id',render: function(data,type,row){
				return '<a href="javascript:void(0);" onclick="deleteMedicine('+data+')"><i class="fa-solid fa-trash text-danger p-2"></i></a><a href="javascript:void(0);" onclick="editMedicine('+data+')" ><i class="fa-solid fa-edit text-success" ></i></a>'				
			}
            },
            ],
	});
    
    });


    
    



    function deleteMedicine(id)
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

                $.ajax({  url: 'pharmacy/delete/id/'+id, 
                        success: function(result){
                            Swal.fire(
                                'Deleted!',
                                'Your medicine has been deleted.',
                                'success')
                                $('##pharmacyList').DataTable().ajax.reload();
                    }});
        }
    });

    }


 
    function editMedicine(id){
    $.ajax({  url: 'pharmacy/edit/id/'+id, 
        success: function(result){
            console.log(result);

            $( "##addMedicineForm" ).validate().resetForm();
            $("##medicineLabel").text("Edit Medicine")
            $('##addMedicine').modal('show');

            $('##id').val(result.id);
            $('##medicine_name').val(result.medicine_name);
            $('##medicine_company').val(result.medicine_company);
            $('##medicine_quantity').val(result.medicine_quantity);
            $('##medicine_description').val(result.medicine_description);

            $('##medicine_maufacturing_date').val(moment(result.medicine_maufacturing_date).format("YYYY-MM-DD"));
            $('##medicine_expiry_date').val(moment(result.medicine_expiry_date).format("YYYY-MM-DD"));            
            $("##bb").text("Update"); 
    }});
}
  




</script>
</cfoutput>
    