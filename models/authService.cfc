component singleton accessors="true"{

    property name="sessionStorage" inject="sessionStorage@cbstorages";

    //Admin Login Service
    function adminLogin(required struct formData){
        var loc = {};
        loc.result = {};
        loc.query = new query();
        loc.query.addParam(name="userName", cfsqltype="cf_sql_varchar", value="#arguments.formData.userName#");
		loc.query.addParam(name="password", cfsqltype="cf_sql_varchar", value="#arguments.formData.password#");
        loc.sql = 'SELECT * FROM  administrator WHERE userName=:userName AND password=:password';
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }
   
    //Admin Logout Service
    function adminLogout()
    {
        sessionStorage.clearAll();
    }
}