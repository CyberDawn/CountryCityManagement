<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUsUI.aspx.cs" Inherits="CountryCityInformationManagementSystem.UI.ContactUsUI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/Style.css" rel="stylesheet" />
    <title>Contact Us</title>
</head>

<body>
<div class="container">
  <nav class = "navbar navbar-default" style="margin-left: 60px; margin-right: 60px; margin-top: 20px" role = "navigation">
    <div class = "navbar-header">
        <button type = "button" class = "navbar-toggle" 
            data-toggle = "collapse" data-target = "#example-navbar-collapse">
            <span class = "sr-only">Toggle navigation</span>
            <span class = "icon-bar"></span>
            <span class = "icon-bar"></span>
            <span class = "icon-bar"></span>
        </button>
        <a class = "navbar-brand" href = "Index.aspx"><b>Country City Information Management System</b></a>
    </div>
        <div class = "collapse navbar-collapse" id ="example-navbar-collapse">
        <ul class = "nav navbar-nav">
            <li> <a href="Index.aspx"> Home </a></li>
            <li> <a href="CountryEntryUI.aspx"> Country Entry </a> </li>
            <li> <a href="CityEntryUI.aspx">City Entry </a> </li>
            <li> <a href="ViewCitiesUI.aspx"> View Cities </a> </li>
            <li> <a href="ViewCountriesUI.aspx"> View Countries </a> </li>
        </ul>
    </div>
  </nav>
</div>
<div class="text-center" style="width: auto; margin: 0 105px 20px 105px; padding: 10px 0 10px 0; background-color: #F2F3ED">
  <h3 style="font-size: 18px; color:#23527c"><strong><u>Feel free to Contact Us</u></strong>  </h3>
    <p style="font-size: 13px; color: #008080;">
       
        A.Q.M. Salauddin Pathan  <br/>
        <i>akashbolt@gmail.com</i> <br/> <br/>
        Mithun Biswas  <br/>
        <i>mranjon@gmail.com</i> <br /> <br/>
        Sumaiya Tasmim <br/> 
        <i>nuha.khan4@gmail.com</i> <br/> <br/>
        Kamlesh Thakur  <br />
        <i>thakurkamlesh10@gmail.com</i> <br/> <br/>
        
    </p>
</div>
    
<footer style="margin-bottom: 20px">
    <div class="container" style="display: inline;">
        <div class="navtwo">
	    <ul style="display: inline;">
	        <li style="float:left; padding-left: 15px; color:#23527C"> © Designed by CyberDawn </li>  
		    <li style="float: right;  padding-right: 15px;"><a href="ContactUsUI.aspx">Contact Us</a></li>	
	    </ul>
        </div>
    </div>
</footer>

</body>
</html>
