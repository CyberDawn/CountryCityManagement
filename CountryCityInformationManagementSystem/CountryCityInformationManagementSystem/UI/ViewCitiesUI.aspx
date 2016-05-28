<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCitiesUI.aspx.cs" Inherits="CountryCityInformationManagementSystem.UI.ViewCities" ValidateRequest="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Country Entry</title>
    <script src="../Models/Country.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet"/>
    <%--<link href="../Content/DataTables/css/jquery.dataTables.css" rel="stylesheet"/>--%>
    <link href="../Content/DataTables/css/dataTables.bootstrap4.css" rel="stylesheet" />
    <style>
        label.error {
            color: red;
            font-style: italic
        }

        table.dataTable tr.odd {
            background-color: #F2F3ED;
            border: 1px lightgrey;
        }

        table.dataTable tr.even {
            background-color: #F1F1F1;
            border: 1px lightgrey;
        }

        table.dataTable tr.hover { color: white }

        legend.scheduler-border {
            width: inherit; /* Or auto */
            /*padding:30px;*//* To give a bit of padding on the left and right */
            border-bottom: none;
            /*margin-bottom: 20px;*/
        }

        fieldset.scheduler-border {
            width: inherit; /* Or auto */
            padding: 30px; /* To give a bit of padding on the left and right */
            border-bottom: none;
            margin-bottom: 20px;
            border: 1px solid lightgray;
        }

        fieldset {
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
        }

        .btn-primary { background-color: #F2F3ED }

        .btn-default { background-color: #F2F3ED }
    </style>
</head>


<body style="background-color: white">

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
            <li class="active"> <a href="ViewCitiesUI.aspx"> View Cities </a> </li>
            <li> <a href="ViewCountriesUI.aspx"> View Countries </a> </li>
        </ul>
    </div>
  </nav>
</div>


<div class="container" style="width: auto; margin: 0 105px 20px 105px; padding: 20px 0 0 0; background-color: #F2F3ED">
    <form class="form-horizontal" id="countryForm" name="countryForm" runat="server"> 
        <fieldset style="padding: 4px 4px 10px 6px" class="scheduler-border col-sm-offset-3 col-sm-13 col-md-10">
            <legend class="scheduler-border"><h5>Search Criteria</h5></legend>
            <div class="form-group">
                <div class="form-inline">
                    <asp:RadioButton runat="server" name="searchCriteria" GroupName="searchCriteria" style="margin-left: 53px; margin-right:33px; margin-bottom: 5px" ID="cityRadioButton" class="radio" Text="City Name" checked="True"/>
                    <input type="text" runat="server" name="searchCityTextBox" ID="searchCityTextBox" style="margin-right: 40px; margin-bottom: 5px" class="form-control input-sm" placeholder="City Name"/>
                    <br/>               
                    <asp:RadioButton runat="server" name="searchCriteria" style="float: left;margin-left: 53px; margin-right: 53px" GroupName="searchCriteria" ID="countryRadioButton" class="radio" Text="Country"/>
                    <asp:DropDownList runat="server" name="countryDropDownList" Width="175px" ID="countryDropDownList" Enabled="False" style="margin-right: 50px" CssClass="form-control input-sm"/>
                    <asp:Button runat="server" ID="citySearchButton" Text="Search" style=" margin-right: 60px; float: right" CssClass="btn btn-default" OnClick="citySearchButton_Click"/>
                </div>
            </div>
        </fieldset>

        <%--<asp:Label runat="server" ID="messageLabel"></asp:Label>--%>

        <div class="form-group">
            <div class="col-sm-offset-1 col-sm-11 col-md-10">
                <table id="cityDetails"  class="table table-bordered pagination text-center compact">
                    <thead style="background-color: lightgray">
                    <tr>
                        <th>SL#</th>
                        <th>City Name</th>
                        <th>About</th>
                        <th>No. of dwellers</th>
                        <th>Loction</th>
                        <th>Weather</th>
                        <th>Country</th>
                        <th>About Country</th>
                    </tr>
                    </thead>
                    <tbody>
                        <asp:PlaceHolder ID="dbPlaceHolder" runat="server"></asp:PlaceHolder>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</div>

<script src="../Scripts/jquery-1.9.1.js"></script>
<script src="../Scripts/DataTables/jquery.dataTables.js"></script>
<script src="../Scripts/DataTables/dataTables.bootstrap.min.js"></script>
<script src="../Scripts/jquery.validate.js"></script>

<script>    
    (function () {
        var form = document.forms['countryForm'];
        form.searchCriteria[0].onfocus = function () {
            form.searchCityTextBox.disabled = false;
            form.countryDropDownList.disabled = true;
        }
        form.searchCriteria[1].onfocus = function () {
            form.searchCityTextBox.disabled = true;
            form.countryDropDownList.disabled = false;
        }
    })();

    $(document).ready(function () {        
        <%-- Managing DataTable --%>
        var t = $('#cityDetails').DataTable({
            "iDisplayLength": 3,
            "responsive": true,
            "searching": false,
            "pagingType": "simple_numbers",
            "bLengthChange": false,
            "order": [1, 'asc'],
            "bInfo": false,
            "autoWidth":false,
            "b.LengthChange": false,
            "columnDefs": [
                { className: "dt-head-center", "targets": [0, 1, 2, 3, 4, 5, 6, 7] }
            ],
            "aoColumns": [
                { "bSortable": false, sWidth: '70px' },
                { sWidth: '150px' },
                { sWidth: '260px' },
                { sWidth: '150px' },
                { sWidth: '155px' },
                { sWidth: '150px' },
                { sWidth: '150px' },
                { sWidth: '260px' }
            ]
        });

        t.on('order.dt', function() {
            t.column(0, { search: 'applied', order: 'applied' }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
    });
</script>
</body>
</html>