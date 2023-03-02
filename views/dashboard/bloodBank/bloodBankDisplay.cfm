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
          <h4 class="fw-bold py-2 mb-4"><span class="text-dark fw-light">Dashboard /</span> Blood Bank</h4>


          <form id="frm-example">
 <!-- Basic Bootstrap Table -->
 <div class="card ">
            
  <div class="d-flex justify-content-between">
      <div class="card-header">
          <h5>Records of Donor & Receiver</h5>
  </div>
  <div class="card-action">
      <button class=" btn btn-success my-2 me-4"  type="button" id="addBtn" data-bs-toggle="modal" data-bs-target="##addCandidate" data-bs-whatever="@getbootstrap" >Add Candidate</button>
  </div>
</div>
<div class="table-responsive px-3">
<table class="table" id="candidateList">
  <thead>
    <tr>
      <th>Candidate Name</th>
      <th>Type</th>
      <th>Blood Unit</th>
      <th>Mobile Number</th>
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



<div class="modal fade" id="addCandidate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl">
  <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title" id="candidateLabel">Add New Candidate</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeBtn"></button>
    </div>
    <div class="modal-body">
      <form method="POST" id="addCandidateForm" action="#event.buildLink('bloodBank.addCandidate')#" >
        
        <div class="mb-3">
            <input type="hidden" class="form-control" name="id" value="0" id="id"/>
        </div>
        <div class="row">
          <div class="col-sm-1"></div>
          <div class="col-sm-5">
            <div class="mb-3">
              <label class="col-form-label">Candidate Name</label>
              <input type="text" class="form-control" name="candidate_name" id="candidate_name" value="" placeholder="Enter a Candidate Name">
            </div>

            <div class="mb-3">
                <label class="col-form-label">Type Of Candidate</label>
                <select class="form-select" name="candidate_type" id="candidate_type">
                  <option value="" selected>Select Candidate Type</option>
                  <option value="Donor">Donor</option>
                  <option value="Receiver">Receiver</option>
                </select>
              </div>

            <div class="mb-3">
              <label class="col-form-label">Mobile Number</label>
              <input type="text" class="form-control" name="mobile_number" id="mobile_number" value="" placeholder="Enter a Candidate Mobile">
            </div>

            <div class="mb-3">
              <label class="col-form-label">Email</label>
              <input class="form-control" name="email" id="email" value="" type="email" placeholder="Enter a Candidate email "/>
            </div>

            <div class="mb-3">
              <label class="col-form-label">Aadhar Number</label>
              <input type="text" class="form-control" name="aadhar_number" id="aadhar_number" value="" placeholder="Enter a Candidate Aadhar Number">
            </div>
          </div>
          <div class="col-sm-5">
            <div class="mb-3">
              <label class="col-form-label">Address</label>
              <input type="text" class="form-control" name="address" id="address" value="" placeholder="Enter a Candidate Address">
            </div>

            <div class="mb-3">
              <label class="col-form-label">Blood Unit</label>
              <input type="text" class="form-control" name="blood_unit" id="blood_unit" value="" placeholder="Enter a Candidate Blood Unit">
            </div>
            
            <div class="mb-3">
              <label class="col-form-label">Blood Group</label>
              <select class="form-select" name="blood_group_id" id="blood_group_id">
                <option value="" selected>Select Blood Group</option>
                <cfloop query="prc.result">
                    <option value="#prc.result.id#">#prc.result.name#</option>
                </cfloop>
              </select>
            </div>

            <div class="mb-3">
              <label class="col-form-label">Date of Birth</label>
              <input type="date" class="form-control" name="dob" id="dob" value="">
            </div>

            <div class="mb-2">
              <label class="col-form-label">Gender</label>
              <div class="form-check">
                <input type="radio" class="form-check-input" name="gender"  id="gender" value="Male">
                <label class="form-check-label" >
                  Male
                </label>
              </div>
              <div class="form-check">
                <input type="radio" class="form-check-input" name="gender" id="gender" value="Female">
                <label class="form-check-label" >
                  Female
                </label>
              </div>
              <div class="form-check">
                    <input type="radio" class="form-check-input" name="gender" id="gender" value="Others">
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