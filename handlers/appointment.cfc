component extends="base" {

	property name="appointmentService" inject="appointmentService";
    property name="mysetting"    inject="coldbox:setting:mysetting";
    property name="messagebox" inject="messagebox@cbmessagebox";

	//Appointment Insert and Update Handler
	function addAppointment( event, rc, prc ){    
		var start_opd = mysetting.start;
		var token_id = 1;
		var diff=15;
		var result=appointmentService.saveAppointment(rc,prc.ADMIN_ID,start_opd,token_id,diff);
		// writeDump(result);
		// abort;

		if(result.recordCount EQ 1)
		{

			messagebox.error("#result.patient_name# is already taken on this #result.appointment_date#!!!!");
		}
        relocate("home.appointment");
	}

	//Display Appointment list Handler
	function indexData( event, rc, prc ) {
    	var result = appointmentService.appointmentList(rc);
		var res ={
			"recordsTotal"    : result.total,
			"recordsFiltered" : result.total,
			"data"            : result.records,
			"draw"            : rc.draw
		};
		event.renderData( data=res, type="json" );
	}

	//Get doctor name in dropdown according to selected department name in Appointment form handler(insert and update) 
	function getDoctor(event , rc, prc){
		var resultDoctor = appointmentService.getDoctorById(rc.id);
		event.renderData( data=resultDoctor, type="json" );	
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
