component singleton accessors="true"{

    //Display total number of department count store in database
    public query function totalDepartment(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM department";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Display total number of doctor count store in database
    public query function totalDoctor(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM doctor";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

     //Display total number of nurse count store in database
     public query function totalNurse(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM nurse";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Display total number of patient count store in database
    public query function totalPatient(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM patient";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

    //Display total number of appointment count store in database
    public query function totalAppointment(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT count(1) as total FROM appointment";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }

     //Display total number of bed alloted count store in database
     public query function totalBedAllotment(){
        var loc = {};
        loc.query = new query();
        loc.sql = "SELECT SUM(isbedAllotment) as total FROM appointment ";
        loc.query.setSQL(loc.sql);
        loc.result = loc.query.execute().getResult();
		return loc.result;
    }
}