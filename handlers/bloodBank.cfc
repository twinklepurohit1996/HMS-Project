component extends="base" {

	property name="bloodBankService" inject="bloodBankService";

	//Mobile NUmber Exist Check used in validation handler 
	function mobCheck( event, rc, prc ) 
	{    
		var result=bloodBankService.mCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//Email Exist Check used in validation handler 
	function emailCheck( event, rc, prc ) 
	{    
		var result=bloodBankService.eCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	//Aadhar No Exist Check used in validation handler 
	function aadharCheck( event, rc, prc ) 
	{    
		var result=bloodBankService.aCheck(rc);
		event.renderData( data=result, type="json" );	
	}

	// Add and Update Patient Handler 
	function addCandidate( event, rc, prc ) 
	{    
		prc.result=bloodBankService.saveCandidate(rc,prc.ADMIN_ID);
        relocate("home.bloodBank");
	}

	//Display Patient Data by Jquery Data Table handler
	function indexData( event, rc, prc ) {
    	var result =bloodBankService.candidateList(rc);
		var res ={
			"recordsTotal"    : result.total,
			"recordsFiltered" : result.total,
			"data"            : result.records,
			"draw"            : rc.draw
		};
		event.renderData( data=res, type="json" );
	}

	// Update Candidate handler
	function edit( event, rc, prc ) 
	{
		var candidateData = bloodBankService.getCandidateById(rc.id);
		event.renderData( data=candidateData, type="json" );
	}

	//Delete Candidate handler
	function delete(event,rc,prc){
		var result=bloodBankService.deleteCandidate(rc.id);
		event.renderData( data=result, type="json" );
	}


}
