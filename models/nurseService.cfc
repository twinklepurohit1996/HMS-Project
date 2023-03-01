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
        loc.sql = "SELECT * FROM doctor WHERE id !=:id AND  doctor_email=:doctor_email ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    // Mobile Number Exist Check For Doctor Service
    public any function mCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="doctor_mobile", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_mobile#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM doctor WHERE id !=:id AND doctor_mobile=:doctor_mobile ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    //Get Department For Display of Department name for doctor insert form service
    public query function getDept(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT * FROM department WHERE isActive = 1";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Add or Update Doctor Service
    public any function saveDoctor(required struct formData,required numeric admin_id){
    
        var loc = {};
        loc.result = {};
        loc.hashedPassword = BCrypt.hashPassword( arguments.formData.doctor_password );
        loc.query = new query();
        loc.query.addParam(name="doctor_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_name#");
		loc.query.addParam(name="doctor_education", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_education#");
        loc.query.addParam(name="doctor_email", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_email#");
		loc.query.addParam(name="doctor_address", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_address#");
        loc.query.addParam(name="doctor_password", cfsqltype="cf_sql_varchar", value="#loc.hashedPassword#");
		loc.query.addParam(name="doctor_mobile", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_mobile#");
		loc.query.addParam(name="doctor_department_id", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_department_id#");
        loc.query.addParam(name="doctor_dob", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_dob#");
        loc.query.addParam(name="doctor_fees", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_fees#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");
        if(formData.id GT 0){
       
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
            loc.sql = "UPDATE doctor SET doctor_name=:doctor_name,doctor_education=:doctor_education,doctor_email=:doctor_email,doctor_address=:doctor_address,doctor_mobile=:doctor_mobile,doctor_department_id=:doctor_department_id,doctor_dob=:doctor_dob,doctor_fees=:doctor_fees";
            if(formData.doctor_password.len() GT 0)
            {  
                loc.sql &= ",doctor_password=:doctor_password";
            }
            loc.sql &= ",updated_by=:admin_id";
            if ( len( trim( arguments.formData.image ) ) ) {
                cffile(
                    action       = "upload",
                    filefield    = "image",
                    destination  = "#expandPath( "./includes/upload/doctor/" )#",
                    nameconflict = "MakeUnique",
                    result       = "loc.profileResult"
                );
                loc.sql &= " ,doctor_image=:image";
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
            loc.sql = "INSERT INTO doctor SET doctor_name=:doctor_name,doctor_education=:doctor_education,doctor_email=:doctor_email,doctor_address=:doctor_address,doctor_password=:doctor_password,doctor_mobile=:doctor_mobile,doctor_department_id=:doctor_department_id,doctor_dob=:doctor_dob,doctor_fees=:doctor_fees";
            if ( len( trim( arguments.formData.image ) ) ) {
                cffile(
                    action       = "upload",
                    filefield    = "image",
                    destination  = "#expandPath( "./includes/upload/doctor/" )#",
                    nameconflict = "MakeUnique",
                    result       = "loc.profileResult"
                );
                loc.sql &= " ,doctor_image=:image";
                loc.query.addParam(
                    name      = "image",
                    cfsqltype = "cf_sql_varchar",
                    value     = "#loc.profileResult.serverfile#"
                );
            }
            loc.sql &= ",created_by=:admin_id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            if(loc.result.recordCount EQ 1){
                    
                loc.returnId = 	loc.result.generatedKey;
            }
            return loc.returnId; 
        } 	
    }

    //Display Dcotor List Service
    public struct function doctorList(required struct formData)
    { 
        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM doctor";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT *  FROM doctor LEFT JOIN department ON doctor.doctor_department_id = department.id ";
        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE doctor_name LIKE :search";
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

    //Active Status Doctor Service
    public function isActiveDoctor(required numeric id){
        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql = "UPDATE doctor SET isActive=!isActive WHERE id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getPrefix();
		return loc.result;
    }

    //Delete Doctor Service
    public function deleteDoctor(required numeric id)
    {

        var loc={};
        var  loc.return=true;
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="SELECT * FROM appointment WHERE doctor_id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        else{
            loc.sql="DELETE FROM doctor WHERE id=:id";
            loc.query.setSQL(loc.sql);
            loc.query.execute();
            loc.return= true;
        }
       
        return loc.return; 
    }

    //Get id for edit of doctor in doctor module
    public function getDoctorById(required numeric id){
        var result = {};
		var doctorData = queryExecute('select * from doctor where id = ?', [{value="#arguments.Id#", cfsqltype="CF_SQL_INTEGER"}]);
		if(doctorData.recordCount GT 0){
			result = queryGetRow(doctorData, 1);
		}else{
			result = {
				id = 0,
				doctor_name = '',
                image = '',
				doctor_education = '',
                doctor_mobile = '',
                doctor_address = '',
                doctor_password = '',
                doctor_email = '',
                doctor_dob = '',
                doctor_fees = '',
				doctor_department_id = '',
			}
		}
		return result;
    }

}