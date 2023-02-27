component singleton accessors="true"{
    property name="BCrypt" inject="BCrypt@BCrypt";
    
    //Patient Mobile number exixt check Service 
    public any function mCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="patient_mobile", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_mobile#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM patient WHERE id!=:id AND patient_mobile=:patient_mobile ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    //Patient Aadhar number exixt check Service 
    public any function aCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="patient_aadhar_no", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_aadhar_no#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM patient WHERE id!=:id AND patient_aadhar_no=:patient_aadhar_no ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        return loc.return; 
    }

    //Patient Email Exist check Service 
    public any function eCheck(required struct formData)
    {
        var loc = {};
        var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="patient_email", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_email#");
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
        loc.sql = "SELECT * FROM patient WHERE id!=:id AND patient_email=:patient_email ";
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

    //Add and update patient service
    public any function savePatient(required struct formData,required numeric admin_id){
    
        var loc = {};
        loc.result = {};
        loc.hashedPassword = BCrypt.hashPassword( arguments.formData.patient_password );
        loc.query = new query();
        loc.query.addParam(name="patient_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_name#");
		loc.query.addParam(name="patient_mobile", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_mobile#");
        loc.query.addParam(name="patient_gender", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_gender#");
        loc.query.addParam(name="patient_email", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_email#");
		loc.query.addParam(name="patient_address", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_address#");
        loc.query.addParam(name="patient_password", cfsqltype="cf_sql_varchar", value="#loc.hashedPassword#");
		loc.query.addParam(name="patient_blood_group_id", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_blood_group_id#");
        loc.query.addParam(name="patient_dob", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_dob#");
        loc.query.addParam(name="patient_aadhar_no", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_aadhar_no#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");
        if(formData.id GT 0)
        {
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
            loc.sql = "UPDATE patient SET patient_name=:patient_name,patient_mobile=:patient_mobile,patient_email=:patient_email,patient_address=:patient_address,patient_blood_group_id=:patient_blood_group_id,patient_dob=:patient_dob,patient_aadhar_no=:patient_aadhar_no,patient_gender=:patient_gender";
            if(formData.patient_password.len() GT 0)
            {  
                loc.sql &= ",patient_password=:patient_password";
            }
            loc.sql &= ",updated_by=:admin_id";
            loc.sql &= " where id =:id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            return loc.result;
        }
        else
        {
            loc.sql = "INSERT INTO patient SET patient_name=:patient_name,patient_mobile=:patient_mobile,patient_email=:patient_email,patient_address=:patient_address,patient_blood_group_id=:patient_blood_group_id,patient_dob=:patient_dob,patient_aadhar_no=:patient_aadhar_no,patient_password=:patient_password,patient_gender=:patient_gender";
            loc.sql &= ",created_by=:admin_id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            if(loc.result.recordCount EQ 1){
                    
                loc.returnId = 	loc.result.generatedKey;
            }
            return loc.returnId; 
        } 	
    }


    //Display Patient List Service
    public struct function patientList(required struct formData)
    { 

        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM patient";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT *  FROM patient LEFT JOIN blood_group ON patient.patient_blood_group_id = blood_group.id ";
        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE patient_name LIKE :search";
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

    // Get Id for Edit Patient Service
    public function getPatientById(required numeric id){
        writeDump(id)
        var result = {};
		var patientData = queryExecute('select * from patient where id = ?', [{value="#arguments.Id#", cfsqltype="CF_SQL_INTEGER"}]);
		if(patientData.recordCount GT 0){
           
			result = queryGetRow(patientData, 1);
            
		}else{
			result = {
				id = 0,
				patient_name = '',
                patient_mobile = '',
                patient_email = '',
                patient_password = '',
                patient_address = '',
                patient_gender='',
                patient_blood_group_id = '',
                patient_dob = '',
				patient_aadhar_no = '',
			}
		}
		return result;
    }


    //Delete Patient Service
    public function deletePatient(required numeric id)
    {
        var loc={};
        var  loc.return=true;
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="SELECT * FROM appointment WHERE patient_id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        // writeDump(loc.result);
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        else{
            loc.sql="DELETE FROM patient WHERE id=:id";
            loc.query.setSQL(loc.sql);
            loc.query.execute();
            loc.return= true;
        }
        return loc.return; 
    }
}