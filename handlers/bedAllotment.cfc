component extends="base" {

	property name="bedAllotmentServices" inject="bedAllotmentServices";


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

	//Bed allotment in bed allotment module
	function changeisBedAllotment(event, rc, prc)
	{
		var bedAllotmentData = bedAllotmentServices.isbedAllotmentPatient(rc.id,rc.department_id);
		relocate("home.bedAllotment");
	}

	//Discharge in bed allotment module
	function changeDischarge(event, rc, prc)
	{
		var bedAllotmentData = bedAllotmentServices.dischargePatient(rc.id,rc.department_id);
		relocate("home.bedAllotment");
	}

	
}
