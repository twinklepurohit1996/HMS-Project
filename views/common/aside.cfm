<cfoutput>
                <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                  <div class="app-brand demo">
                    <a href="#event.buildLink('home.index')#" class="app-brand-link">
                      <span class="app-brand-logo demo">
                        <img src="includes/assets/img/favicon/favicon.ico">
  
                      </span>
                      <span class="app-brand-text demo menu-text fw-bolder ">Admin</span>
                    </a>
        
                    <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                      <i class="bx bx-chevron-left bx-sm align-middle"></i>
                    </a>
                  </div>
        
                  <div class="menu-inner-shadow"></div>
        
                  <ul class="menu-inner py-1">
                    <!-- Dashboard -->
                    <li class="menu-item active">
                      <a href="#event.buildLink('home.index')#" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-home-circle"></i>
                        <div data-i18n="Analytics">Dashboard</div>
                      </a>
                    </li>
         
                     <!-- Department -->
                     <li class="menu-item active">
                      <a href="#event.buildLink('home.dept')#" class="menu-link">
                        <i class="fa-solid fa-mask-face me-2"></i>
                        <div data-i18n="Analytics">Department</div>
                      </a>
                    </li>

                     <!-- Doctor -->
                     <li class="menu-item active">
                      <a href="#event.buildLink('home.doctor')#" class="menu-link">
                        <i class="fa-solid fa-user-doctor me-3"></i>
                        <div data-i18n="Analytics">Doctor</div>
                      </a>
                    </li>

                       <!-- Nurse Module -->
                       <li class="menu-item active">
                        <a href="#event.buildLink('home.nurse')#" class="menu-link">
                          <i class="fa-solid fa-user-nurse me-2"></i>                        
                          <div data-i18n="Analytics">Nurse</div>
                        </a>
                      </li>


                    <!-- Patient Module -->
                    <li class="menu-item active">
                      <a href="#event.buildLink('home.patient')#" class="menu-link">
                        <i class="fa-solid fa-hospital-user me-2"></i>                         
                        <div data-i18n="Analytics">Patient</div>
                      </a>
                    </li>


                     <!-- Appointment Module -->
                     <li class="menu-item active">
                      <a href="#event.buildLink('home.appointment')#" class="menu-link">
                        <i class="fa-solid fa-calendar-check me-2"></i>                        
                        <div data-i18n="Analytics">Appointment</div>
                      </a>
                    </li>

                    <!-- Bed Allotment Module -->
                    <li class="menu-item active">
                      <a href="#event.buildLink('home.bedAllotment')#" class="menu-link">
                        <i class="fa-solid fa-bed me-2"></i>
                        <div data-i18n="Analytics">Bed Allotment</div>
                      </a>
                    </li>

                  </ul>
                </aside>
</cfoutput>