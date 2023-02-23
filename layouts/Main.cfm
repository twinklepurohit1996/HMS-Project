<cfoutput>
<!doctype html>
<html lang="en" >
<head>
	<!--- Metatags --->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="ColdBox Application Template">
    <meta name="author" content="Ortus Solutions, Corp">

	<!---Base URL --->
	<base href="#event.getHTMLBaseURL()#" />
	<!---DatePicker css--->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		
	<!----DataTable css--->
	<link rel="stylesheet" href="includes/assets/css/jquery.dataTables.min.css"/>
	<!---css --->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	 <!-- Favicon -->
	 <link rel="icon" type="image/x-icon" href="includes/assets/img/favicon/favicon.ico" />

	 <!-- Fonts -->
	 <link rel="preconnect" href="https://fonts.googleapis.com" />
	 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	 <link
	   href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	   rel="stylesheet"
	 />
 
	 <!-- Icons. Uncomment required icon fonts -->
	 <link rel="stylesheet" href="includes/assets/vendor/fonts/boxicons.css" />
 
	 <!-- Core CSS -->
	 <link rel="stylesheet" href="includes/assets/vendor/css/core.css" class="template-customizer-core-css" />
	 <link rel="stylesheet" href="includes/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
	 <link rel="stylesheet" href="includes/assets/css/demo.css" />


	 <!-- Vendors CSS -->
	 <link rel="stylesheet" href="includes/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
 
	 <link rel="stylesheet" href="includes/assets/vendor/libs/apex-charts/apex-charts.css" />
 
	 <!-- Page CSS -->
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	 <!-- Helpers -->
	 <script src="includes/assets/vendor/js/helpers.js"></script>
 
	 <!-- moment.js for date and time-->
	 <script src="includes/assets/js/moment.min.js"></script>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
	 <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
	 <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
	 <script src="includes/assets/js/config.js"></script>
	 <script src="includes/assets/js/jquery.min.js"></script>
	 <script src="includes/assets/js/sweetalert2@11.js"></script>

	<!--- Title --->
	<title>Welcome to Coldbox!</title>
</head>
<body
>
	<!---Top NavBar --->
	
	
<!--- 	#renderView('common/header')#  --->
	<main class="d-flex">
		#renderView('common/aside')#
		
	<!---Container And Views --->
		#renderView()#
	</main>

	<!--- Footer --->
	#renderView('common/footer')# 

	 <!-- Core JS -->

    <!-- build:js assets/vendor/js/core.js -->
    <script src="includes/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="includes/assets/vendor/libs/popper/popper.js"></script>
    <script src="includes/assets/vendor/js/bootstrap.js"></script>
    <script src="includes/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>


    <script src="includes/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="includes/assets/vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="includes/assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="includes/assets/js/dashboards-analytics.js"></script>
	<script src="includes/assets/js/jquery.validate.min.js"></script>
	<script src="includes/assets/js/jquery.dataTables.min.js"></script>



    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>

 <!---DatePicker js--->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!---js --->
<!--- 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> --->
<!--- 	<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script> --->
</body>
</html>
</cfoutput>
