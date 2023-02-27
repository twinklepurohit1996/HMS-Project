component extends="base" {

	property name="bedAllotmentServices" inject="bedAllotmentServices";
    // property name="mysetting"    inject="coldbox:setting:mysetting";
    property name="messagebox" inject="messagebox@cbmessagebox";


	//Display Bed Allotment list Handler
	function indexData( event, rc, prc ) {
    	var result = bedAllotmentServices.bedAllotmentList(rc);
		var res ={
			"recordsTotal"    : result.total,
			"recordsFiltered" : result.total,
			"data"            : result.records,
			"draw"            : rc.draw
		};
	
		event.renderData( data=res, type="json" );
	}

	//Get doctor name in dropdown according to selected department name in Bed Allotment form handler(insert and update) 
	function getBed(event , rc, prc){
		var resultBed = bedAllotmentServices.getBedById(rc.id);
		event.renderData( data=resultBed, type="json" );	
	}

	//Get Patinet name in dropdown according to selected department name in Bed Allotment form handler(insert and update) 
	function getPatient(event , rc, prc){
		var resultPatient = bedAllotmentServices.getPatientById(rc.id);
		// writeDump(resultPatient);
		// abort;
		event.renderData( data=resultPatient, type="json" );	
	}
	//Delete appointment handler
	function delete(event,rc,prc){
		// writeDump(prc);
		// abort;
		var result=appointmentService.deleteAppointment(rc.id);
		event.renderData( data=result, type="json" );
	}


	//Edit appointment by picking id in appointment handler
	function edit( event, rc, prc ) 
	{
		var appointmentData = appointmentService.getAppointmentById(rc.id);	
		event.renderData( data=appointmentData, type="json" );
	}
}
