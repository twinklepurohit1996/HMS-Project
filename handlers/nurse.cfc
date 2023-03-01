component extends="base" {

	property name="nurseService" inject="nurseService";

	//Add and Update Nurse handler
    function addNurse( event, rc, prc ) 
	{  
		prc.result=nurseService.saveNurse(rc,prc.ADMIN_ID);
        relocate("home.nurse");
	}

	//Email Exist check used in validation handler
	function emailCheck( event, rc, prc ) 
	{    
		var result=nurseService.eCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//Mobile number exist check used in validation handler
	function mobCheck( event, rc, prc ) 
	{    
		var result=nurseService.mCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//Display Nurse by jquery DataTable Hanlder
	function indexData( event, rc, prc ) {
	
    	var result =nurseService.nurseList(rc);
		var res ={
			"recordsTotal"    : result.total,
			"recordsFiltered" : result.total,
			"data"            : result.records,
			"draw"            : rc.draw
		};
		event.renderData( data=res, type="json" );
	}
	
	//Active Status Handler
    function changeStatus(event,rc,prc){
		prc.nurseData = nurseService.isActiveNurse(rc.id);
		relocate("home.nurse");
	} 

	//Delete Nurse Handler
    function delete(event,rc,prc){
		var result=nurseService.deleteNurse(rc.id);
		event.renderData( data=result, type="json" );

        // relocate("home.nurse");
	}

	//Edit Nurse Handler
    function edit( event, rc, prc ) 
	{
		var nurseData = nurseService.getNurseById(rc.id);
		event.renderData( data=nurseData, type="json" );
	}
}
