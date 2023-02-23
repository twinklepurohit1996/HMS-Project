component singleton accessors="true"{

     //Department name Exist Check For Doctor Service
     public any function nCheck(required struct formData)
     {
         var loc = {};
         var loc.return=true;
         loc.query = new query();
         loc.query.addParam(name="departmentName", cfsqltype="cf_sql_varchar", value="#arguments.formData.departmentName#");
         loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
         loc.sql = "SELECT * FROM department WHERE id !=:id AND  department_name=:departmentName ";
         loc.query.setSQL(loc.sql);
         loc.result = loc.query.execute().getResult();
         if(loc.result.recordCount GT 0){      
             loc.return = 	false;
         }
         return loc.return; 
     }

    //Add and Update Department Service
    function save(required struct formData,required numeric admin_id){
        var loc = {};
        loc.result = {};
        loc.query = new query();
        loc.query.addParam(name="departmentName", cfsqltype="cf_sql_varchar", value="#arguments.formData.departmentName#");
		loc.query.addParam(name="departmentDetails", cfsqltype="cf_sql_varchar", value="#arguments.formData.departmentDetails#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");

        if(formData.id GT 0){
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
            loc.sql = "UPDATE department SET department_name=:departmentName,department_details=:departmentDetails";
            loc.sql &= ",updated_by=:admin_id";
            loc.sql &= " where id =:id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            return loc.result;
        }
        else{
            loc.sql = "INSERT INTO department SET department_name=:departmentName,department_details=:departmentDetails";
            loc.sql &= ",created_by=:admin_id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            if(loc.result.recordCount EQ 1){
                  
                loc.returnId = 	loc.result.generatedKey;
            }
            return loc.returnId;  
        }		
        
    }
 
    //Display Department Data Service
    public struct function departmentList(required struct formData)
    { 
        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM department";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT * FROM department";

        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE department_name LIKE :search OR  department_details LIKE :search";
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


    // Delete Department Service
    public function deleteDepartment(required numeric id)
    {
        var loc={};
        var  loc.return=true;
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="SELECT * FROM doctor WHERE doctor_department_id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        if(loc.result.recordCount GT 0){      
            loc.return = 	false;
        }
        else{
            loc.sql="DELETE FROM department WHERE id=:id";
            loc.query.setSQL(loc.sql);
            loc.query.execute();
            loc.return= true;
        }
        return loc.return; 
       
    }


    //Get ID For Update Department Service
    public function getDeptById(required numeric id){
        var result = {};
		var departmentData = queryExecute('select * from department where id = ?', [{value="#arguments.Id#", cfsqltype="CF_SQL_INTEGER"}]);
		if(departmentData.recordCount GT 0){
			result = queryGetRow(departmentData, 1);
		}else{
			result = {
				id = 0,
				department_name = '',
				department_details = '',
			}
		}
		return result;
    }

    //Active Status Department Service
    public function isActiveDept(required numeric id){
        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql = "UPDATE department SET isActive=!isActive WHERE id =:id";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getPrefix();
		return loc.result;
    }

}