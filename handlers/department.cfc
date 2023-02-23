component extends="base" {

	property name="deptService" inject="deptService";

 
	//Department Name Exist check used in validation handler
	function deptNameCheck( event, rc, prc ) 
	{    
		var result=deptService.nCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//add and update department handler
    function saveDepartment( event, rc, prc ) 
	{    
		prc.result=deptService.save(rc,prc.ADMIN_ID);
        relocate("home.dept");
	}

	//Dsipaly Department by jQuery DataTable Handler
	function indexData( event, rc, prc ) {
    	var result =deptService.departmentList(rc);
		var res ={
			"recordsTotal"    : result.total,
			"recordsFiltered" : result.total,
			"data"            : result.records,
			"draw"            : rc.draw,
		};
		event.renderData( data=res, type="json" );
	}

	//Delete Department handler
	function delete(event,rc,prc){
		var result=deptService.deleteDepartment(rc.id);
		event.renderData( data=result, type="json" );

	}

	//Edit Department handler
	function edit( event, rc, prc ) 
	{
		var departmentData = deptService.getDeptById(rc.id);
		event.renderData( data=departmentData, type="json" );
	}

	//Active Status Handler
	function changeStatus(event,rc,prc){
		prc.departmentData = deptService.isActiveDept(rc.id);
		relocate("home.dept");
	}
}
