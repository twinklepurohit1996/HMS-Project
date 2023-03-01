component extends="base" {

	property name="doctorService" inject="doctorService";
    /* property name="mysetting"    inject="coldbox:setting:mysetting";
	writeDump(mysetting.start);
		abort; */
	//Add and Update Doctor handler
    function addDoctor( event, rc, prc ) 
	{  
		prc.result=doctorService.saveDoctor(rc,prc.ADMIN_ID);
        relocate("home.doctor");
	}

	//Email Exist check used in validation handler
	function emailCheck( event, rc, prc ) 
	{    
		var result=doctorService.eCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//Mobile number exist check used in validation handler
	function mobCheck( event, rc, prc ) 
	{    
		var result=doctorService.mCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//Display Doctor by jquery DataTable Hanlder
	function indexData( event, rc, prc ) {
	
    	var result =doctorService.doctorList(rc);
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
		prc.doctorData = doctorService.isActiveDoctor(rc.id);
		relocate("home.doctor");
	} 

	//Delete Doctor Handler
    function delete(event,rc,prc){
		var result=doctorService.deleteDoctor(rc.id);
		event.renderData( data=result, type="json" );

        // relocate("home.doctor");
	}

	//Edit Doctor Handler
    function edit( event, rc, prc ) 
	{
		var doctorData = doctorService.getDoctorById(rc.id);
		event.renderData( data=doctorData, type="json" );
	}
}
