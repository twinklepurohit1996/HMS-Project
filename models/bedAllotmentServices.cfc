component singleton accessors="true"{

     //Display bedAllotmentList using dataTable of Jquery in bedAllotment module
     public struct function bedAllotmentList(required struct formData)
     { 
         var loc = {};
         loc.res = {"total": 0, "records": []};
         loc.query = new query();
         loc.sql = "SELECT count(1) as total FROM appointment WHERE isAdmit = 1";
         loc.query.setSQL(loc.sql);
         loc.result = loc.query.execute().getResult();
         loc.res.total = loc.result.total;
         loc.sql = " SELECT *  FROM appointment LEFT JOIN patient ON appointment.patient_id = patient.id LEFT JOIN department ON appointment.department_id = department.id WHERE appointment.isAdmit = 1";
         if(structKeyExists(arguments.formData, "search") AND len(arguments.formData.search) GT 0){
             loc.query.addParam(name="search", cfsqltype="cf_sql_varchar", value="%#arguments.formData.search#%");
             loc.sql &= " AND patient_name LIKE :search";
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

          //bedAllotment of patient in bedAllotment Service
          public function isbedAllotmentPatient(required numeric id,required numeric department_id){
            var loc={};
            loc.res = {"bednumber":0,"available":0,"reserved":0,getAdmit:[],updateBedAllotment:[],updateDept:[],updateBedNumber:[]};
            loc.query= new query();
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
            loc.query.addParam(name="department_id", cfsqltype="cf_sql_integer", value="#arguments.department_id#");

            loc.sql1 = "SELECT isAdmit FROM appointment WHERE id=:id";
            loc.query.setSQL(loc.sql1);
            loc.res.getAdmit = loc.query.execute().getResult();

            loc.sql2 = "UPDATE appointment SET isbedAllotment=1   WHERE id =:id";
            loc.query.setSQL(loc.sql2);
            loc.res.updateBedAllotment = loc.query.execute().getPrefix();

            loc.sql3 = "SELECT SUM(isbedAllotment) as reserved FROM appointment WHERE department_id=:department_id";
            loc.query.setSQL(loc.sql3);
            loc.result = loc.query.execute().getResult();
            loc.res.reserved = loc.result.reserved;

            loc.sql4 = "UPDATE department SET department_reserved_bed=#loc.res.reserved# WHERE id =:department_id";
            loc.query.setSQL(loc.sql4);
            loc.res.updateDept = loc.query.execute().getPrefix();

            loc.sql5 = "SELECT department_bed_total - department_reserved_bed as available FROM department WHERE id=:department_id";
            loc.query.setSQL(loc.sql5);
            loc.result = loc.query.execute().getResult();
            loc.res.available = loc.result.available;


            loc.sql6 = "UPDATE department SET department_available_bed=#loc.res.available# WHERE id =:department_id";
            loc.query.setSQL(loc.sql6);
            loc.res.updateDept = loc.query.execute().getPrefix();

            loc.sql7 = "SELECT department_bed_total FROM department WHERE id=:department_id";
            loc.query.setSQL(loc.sql7);
            loc.result1 = loc.query.execute().getResult();

            loc.sql8 = "SELECT bed_number FROM appointment WHERE department_id=:department_id AND bed_number!=0 order by bed_number ";
            loc.query.setSQL(loc.sql8);
            loc.result2 = loc.query.execute().getResult();

            var mNo = 0; 
            for(var i=1;i <= loc.result1.department_bed_total;i++){
                if(!listFindNoCase(valueList(loc.result2.bed_number), i)){
                    mNo = i;
                    break;
                }
                
            }
            loc.sql9 = "UPDATE appointment SET bed_number=#mNo# WHERE id =:id";
            loc.query.setSQL(loc.sql9);
            loc.res.updateBedNumber = loc.query.execute().getPrefix(); 
            writeDump(loc.res.updateBedNumber);
            return loc.res;
        }


         //discharge of patient in bedAllotment Service
         public function dischargePatient(required numeric id,required numeric department_id){
            var loc={};
            loc.res = {"available":0,"reserved":0,getAdmit:[],updateBedAllotment:[],updateDept:[],updateBedNumber:[]};            
            loc.query= new query();
            loc.query.addParam(name="id", cfsqltype="cf_sql_integer", value="#arguments.id#");
            loc.query.addParam(name="department_id", cfsqltype="cf_sql_integer", value="#arguments.department_id#");

            loc.sql1 = "SELECT isAdmit FROM appointment WHERE id=:id";
            loc.query.setSQL(loc.sql1);
            loc.res.getAdmit = loc.query.execute().getResult();

            loc.sql2 = "UPDATE appointment SET isbedAllotment=0 , isAdmit=0  WHERE id =:id";
            loc.query.setSQL(loc.sql2);
            loc.res.updateBedAllotment = loc.query.execute().getPrefix();

            loc.sql3 = "SELECT SUM(isbedAllotment) as reserved FROM appointment WHERE department_id=:department_id";
            loc.query.setSQL(loc.sql3);
            loc.result = loc.query.execute().getResult();
            loc.res.reserved = loc.result.reserved;

            loc.sql4 = "UPDATE department SET department_reserved_bed=#loc.res.reserved# WHERE id =:department_id";
            loc.query.setSQL(loc.sql4);
            loc.res.updateDept = loc.query.execute().getPrefix();

            loc.sql5 = "SELECT department_bed_total - department_reserved_bed as available FROM department WHERE id=:department_id";
            loc.query.setSQL(loc.sql5);
            loc.result = loc.query.execute().getResult();
            loc.res.available = loc.result.available;

            loc.sql6 = "UPDATE department SET department_available_bed=#loc.res.available# WHERE id =:department_id";
            loc.query.setSQL(loc.sql6);
            loc.res.updateDept = loc.query.execute().getPrefix();
          
            loc.sql8 = "UPDATE appointment SET bed_number=0 WHERE id =:id";
            loc.query.setSQL(loc.sql8);
            loc.res.updateBedNumber = loc.query.execute().getPrefix();

            return loc.res;
        }


}  

   


    
   
    


    

    
