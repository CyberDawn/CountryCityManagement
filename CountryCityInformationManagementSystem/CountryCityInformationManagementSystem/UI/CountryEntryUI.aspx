<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CountryEntryUI.aspx.cs" Inherits="CountryCityInformationManagementSystem.UI.CountryEntryUI" ValidateRequest="false" %>
<%@ Import Namespace="System.ComponentModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Country Entry</title>

    <link href="../Content/bootstrap.css" rel="stylesheet"/>
    <%--<link href="../Content/DataTables/css/jquery.dataTables.css" rel="stylesheet"/>--%>
    <link href="../Content/DataTables/css/dataTables.bootstrap4.css" rel="stylesheet" />
    <link href="../Content/Style.css" rel="stylesheet"/>


    <style>
        label.error,.messageLabel {
            color: red;
            font-style: normal;
            font-family: Segoe ui light;
            font-size: 12px;
            margin: 0 0 0 5px;
            /*padding: 0 0 0 0;*/
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
            <li class="active"> <a href="CountryEntryUI.aspx"> Country Entry </a> </li>
            <li> <a href="CityEntryUI.aspx">City Entry </a> </li>
            <li> <a href="ViewCitiesUI.aspx"> View Cities </a> </li>
            <li> <a href="ViewCountriesUI.aspx"> View Countries </a> </li>
        </ul>
    </div>
  </nav>
</div>

<div class="container" style="width: auto; margin: 0 105px 20px 105px; padding: 20px 0 0 0; background-color: #F2F3ED">
    <asp:Label runat="server" ID="messageLabel" CssClass="messageLabel"></asp:Label>    
    <form class="form-horizontal" id="countryForm" runat="server">
        <div class="form-group">
            <label for="nameTextBox" class="col-sm-2 control-label">Name</label>
            <div class="col-sm-11 col-md-3">
                <input type="text" runat="server" class="form-control input-sm" id="nameTextBox" name="nameTextBox" placeholder="Country Name"/>
            </div>
        </div>
        <div class="form-group">
            <label for="aboutTextArea" class="col-sm-2 control-label">About</label>
            <div class="col-sm-11 col-md-9">
                <textarea class="required form-control" runat="server" id="aboutTextArea" name="aboutTextArea"></textarea>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-9 col-md-9" style="margin-bottom: 10px">
                <asp:Button runat="server" ID="saveNameButton" CssClass="btn btn-default rov" Text="Save" OnClick="saveNameButton_Click"></asp:Button>
                <a href="Index.aspx" class="btn btn-default rov2">Cancel</a>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-1 col-sm-11 col-md-10">
                <table id="countryDetails"  class="pagination table table-bordered compact">
                    <thead style="background-color: lightgray">
                    <tr>
                        <th>SL#</th>
                        <th>Name</th>
                        <th>About</th>
                    </tr>
                    </thead>
                    <tbody style="background-color: white">
                    <asp:PlaceHolder ID="dbPlaceHolder" runat="server"></asp:PlaceHolder>
                    </tbody>
                </table>
            </div>
        </div>

    </form>
</div>

<script>
    document.getElementById("nameTextBox").onkeypress = function(e) {
        var e = window.event || e;
        var keyunicode = e.charCode || e.keyCode;
        return (keyunicode >= 65 && keyunicode <= 90 || keyunicode >= 96 && keyunicode <= 122 || keyunicode == 8 || keyunicode == 32 || keyunicode == 39) ? true : false;
    }

</script>


<script src="../ckeditor/ckeditor.js"></script>
<script>
    CKEDITOR.replace('aboutTextArea');
    CKEDITOR.config.width = "auto";
    CKEDITOR.config.height = "80px";
    CKEDITOR.config.resize_enabled = false;
    CKEDITOR.config.removePlugins = 'elementspath';
</script>


<script src="../Scripts/jquery-1.9.1.js"></script>
<script src="../Scripts/DataTables/jquery.dataTables.js"></script>
<script src="../Scripts/DataTables/dataTables.bootstrap.min.js"></script>
<script src="../Scripts/jquery.validate.js"></script>

<script>
    $(document).ready(function() {
        $("#countryForm").validate({
            ignore: [],
            rules: {
                nameTextBox: {
                    required: true,
                    maxlength: 40,
                    minlength: 4
                },
                aboutTextArea: {
                    required: true, function() {
                        CKEDITOR.instances.aboutTextArea.updateElement();
                    }
                }
            },
            messages: {
                nameTextBox: {
                    required: "Please enter your country name",
                    maxlength: "Check the name again, Country name was not supposed to be this long",
                    minlength: "Country name should contain at least 4 characters"
                },
                aboutTextArea: "Please write something about the country"                
            }
        });

        var t = $('#countryDetails').DataTable({
            "iDisplayLength": 3,
            "responsive": true,
            "searching": false,
            "table-layout": false,
            "autoWidth":false,
            "pagingType": "simple_numbers",
            "bLengthChange": false,
            "order": [1, 'asc'],
            "bInfo": false,
            "b.LengthChange": false,
            //"columnDefs": [
            //    { className: "dt-head-center", "targets": [0, 1, 2] }
            //],
            "aoColumns": [
                { "bSortable": false, sWidth: '70px' },
                { sWidth: '275px' },
                { sWidth: '600px' }
            ]
        });

        t.on('order.dt search.dt', function() {
            t.column(0, { search: 'applied', order: 'applied' }).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
    });
</script>
</body>
</html>