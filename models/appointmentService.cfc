component singleton accessors="true"{

    //Get patient name in dropdown in Appointment form Service 
    public query function getPatient(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT * FROM patient";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Get department name in dropdown in Appointment form Service 
    public query function getDept(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT * FROM department WHERE isActive = 1";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }


    //Get doctor name in dropdown according to selected department name in Appointment form Service 
    public array function getDoctorById(required numeric id){
        var loc = {};
        var loc.returnId = {};
        loc.query = new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql = "SELECT * FROM doctor WHERE doctor_department_id=:id AND isActive=1";
        loc.query.setSQL(loc.sql);
        loc.query.setReturnType("array");
        loc.result = loc.query.execute().getResult();
        writeDump(loc.result);
        return loc.result;
    }

    //add appointment in appointment module
    public any function saveAppointment(required struct formData,required numeric admin_id,required any start_opd,required any token_id,required any diff){
        var loc = {};
        loc.result = {Records: [],Status:false};
        // var loc.return=true;
        loc.query = new query();
        loc.query.addParam(name="patient_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.patient_name#");
		loc.query.addParam(name="department_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.department_name#");
        loc.query.addParam(name="appointment_date", cfsqltype="cf_sql_date", value="#arguments.formData.appointment_date#"); 
        loc.query.addParam(name="doctor_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.doctor_name#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");
        loc.query.addParam(name="diff", cfsqltype="cf_sql_integer", value="#arguments.diff#");
        loc.sqlExist = "SELECT * FROM `appointment` LEFT JOIN patient ON appointment.patient_id = patient.id
        WHERE doctor_id =:doctor_name and appointment_date =:appointment_date and patient_id =:patient_name and department_id=:department_name";
        loc.query.setSQL(loc.sqlExist);
        loc.result.Records = loc.query.execute().getResult();
        if(loc.result.Records.recordCount EQ 1){
            loc.result.Status=true;
            return loc.result;
        }
        else
        { 
            loc.sql1 = "SELECT * FROM `appointment`
            WHERE doctor_id =:doctor_name and appointment_date =:appointment_date
            order by patient_token_id desc LIMIT 1";
            loc.query.setSQL(loc.sql1);
            loc.result1 = loc.query.execute().getResult();
            if(loc.result1.recordCount EQ 1)
            {
                var tokenid=loc.result1.patient_token_id+1;
                var startOpd=DateAdd("n",diff,loc.result1.appointment_time);
                loc.query.addParam(name="appointment_date", cfsqltype="cf_sql_date", value="#appointment_date#"); 
                loc.query.addParam(name="token_id", cfsqltype="cf_sql_integer", value="#tokenid#"); 
                loc.query.addParam(name="start_opd", cfsqltype="cf_sql_time", value="#startOpd#");
            }
            else
            {
                loc.query.addParam(name="appointment_date", cfsqltype="cf_sql_date", value="#appointment_date#"); 
                loc.query.addParam(name="token_id", cfsqltype="cf_sql_integer", value="#arguments.token_id#");
                loc.query.addParam(name="start_opd", cfsqltype="cf_sql_time", value="#arguments.start_opd#");  
            }
            loc.sqlInsert = "INSERT INTO appointment SET patient_id=:patient_name,department_id=:department_name,doctor_id=:doctor_name,patient_token_id=:token_id,appointment_date=:appointment_date,appointment_time=:start_opd";
            loc.sqlInsert &= ",created_by=:admin_id";
            loc.query.setSQL(loc.sqlInsert);
            loc.resultInsert = loc.query.execute().getPrefix(); 
            if(loc.resultInsert.recordCount EQ 1){
                loc.returnId = 	loc.resultInsert.generatedKey;
            }
            return loc.result;           
        }
    }

    //Display Appointment using dataTable of Jquery in Appointment module
    public struct function appointmentList(required struct formData)
    { 
        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM appointment";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT *  FROM appointment LEFT JOIN patient ON appointment.patient_id = patient.id LEFT JOIN department ON appointment.department_id = department.id LEFT JOIN doctor ON appointment.doctor_id = doctor.id  ";
        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE patient_name LIKE :search OR doctor_name LIKE :search OR appointment_date LIKE :search OR department_name LIKE :search";
        }
        if(structKeyExists(arguments.formData, "order") AND len(trim(arguments.formData.order)) GT 0){
            loc.sql &= " ORDER BY #arguments.formData.order#";
        }
        loc.sql &= " limit #formData.start#, #formData.length# ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        for(loc.i in loc.result){
            arrayAppend(loc.res.records, loc.i);
        }
		return loc.res;
    }

    //Delete appointment in appointment module
    public function deleteAppointment(required numeric id)
    {
        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="DELETE FROM appointment WHERE id=:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getPrefix();
		return loc.result;
    }

     //Admit Status of patient in appointment Service
     public function isAdmitPatient(required numeric id){
        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql = "UPDATE appointment SET isAdmit=!isAdmit WHERE id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getPrefix();
		return loc.result;
    }

}  

   


    
   
    


    

    
