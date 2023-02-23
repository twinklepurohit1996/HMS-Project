component extends="base" {

    property name="messagebox" inject="messagebox@cbmessagebox";
	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="homeService" inject="homeService";
	property name="authService" inject="authService";
	property name="doctorService" inject="doctorService";
	property name="patientService" inject="patientService";
	property name="appointmentService" inject="appointmentService";

	//Home page or Dashboard page display handler
    function index( event, rc, prc ) 
	{    
		prc.dataDept=homeService.totalDepartment();
		prc.dataDoctor=homeService.totalDoctor();
		prc.dataPatient=homeService.totalPatient();
		prc.dataAppointment=homeService.totalAppointment();
		event.setView( "dashboard/home" );
	}

	//Department page display handler
	function dept( event, rc, prc ) 
	{    
		event.setView( "dashboard/department/departmentDisplay" );
	}

	//Doctor page display handler
	function doctor( event, rc, prc ) 
	{    
        prc.result=doctorService.getDept();
		event.setView( "dashboard/doctor/doctorDisplay" );
	}

	//Patient page display handler
	function patient( event, rc, prc ) 
	{    
        prc.result=patientService.getBloodGroup();
		event.setView( "dashboard/patient/patientDisplay" );
	}

	//Appointment page display handler
	function appointment( event, rc, prc ) 
	{    
		prc.resultDept=appointmentService.getDept();
        prc.resultPatient=appointmentService.getPatient();
		event.setView( "dashboard/appointment/appointmentDisplay" );
	}

	//Logout Functionlity Handler
	function logout(event,rc,prc){
		prc.check = authService.adminLogout();
        messagebox.warning("Admin successfully logout!!");
        relocate('auth.index');
    }

}
