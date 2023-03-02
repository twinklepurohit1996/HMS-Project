<cfoutput>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <div class="layout-page">
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
        
        <div class="content-wrapper">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                  <div class="col-lg-12 col-md-12 order-0">
                    <div class="row">
                      <div class="col-lg-3 col-md-6 col-3 mb-2">
                        <div class="card" style="background-color:##d7f5ab;">
                          <div class="card-body" style="position: relative;">
                            <div class="card-title d-flex align-items-start justify-content-between">
                              <div class="avatar flex-shrink-0">
                                <i class="fa-solid fa-mask-face  text-success fa-lg"></i>
                              </div>
                            </div>
                            <div class="text-success fw-semibold" style="font-size: 40px;position: absolute; right: 40px;top: 10px;">#prc.dataDept.total#</div>
                            <span class="fw-semibold d-block mb-1 text-success fs-5">Departments</span>
                            
                          </div>
                        </div>
                      </div>
                      <div class="col-lg-3 col-md-6 col-3 mb-2">
                        <div class="card" style="background-color:##f5e9ab;">
                          <div class="card-body" style="position: relative;">
                            <div class="card-title d-flex align-items-start justify-content-between">
                              <div class="avatar flex-shrink-0">
                                <i class=" text-warning fa-solid fa-user-doctor fa-lg"></i>
                              </div>
                            </div>
                            <div class="text-warning fw-semibold" style="font-size: 40px;position: absolute; right: 40px;top: 10px;">#prc.dataDoctor.total#</div>
                            <span class="fw-semibold d-block mb-1 text-warning fs-5">Doctors</span>
                  
                          </div>
                        </div>
                      </div>

                      <div class="col-lg-3 col-md-6 col-3 mb-2">
                        <div class="card" style="background-color:##f08989;">
                            <div class="card-body" style="position: relative;">
                              <div class="card-title d-flex align-items-start justify-content-between">
                                <div class="avatar flex-shrink-0">
                                  <i class="text-danger fa-solid fa-hospital-user fa-lg"></i>                         
                                </div>
                              </div>
                              <div class="text-danger fw-semibold" style="font-size: 40px;position: absolute; right: 40px;top: 10px;">#prc.dataPatient.total#</div>
                              <span class="fw-semibold d-block mb-1 text-danger fs-5 ">Patients</span>
                            </div>
                        </div>
                      </div>

                      <div class="col-lg-3 col-md-6 col-3 mb-2">
                        <div class="card" style="background-color:##9bb9e8;">
                          <div class="card-body" style="position: relative;">
                            <div class="card-title d-flex align-items-start justify-content-between">
                              <div class="avatar flex-shrink-0">
                                <i class="text-primary fa-solid fa-calendar-check fa-lg"></i>                        
                              </div>
                            </div>
                            <span class="fw-semibold d-block mb-1 text-primary fs-5">Appointments</span>
                            <div class="text-primary fw-semibold" style="font-size: 40px;position: absolute; right: 40px;top: 10px;">#prc.dataAppointment.total#</div>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div>
                </div>   
                <div class="row">
                  <div class="col-lg-12 col-md-12 order-0">
                    <div class="row">
                      <div class="col-lg-3 col-md-6 col-3 mb-2">

                        <div class="card" style="background-color:##f5e9ab;">
                          <div class="card-body" style="position: relative;">
                            <div class="card-title d-flex align-items-start justify-content-between">
                              <div class="avatar flex-shrink-0">
                                <i class="fa-solid fa-user-nurse text-warning fa-lg"></i>
                              </div>
                              <div class="text-warning fw-semibold" style="font-size: 40px;position: absolute; right: 40px;top: 10px;">#prc.dataNurse.TOTAL#</div>
                              </div>
                              <span class="fw-semibold d-block mb-1 text-warning fs-5">Nurse</span>
                            </div>
                          </div>
                        </div>


                        <div class="col-lg-3 col-md-6 col-3 mb-2">
                          <div class="card" style="background-color:##9bb9e8;">
                            <div class="card-body" style="position: relative;">
                              <div class="card-title d-flex align-items-start justify-content-between">
                                <div class="avatar flex-shrink-0">
                                  <i class="text-primary fa-solid fa-bed fa-lg"></i>
                                </div>
                              </div>
                              <div class="text-primary fw-semibold" style="font-size: 40px;position: absolute; right: 40px;top: 10px;">#prc.dataBedAllotment.TOTAL#</div>
                              <span class="fw-semibold d-block mb-1 text-primary fs-5">Bed Reserved</span>
                            </div>
                          </div>
                        </div>


                      <div class="col-lg-3 col-md-6 col-3 mb-2">
                        <!--- <div class="card" style="background-color:##f08989;">
                            <div class="card-body">
                              <div class="card-title d-flex align-items-start justify-content-between">
                                <div class="avatar flex-shrink-0">
                                  <i class="text-danger fa-solid fa-hospital-user"></i>                         
                                </div>
                              </div>
                              <span class="fw-semibold d-block mb-1 text-danger ">Patients</span>
                              <small class="text-danger fw-semibold">#prc.dataPatient.total#</small>
                            </div>
                        </div> --->
                      </div>

                      <div class="col-lg-3 col-md-6 col-3 mb-2">
                        <!--- <div class="card" style="background-color:##9bb9e8;">
                          <div class="card-body">
                            <div class="card-title d-flex align-items-start justify-content-between">
                              <div class="avatar flex-shrink-0">
                                <i class="text-primary fa-solid fa-calendar-check"></i>                        
                              </div>
                            </div>
                            <span class="fw-semibold d-block mb-1 text-primary">Appointments</span>
                            <small class="text-primary fw-semibold">#prc.dataAppointment.total#</small>
                          </div>
                        </div> --->
                      </div>

                    </div>
                  </div>
                </div>
            </div>   
        </div>
      </div>

      
    </div>
  </div>
</cfoutput>