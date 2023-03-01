<cfoutput>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">

  
          <!-- Layout container -->
          <div class="layout-page">

            <!-- Navbar -->

            <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar"
            >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>
            
            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <!-- Search -->
              <div class="navbar-nav align-items-center">
                <div class="nav-item d-flex align-items-center">
                  <h3 class="my-2 text-dark">Hospital Management System</h3>
                </div>
              </div>
            
              <ul class="navbar-nav flex-row align-items-center ms-auto">
            
                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                      <img src="includes/assets/img/avatars/6.png" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#event.buildLink('home.index')#">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="includes/assets/img/avatars/6.png" alt class="w-px-40 h-auto rounded-circle" />
                            </div>
                          </div>
                          <div class="flex-grow-1">
                            <span class="fw-semibold d-block">Twinkle Purohit</span>
                            <small class="text-muted">Admin</small>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#event.buildLink('home.Logout')#">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
            </nav>
            
            <!-- / Navbar -->
      <!-- Content wrapper -->
      <div class="content-wrapper">
        <!-- Content -->

        <div class="container-xxl flex-grow-1 container-p-y">
          <h4 class="fw-bold py-2 mb-4"><span class="text-dark fw-light">Dashboard /</span> Doctor</h4>


          <form id="frm-example" >
 <!-- Basic Bootstrap Table -->
 <div class="card ">
            
  <div class="d-flex justify-content-between">
      <div class="card-header">
          <h5>Doctor List</h5>
  </div>
  <div class="card-action">
      <button class=" btn btn-success my-2 me-4"  type="button" id="addBtn" data-bs-toggle="modal" data-bs-target="##addDoctor" data-bs-whatever="@getbootstrap" >Add Doctor</button>
  </div>
</div>
<div class="table-responsive px-3">
<table class="table" id="doctorList">
  <thead>
    <tr>
      <th>Doctor Name</th>
      <th>Image</th>
      <th>Mobile Number</th>
      <th>Email</th>
      <th>Fees</th>
      <th>Date of Birth</th>
      <th>Dempartment</th>
      <th>Doctor Status</th> 
      <th>Action</th>
    </tr>
  </thead>
</table>
</div>
</div>
<!--/ Basic Bootstrap Table -->
          </form>
         
        </div>
        </div>
    </div>
</div>
</div>



<div class="modal fade" id="addDoctor" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title" id="doctorLabel">Add New Doctor</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeBtn"></button>
    </div>
    <div class="modal-body">
      <form method="POST" id="addDoctorForm" action="#event.buildLink('doctor.addDoctor')#" enctype="multipart/form-data">
        
        <div class="mb-3">
            <input type="hidden" class="form-control" name="id" value="0" id="id"/>
        </div>
        <div class="row">
          <div class="col-sm-1"></div>
          <div class="col-sm-5">
            <div class="">
              <label class="col-form-label">Doctor Name<span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="doctor_name" id="doctor_name" value="" placeholder="Enter a Doctor Name">
            </div> 
            <div class="">
              <label class="col-form-label">Qualification/Specialization<span class="text-danger">*</span></label>
              <input class="form-control" name="doctor_education" id="doctor_education" value="" placeholder="Enter a Qualification & Specialization "/>
            </div>
            <div class="">
              <label class="col-form-label">Date of Birth<span class="text-danger">*</span></label>
              <input type="date" class="form-control" name="doctor_dob" id="doctor_dob" value="">
            </div>
            <div class="">
              <label class="col-form-label">Address<span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="doctor_address" id="doctor_address" value="" placeholder="Enter a Doctor Address">
            </div>
<!---            <!---  <div class=""> --->
              <label class="col-form-label">Mobile Number<span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="doctor_mobile" id="doctor_mobile" value="" placeholder="Enter a Doctor Mobile">
            </div> --->
            <div class="">
              <label class="col-form-label">Doctor Image<span class="text-danger">*</span></label>
              <input type="file" class="form-control" name="image" id="image" value="">
            </div>
            <div>
              <input type="text" class="form-control" id="imageText" value="" name="imageText" readonly>
              <img id="imgPreview" src="" class="mt-2 w-25 h-25" > 
            </div>
          </div>
          <div class="col-sm-5">
            <div class="">
              <label class="col-form-label">Mobile Number<span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="doctor_mobile" id="doctor_mobile" value="" placeholder="Enter a Doctor Mobile">
            </div>
            <!--- <div class="">
              <label class="col-form-label">Doctor_OPD_Start_Time<span class="text-danger">*</span></label>
              <input type="time" class="form-control" name="doctor_opd_start" id="doctor_opd_start" value="08:00">
            </div>
            <div class="">
              <label class="col-form-label">Doctor_OPD_End_Time<span class="text-danger">*</span></label>
              <input type="time" class="form-control" name="doctor_opd_end" id="doctor_opd_end" value="02:00">
            </div> --->
            <div class="">
              <label class="col-form-label">Fees<span class="text-danger">*</span></label>
              <input type="text" class="form-control" name="doctor_fees" id="doctor_fees" value="" placeholder="Enter a Doctor Fees">
            </div>
            <div class="">
              <label class="col-form-label">Email<span class="text-danger">*</span></label>
              <input type="email" class="form-control" name="doctor_email" id="doctor_email" value="" placeholder="Enter a Doctor Email">
            </div>
            <div class="">
              
              <label class="col-form-label">Password<span class="text-danger">*</span></label>
              <input type="password" class="form-control" name="doctor_password" id="doctor_password"  value="" placeholder="Enter a Doctor Password">
            </div>
           
            <div class="">
              <label class="col-form-label">Department<span class="text-danger">*</span></label>
              <select class="form-select" name="doctor_department_id" id="doctor_department_id">
                  <option value="" selected>Select Department</option>
                  <cfloop query="prc.result">
                      <option value="#prc.result.id#">#prc.result.department_name#</option>
                  </cfloop>
              </select>
  
            </div>
          </div>
          <div class="col-sm-1"></div>
          <div class="text-center">
            <button type="submit" class="btn btn-primary" id="bb">Insert</button>

        </div>
        </div>
        
        
          
                                 
          
      
      </form>
    </div>
  </div>
</div>
</div>
</cfoutput>