<cfoutput>
    <div class="container">
        <div class="row">
            <div class="col-sm-3"></div>
            <div class="col-sm-6">
                <div class="container-xxl">
                    <div class="authentication-wrapper authentication-basic container-p-y">
                      <div class="authentication-inner">
                        <div class="card">
                          <div class="card-body">
                            <div class="app-brand justify-content-center">
                              <a href="" class="app-brand-link gap-2">
                                <span class="app-brand-logo demo">
                                    <img src="includes/assets/img/favicon/favicon.ico">
                                </span>
                                <span class="app-brand-text demo text-body fw-bolder">Admin</span>
                              </a>
                            </div>
                            <div>
                                #cbMessageBox().renderIt()#

                            </div>
                            <form id="formAuthentication" class="mb-3" action="#event.buildLink('auth.doLogin')#" method="POST">
                              <div class="mb-3">
                                <label for="email" class="form-label">Email or Username</label>
                                <input
                                  type="text"
                                  class="form-control"
                                  id="email"
                                  name="userName"
                                  placeholder="Enter your email or username"
                                  autofocus
                                />
                              </div>
                              <div class="mb-3 form-password-toggle">
                                <div class="d-flex justify-content-between">
                                  <label class="form-label" for="password">Password</label>
                                </div>
                                <div class="input-group input-group-merge">
                                  <input
                                    type="password"
                                    id="password"
                                    class="form-control"
                                    name="password"
                                    placeholder="Enter your password"
                                    aria-describedby="password"
                                  />
                                  <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                                </div>
                              </div>
                              <div class="mb-3">
                                <button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
                              </div>
                            </form>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
            </div>
            <div class="col-sm-3"></div>
        </div>
    </div>
</cfoutput>