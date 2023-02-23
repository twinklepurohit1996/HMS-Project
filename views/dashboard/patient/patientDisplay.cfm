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
          <h4 class="fw-bold py-2 mb-4"><span class="text-dark fw-light">Dashboard /</span> Patient</h4>


          <form id="frm-example">
 <!-- Basic Bootstrap Table -->
 <div class="card ">
            
  <div class="d-flex justify-content-between">
      <div class="card-header">
          <h5>Patient List</h5>
  </div>
  <div class="card-action">
      <button class=" btn btn-success my-2 me-4"  type="button" id="addBtn" data-bs-toggle="modal" data-bs-target="##addPatient" data-bs-whatever="@getbootstrap" >Add Patient</button>
<!---       <button class=" btn btn-primary my-2 me-4" id="multiDelete"  >Multiple Delete</button> --->
  </div>
</div>
<div class="table-responsive px-3">
<table class="table" id="patientList">
  <thead>
    <tr>
      <th>Patient Name</th>
      <th>Mobile Number</th>
      <th>Email</th>
      <th>Gender</th>
      <th>Blood Group</th>
      <th>Date of Birth</th>
      <th>Aadhar Number</th>
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



<div class="modal fade" id="addPatient" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title" id="patientLabel">Add New Patient</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeBtn"></button>
    </div>
    <div class="modal-body">
      <form method="POST" id="addPatientForm" action="#event.buildLink('patient.addPatient')#" >
        
        <div class="mb-3">
            <input type="hidden" class="form-control" name="id" value="0" id="id"/>
        </div>
        <div class="row">
          <div class="col-sm-1"></div>
          <div class="col-sm-5">
            <div class="mb-3">
              <label class="col-form-label">Patient Name</label>
              <input type="text" class="form-control" name="patient_name" id="patient_name" value="" placeholder="Enter a Patient Name">
            </div>

            <div class="mb-3">
              <label class="col-form-label">Mobile Number</label>
              <input type="text" class="form-control" name="patient_mobile" id="patient_mobile" value="" placeholder="Enter a Patient Mobile">
            </div>

            <div class="mb-3">
              <label class="col-form-label">Email</label>
              <input class="form-control" name="patient_email" id="patient_email" value="" type="email" placeholder="Enter a Patient email "/>
            </div>

            <div class="mb-3">
              <label class="col-form-label">Password</label>
              <input type="password" class="form-control" name="patient_password" id="patient_password"  value="" placeholder="Enter a Patient Password">
            </div>

            <div class="mb-3">
              <label class="col-form-label">Aadhar Number</label>
              <input type="text" class="form-control" name="patient_aadhar_no" id="patient_aadhar_no" value="" placeholder="Enter a Patient Aadhar Number">
            </div>
          </div>
          <div class="col-sm-5">
            <div class="mb-3">
              <label class="col-form-label">Address</label>
              <input type="text" class="form-control" name="patient_address" id="patient_address" value="" placeholder="Enter a Patient Address">
            </div>
            
            <div class="mb-3">
              <label class="col-form-label">Blood Group</label>
              <select class="form-select" name="patient_blood_group_id" id="patient_blood_group_id">
                <option value="" selected>Select Blood Group</option>
                <cfloop query="prc.result">
                    <option value="#prc.result.id#">#prc.result.name#</option>
                </cfloop>
              </select>
            </div>

            <div class="mb-3">
              <label class="col-form-label">Date of Birth</label>
              <input type="date" class="form-control" name="patient_dob" id="patient_dob" value="">
            </div>

            <div class="mb-2">
              <label class="col-form-label">Gender</label>
              <div class="form-check">
										<input type="radio" class="form-check-input" name="patient_gender"  id="patient_gender" value="Male">
                <label class="form-check-label" >
                  Male
                </label>
              </div>
              <div class="form-check">
										<input type="radio" class="form-check-input" name="patient_gender" id="patient_gender" value="Female">
                <label class="form-check-label" >
                  Female
                </label>
              </div>
              <div class="form-check">
                    <input type="radio" class="form-check-input" name="patient_gender" id="patient_gender" value="Others">
                <label class="form-check-label" >
                  Others
                </label>
              </div>
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