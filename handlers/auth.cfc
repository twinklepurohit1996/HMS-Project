component extends="coldbox.system.EventHandler" {

    property name="messagebox" inject="messagebox@cbmessagebox";
	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="authService" inject="authService";


	//Display login page handler
	function index( event, rc, prc ) {
		prc.welcomeMessage = "Welcome to ColdBox!";
		event.setView( "authentication/login").setLayout("login");
	}

	//Admin Login Handler
	function doLogin(event,rc,prc){
		var result = authService.adminLogin(rc);		
		if(result.recordCount EQ 1){
			sessionStorage.set('LOGGEDIN_USER_ID', result.id );
			messagebox.success("Admin successfully login!!");
			relocate('home.index');
		}else{
			messagebox.error("Admin Not Found, Invalid User");
			relocate('auth.index');
		}	
	}

    


    

}
