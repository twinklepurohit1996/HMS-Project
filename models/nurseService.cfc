component singleton accessors="true"{

    property name="BCrypt" inject="BCrypt@BCrypt";

    //Email Exist Check For Nurse Service
    public any function eCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="nurse_email", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_email#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM nurse WHERE id !=:id AND  nurse_email=:nurse_email ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    // Mobile Number Exist Check For Nurse Service
    public any function mCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="nurse_mobile", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_mobile#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM nurse WHERE id !=:id AND nurse_mobile=:nurse_mobile ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    //Get Department For Display of Department name for nurse insert form service
    public query function getDept(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT * FROM department WHERE isActive = 1";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Add or Update Nurse Service
    public any function saveNurse(required struct formData,required numeric admin_id){
    
        var loc = {};
        loc.result = {};
        loc.hashedPassword = BCrypt.hashPassword( arguments.formData.nurse_password );
        loc.query = new query();
        loc.query.addParam(name="nurse_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_name#");
		loc.query.addParam(name="nurse_education", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_education#");
        loc.query.addParam(name="nurse_email", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_email#");
		loc.query.addParam(name="nurse_address", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_address#");
        loc.query.addParam(name="nurse_password", cfsqltype="cf_sql_varchar", value="#loc.hashedPassword#");
		loc.query.addParam(name="nurse_mobile", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_mobile#");
		loc.query.addParam(name="nurse_department_id", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_department_id#");
        loc.query.addParam(name="nurse_dob", cfsqltype="cf_sql_varchar", value="#arguments.formData.nurse_dob#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");
        if(formData.id GT 0){
       
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
            loc.sql = "UPDATE nurse SET nurse_name=:nurse_name,nurse_education=:nurse_education,nurse_email=:nurse_email,nurse_address=:nurse_address,nurse_mobile=:nurse_mobile,nurse_department_id=:nurse_department_id,nurse_dob=:nurse_dob";
            if(formData.nurse_password.len() GT 0)
            {  
                loc.sql &= ",nurse_password=:nurse_password";
            }
            loc.sql &= ",updated_by=:admin_id";
            if ( len( trim( arguments.formData.image ) ) ) {
                cffile(
                    action       = "upload",
                    filefield    = "image",
                    destination  = "#expandPath( "./includes/upload/nurse/" )#",
                    nameconflict = "MakeUnique",
                    result       = "loc.profileResult"
                );
                loc.sql &= " ,nurse_image=:image";
                loc.query.addParam(
                    name      = "image",
                    cfsqltype = "cf_sql_varchar",
                    value     = "#loc.profileResult.serverfile#"
                );
            }
            loc.sql &= " where id =:id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            return loc.result;
        }
        else{
            loc.sql = "INSERT INTO nurse SET nurse_name=:nurse_name,nurse_education=:nurse_education,nurse_email=:nurse_email,nurse_address=:nurse_address,nurse_password=:nurse_password,nurse_mobile=:nurse_mobile,nurse_department_id=:nurse_department_id,nurse_dob=:nurse_dob";
            if ( len( trim( arguments.formData.image ) ) ) {
                cffile(
                    action       = "upload",
                    filefield    = "image",
                    destination  = "#expandPath( "./includes/upload/nurse/" )#",
                    nameconflict = "MakeUnique",
                    result       = "loc.profileResult"
                );
                loc.sql &= " ,nurse_image=:image";
                loc.query.addParam(
                    name      = "image",
                    cfsqltype = "cf_sql_varchar",
                    value     = "#loc.profileResult.serverfile#"
                );
            }
            loc.sql &= ",created_by=:admin_id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            writeDump(loc.result)
            if(loc.result.recordCount EQ 1){
                    
                loc.returnId = 	loc.result.generatedKey;
            }
            return loc.returnId; 
        } 	
    }

    //Display Nurse List Service
    public struct function nurseList(required struct formData)
    { 
        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM nurse";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT *  FROM nurse LEFT JOIN department ON nurse.nurse_department_id = department.id ";
        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE nurse_name LIKE :search";
        }
        if(structKeyExists(arguments.formData, "order") AND len(trim(arguments.formData.order)) GT 0){
            loc.sql &= " ORDER BY #arguments.formData.order#";
        }
        loc.sql &= " limit #formData.start#, #formData.length# ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        writeDump(loc.result);
        for(loc.i in loc.result){
            arrayAppend(loc.res.records, loc.i);
        }
		return loc.res;
    }

    //Active Status nurse Service
    public function isActiveNurse(required numeric id){
        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql = "UPDATE nurse SET isActive=!isActive WHERE id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getPrefix();
		return loc.result;
    }

    //Delete nurse Service
    public function deleteNurse(required numeric id)
    {

        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="DELETE FROM nurse WHERE id=:id";
        loc.query.setSQL(loc.sql);
        loc.result=loc.query.execute();
        return loc.result; 
    }

    //Get id for edit of nurse in nurse module
    public function getNurseById(required numeric id){
        var result = {};
		var nurseData = queryExecute('select * from nurse where id = ?', [{value="#arguments.Id#", cfsqltype="CF_SQL_INTEGER"}]);
		if(nurseData.recordCount GT 0){
			result = queryGetRow(nurseData, 1);
		}else{
			result = {
				id = 0,
				nurse_name = '',
                image = '',
				nurse_education = '',
                nurse_mobile = '',
                nurse_address = '',
                nurse_password = '',
                nurse_email = '',
                nurse_dob = '',
				nurse_department_id = '',
			}
		}
		return result;
    }

}