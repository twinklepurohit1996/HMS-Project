component extends="base" {

	property name="pharmacyService" inject="pharmacyService";

    
	// Add and Update Patient Handler 
	function addMedicine( event, rc, prc ) 
	{    
		prc.result=pharmacyService.saveMedicine(rc,prc.ADMIN_ID);
        relocate("home.pharmacy");
	}

	//Display pharmacy by jquery DataTable Hanlder
	function indexData( event, rc, prc ) {
	
    	var result =pharmacyService.medicineList(rc);
		var res ={
			"recordsTotal"    : result.total,
			"recordsFiltered" : result.total,
			"data"            : result.records,
			"draw"            : rc.draw
		};
		event.renderData( data=res, type="json" );
	}

	//Delete pharmacy Handler
    function delete(event,rc,prc){
		var result=pharmacyService.deleteMedicine(rc.id);
		event.renderData( data=result, type="json" );
	}

	//Edit pharmacy Handler
    function edit( event, rc, prc ) 
	{
		var medicineData = pharmacyService.getMedicineById(rc.id);
		event.renderData( data=medicineData, type="json" );
	}
}
