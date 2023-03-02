component extends="base" {

    property name="messagebox" inject="messagebox@cbmessagebox";
	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="homeService" inject="homeService";
	property name="authService" inject="authService";
	property name="doctorService" inject="doctorService";
	property name="patientService" inject="patientService";
	property name="appointmentService" inject="appointmentService";
	property name="bedAllotmentServices" inject="bedAllotmentServices";
	property name="nurseService" inject="nurseService";
	property name="bloodBankService" inject="bloodBankService";

	//Home page or Dashboard page display handler
    function index( event, rc, prc ) 
	{    
		prc.dataDept=homeService.totalDepartment();
		prc.dataDoctor=homeService.totalDoctor();
		prc.dataNurse=homeService.totalNurse();
		prc.dataPatient=homeService.totalPatient();
		prc.dataAppointment=homeService.totalAppointment();
		prc.dataBedAllotment=homeService.totalBedAllotment();
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

	//Nurse page display handler
	function nurse( event, rc, prc ) 
	{    
        prc.result=nurseService.getDept();
		event.setView( "dashboard/nurse/nurseDisplay" );
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

	//Bed Allotment page display handler
	function bedAllotment( event, rc, prc ) 
	{    
		event.setView( "dashboard/bedAllotment/bedAllotmentDisplay" );
	}

	//Blood bank page display handler
	function bloodBank( event, rc, prc ) 
	{    
        prc.result=bloodBankService.getBloodGroup();
		event.setView( "dashboard/bloodBank/bloodBankDisplay" );
	}
	//Logout Functionlity Handler
	function logout(event,rc,prc){
		prc.check = authService.adminLogout();
        messagebox.warning("Admin successfully logout!!");
        relocate('auth.index');
    }

}
