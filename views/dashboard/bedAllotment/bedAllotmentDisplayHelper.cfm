<cfoutput>
    <script>
    $(document).ready( function () {
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
                    { data:'patient_name'},
                    {data:'department_name'},
                    { data:'bed_number' },
                    { data: 'id',render: function(data,type,row){
                        console.log(row);
                        var bedAllotment = row.isbedAllotment == 0 ? '<button type="button" class="btn-success mx-3">Bed Allotment</button>' : '<button type="button"   class="btn-danger mx-3">Discharge</button>';

                        return '<a href="javascript:void(0);" id="isbedAllotment" onclick="bedAllot('+data+','+row.isbedAllotment+','+row.department_id+', \''+row.patient_name+'\', \''+row.department_name+'\', \''+row.bed_number+'\')">'+bedAllotment+'</a>';
                    }},
                ],
            });
    });


    function bedAllot(data,isbedAllotment,department_id,name,dept,bed_number)
    {
        if(isbedAllotment==0)
        {    
            Swal.fire({
                title: "Bed Allot to Patient",
                text: `Do you want to allot bed to ${name} in ${dept} department?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '##3085d6',
                cancelButtonColor: '##d33',
                confirmButtonText: 'Yes, Allot Bed!!'
                }).then((result) => 
                {
                    if (result.isConfirmed) 
                    {
                        Swal.fire(
                        'Alloted!',
                        'Bed is alloted to patient',
                        'success'
                        )
                    }
                    $.ajax({url:'bedAllotment/changeisBedAllotment/id/'+data+'/department_id/'+department_id,
                            success: function(result){
                                console.log(result);
                                $('##bedAllotmentList').DataTable().ajax.reload();
                            }
                        });
                }); 
            }
        else
        {
            Swal.fire({
                title:`<div class="text-center"><h1>Discharge Patient</h1>
                    <h4>Do you want to discharge ${name} from bed number ${bed_number} of ${dept} department ?</h4></div>`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '##3085d6',
                cancelButtonColor: '##d33',
                confirmButtonText: 'Discharge!!!',
                html: `<input type="text" id="feedback" class="swal2-input" placeholder="feedback">`,
                focusConfirm: false,
                preConfirm: () => {
                    const feedback = Swal.getPopup().querySelector('##feedback').value
                    if (!feedback) {
                    Swal.showValidationMessage(`Please enter feedback`)
                    }
                    return { feedback: feedback }
                }
                }).then((result) => 
                {
                    if (result.isConfirmed) 
                    {
                        Swal.fire(`feedback: ${result.value.feedback}`.trim())
                        $.ajax({url:'bedAllotment/changeDischarge/id/'+data+'/department_id/'+department_id,
                            success: function(result){
                                console.log(result);
                                $('##bedAllotmentList').DataTable().ajax.reload();
                            }
                        });
                    }
                }); 
        }

        

    }
    
</script>
</cfoutput>
    