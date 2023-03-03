component singleton accessors="true"{

    //Add or Update pharmacy Service
    public any function saveMedicine(required struct formData,required numeric admin_id){
 

        var loc = {};
        loc.result = {};
        loc.query = new query();
        loc.query.addParam(name="medicine_name", cfsqltype="cf_sql_varchar", value="#arguments.formData.medicine_name#");
		loc.query.addParam(name="medicine_company", cfsqltype="cf_sql_varchar", value="#arguments.formData.medicine_company#");
        loc.query.addParam(name="medicine_quantity", cfsqltype="cf_sql_varchar", value="#arguments.formData.medicine_quantity#");
		loc.query.addParam(name="medicine_maufacturing_date", cfsqltype="cf_sql_date", value="#arguments.formData.medicine_maufacturing_date#");
        loc.query.addParam(name="medicine_expiry_date", cfsqltype="cf_sql_date", value="#arguments.formData.medicine_expiry_date#");
		loc.query.addParam(name="medicine_description", cfsqltype="cf_sql_varchar", value="#arguments.formData.medicine_description#");
        loc.query.addParam(name="admin_id", cfsqltype="cf_sql_integer", value="#arguments.admin_id#");
        if(formData.id GT 0){
       
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.formData.id#");
            loc.sql = "UPDATE pharmacy SET medicine_name=:medicine_name,medicine_company=:medicine_company,medicine_quantity=:medicine_quantity,medicine_maufacturing_date=:medicine_maufacturing_date,medicine_expiry_date=:medicine_expiry_date,medicine_description=:medicine_description";
            
            loc.sql &= ",updated_by=:admin_id";
            loc.sql &= " where id =:id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            return loc.result;
        }
        else{
            loc.sql = "INSERT INTO pharmacy SET medicine_name=:medicine_name,medicine_company=:medicine_company,medicine_quantity=:medicine_quantity,medicine_maufacturing_date=:medicine_maufacturing_date,medicine_expiry_date=:medicine_expiry_date,medicine_description=:medicine_description,created_by=:admin_id";
            loc.query.setSQL(loc.sql);
            loc.result = loc.query.execute().getPrefix();
            writeDump(loc.result)
            if(loc.result.recordCount EQ 1){
                    
                loc.returnId = 	loc.result.generatedKey;
            }
            return loc.returnId; 
        } 	
    }

    //Display medicine List Service
    public struct function medicineList(required struct formData)
    { 
        var loc = {};
        loc.res = {"total": 0, "records": []};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM pharmacy";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        loc.res.total = loc.result.total;
        loc.sql = " SELECT *  FROM pharmacy  ";
        if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
            loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
            loc.sql &= " WHERE medicine_name LIKE :search";
        }
        if(structKeyExists(arguments.formData, "order") AND len(trim(arguments.formData.order)) GT 0){
            loc.sql &= " ORDER BY #arguments.formData.order#";
        }
        loc.sql &= " limit #formData.start#, #formData.length# ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
        // writeDump(loc.result);
        // abort;
        for(loc.i in loc.result){
            arrayAppend(loc.res.records, loc.i);
        }
		return loc.res;
    }


    //Delete pharmacy Service
    public function deleteMedicine(required numeric id)
    {

        var loc={};
        loc.query= new query();
        loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
        loc.sql="DELETE FROM pharmacy WHERE id=:id";
        loc.query.setSQL(loc.sql);
        loc.result=loc.query.execute();
        return loc.result; 
    }

    //Get id for edit of medicine in pharmacy module
    public function getMedicineById(required numeric id){
        var result = {};
		var pharmacyData = queryExecute('select * from pharmacy where id = ?', [{value="#arguments.Id#", cfsqltype="CF_SQL_INTEGER"}]);
		if(pharmacyData.recordCount GT 0){
			result = queryGetRow(pharmacyData, 1);
		}else{
			result = {
				id = 0,
                medicine_name='',
                medicine_company='',
                medicine_quantity='',
                medicine_maufacturing_date='',
                medicine_expiry_date='',
                medicine_description='',
			}
		}
		return result;
    }

}