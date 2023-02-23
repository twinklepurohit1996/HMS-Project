component{

	property name="messagebox" inject="messagebox@cbmessagebox";
    property name="sessionStorage" inject="sessionStorage@cbstorages";
	
	function preHandler( event, rc, prc ){
        prc.ADMIN_ID = 0;
		if(sessionStorage.exists('LOGGEDIN_USER_ID')){
			prc.ADMIN_ID = sessionStorage.get('LOGGEDIN_USER_ID');
		}else{
			event.overrideEvent('auth.index');
        }
	}
}