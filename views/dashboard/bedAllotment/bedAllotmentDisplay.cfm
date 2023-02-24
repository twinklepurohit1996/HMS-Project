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
          <h4 class="fw-bold py-2 mb-4"><span class="text-dark fw-light">Dashboard /</span>Bed Allotment</h4>
          <form id="frm-example">
 <!-- Basic Bootstrap Table -->
 <div class="card ">
            
  <div class="d-flex justify-content-between">
      <div class="card-header">
          <h5>Bed Allotment List</h5>
  </div>
  <div class="card-action">
      <button class=" btn btn-success my-2 me-4"  type="button" id="addBtn" data-bs-toggle="modal" data-bs-target="##bedAllotment" data-bs-whatever="@getbootstrap" >Bed Allotment</button>
  </div>
</div>
<div class="table-responsive px-3">
<table class="table" >
  <thead>
    <tr>
      <th>Patient Token ID</th>
      <th>Patient Name</th>
      <th>Department Name</th>
      <th>Bed Allotment Number</th>
      <th>Assigned Doctor</th>
      <th>Admit Start Date</th>
      <th>Admit End Date</th>
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



<div class="modal fade" id="bedAllotment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title" id="bedAllotmentLabel">Add New Bed Allotment</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeBtn"></button>
    </div>
    <div class="modal-body">
      <form method="POST" id="bedAllotmentForm" action="#event.buildLink('bedAllotment.addAllotment')#" >
        
            <div class="mb-2">
                <input type="hidden" class="form-control" name="id" value="0" id="id"/>
            </div>

            <div class="mb-2">
              <label class="col-form-label">Department Name</label>
              <select class="form-select"  name="department_id" id="department_id">
                <option value="" selected>Select Department</option>
                  <cfloop query="prc.resultDept">
                      <option value="#prc.resultDept.id#"># prc.resultDept.department_name#</option>
                  </cfloop>
              </select>
            </div>

            <div class="mb-2">
              <label class="col-form-label">Patient Name</label>
              <select class="form-select" name="patient_id" id="patient_id">
                <option value="" selected>Select Patient</option>
              </select>
            </div>

            <div class="mb-2">
              <label class="col-form-label">Bed Number</label>
              <select class="form-select"  name="bed_number" id="bed_number">
                <option value="" selected>Select Bed Number</option>
              </select>
            </div>

            <div class="mb-2">
              <label class="col-form-label">Allotment Start Date</label>
              <div>
                <input type="text" class="form-control" name="start_date" id="start_date" readonly/>
              </div>
            </div>
            <div class="mb-2">
              <label class="col-form-label">Allotment End Date</label>
              <div>
                <input type="text" class="form-control" name="end_date" id="end_date" readonly/>
              </div>
            </div>

            <div class="text-center mb-2">
                <button type="submit" class="btn btn-primary" id="bb">Insert</button>
            </div>
      </div>
      </form>
    </div>
  </div>
</div>
</div>
</cfoutput>