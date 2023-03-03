component singleton accessors="true"{
    
    //Blood Bank Patinet Mobile number exixt check Service 
    public any function mCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="mobile_number", cfsqltype="cf_sql_varchar", value="#arguments.formData.mobile_number#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM blood_bank WHERE id!=:id AND mobile_number=:mobile_number ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    //Blood Bank Patinet Aadhar number exixt check Service 
    public any function aCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="aadhar_number", cfsqltype="cf_sql_varchar", value="#arguments.formData.aadhar_number#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM blood_bank WHERE id!=:id AND aadhar_number=:aadhar_number ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    //Blood bank Patient Email Exist check Service 
    public any function eCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="email", cfsqltype="cf_sql_varchar", value="#arguments.formData.email#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM blood_bank WHERE id!=:id AND email=:email ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }


    //Get Blood Group for dropdown of patient blood group service 
    public query function getBloodGroup(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT * FROM blood_group ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Add and update blood bank Candidate service
    public any function saveCandidate(required struct formData,required numeric admin_id){
    
        var loc = {};
        loc.result = {};
        loc.query = new query();
        loc.query.addParam(name="candidate_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.candidate_name#");
        loc.query.addParam(name="candidate_type", cfsqltype="cf_sql_varchar", value="#arguments.formData.candidate_type#");
		loc.query.addParam(name="mobile_number", cfsqltype="cf_sql_varchar", value="#arguments.formData.mobile_number#");
        loc.query.addParam(name="gender", cfsqltype="cf_sql_varchar", value="#arguments.formData.gender#");
        loc.query.addParam(name="email", cfsqltype="cf_sql_varchar", value="#arguments.formData.email#");
		loc.query.addParam(name="address", cfsqltype="cf_sql_varchar", value="#arguments.formData.address#");
		loc.query.addParam(name="blood_group_id", cfsqltype="cf_sql_varchar", value="#arguments.formData.blood_group_id#");
        loc.query.addParam(name="blood_unit", cfsqltype="cf_sql_varchar", value="#arguments.formData.blood_unit#");
        loc.query.addParam(name="dob", cfsqltype="cf_sql_varchar", value="#arguments.formData.dob#");
        loc.query.addParam(name="aadhar_number", cfsqltype="cf_sql_varchar", value="#arguments.formData.aadhar_number#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");
        if(formData.id GT 0)
        {
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
            loc.sql = "UPDATE blood_bank SET candidate_name=:candidate_name,candidate_type=:candidate_type,mobile_number=:mobile_number,gender=:gender,email=:email,address=:address,blood_group_id=:blood_group_id,blood_unit=:blood_unit,dob=:dob,aadhar_number=:aadhar_number";
            loc.sql &= ",updated_by=:admin_id";
            loc.sql &= " where id =:id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            return loc.result;
        }
        else
        {
            loc.sql = "INSERT INTO blood_bank SET candidate_name=:candidate_name,candidate_type=:candidate_type,mobile_number=:mobile_number,gender=:gender,email=:email,address=:address,blood_group_id=:blood_group_id,blood_unit=:blood_unit,dob=:dob,aadhar_number=:aadhar_number";
            loc.sql &= ",created_by=:admin_id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            if(loc.result.recordCount EQ 1){
                    
                loc.returnId = 	loc.result.generatedKey;
            }
            return loc.returnId; 
        } 	
    }


    //Display Blood bank  List Service
    public struct function candidateList(required struct formData)
    { 

        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM blood_bank";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT *  FROM blood_bank LEFT JOIN blood_group ON blood_bank.blood_group_id = blood_group.id ";
       
        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE candidate_name LIKE :search";
        }
        if(structKeyExists(arguments.formData, "order") AND len(trim(arguments.formData.order)) GT 0){
            loc.sql &= " ORDER BY #arguments.formData.order#";
        }
        loc.sql &= " limit #formData.start#, #formData.length# ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        /* writeDump(loc.sql);
        abort; */
        for(loc.i in loc.result){
            arrayAppend(loc.res.records, loc.i);
        }
		return loc.res;
    }

    // Get Id for Edit Candidate Service
    public function getCandidateById(required numeric id){
        writeDump(id)
        var result = {};
		var candidateData = queryExecute('select * from blood_bank where id = ?', [{value="#arguments.Id#", cfsqltype="CF_SQL_INTEGER"}]);
		if(candidateData.recordCount GT 0){
           
			result = queryGetRow(candidateData, 1);
            
		}else{
			result = {
				id = 0,
				candidate_name = '',
                candidate_type = '',
                mobile_number = '',
                aadhar_number = '',
                address = '',
                email = '',
                blood_group_id ='',
                dob = '',
                gender = '',
				blood_unit = '',
			}
		}
		return result;
    }


    //Delete Patient Service
    public function deleteCandidate(required numeric id)
    {
       
        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="DELETE FROM blood_bank WHERE id=:id";
        loc.query.setSQL(loc.sql);
        loc.result=loc.query.execute();
        return loc.result; 
    }
}