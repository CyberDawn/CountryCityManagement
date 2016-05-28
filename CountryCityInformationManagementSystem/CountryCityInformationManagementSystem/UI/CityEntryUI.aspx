<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CityEntryUI.aspx.cs" Inherits="CountryCityInformationManagementSystem.UI.CityEntryUI" ValidateRequest="false" %>
<%@ Import Namespace="System.ComponentModel" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>City Entry</title>
    <script src="../Models/Country.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet"/>
    <%--<link href="../Content/DataTables/css/jquery.dataTables.css" rel="stylesheet"/>--%>
    <link href="../Content/DataTables/css/dataTables.bootstrap4.css" rel="stylesheet" />


    <style>
        label.error, .messageLabel {
            color: red;
            font-style: normal;
            font-family: Segoe ui light;
            font-size: 12px;
            margin: 0 0 0 5px;
            /*padding: 0 0 0 0;*/
        }

        .datatable tr.row:hover td {
            color: #000;
            background-color: #FFFACD;
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
            <li> <a href="CountryEntryUI.aspx">Country Entry </a> </li>
            <li class="active"> <a href="CityEntryUI.aspx">City Entry </a> </li>
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
            <div class="col-sm-10 col-md-3">
                <input type="text" runat="server" class="form-control input-sm" id="nameTextBox" name="nameTextBox" placeholder="City Name"/>
            </div>
        </div>
        <div class="form-group">
            <label for="aboutTextArea" class="col-sm-2 control-label">About</label>
            <div class="col-sm-10 col-md-9">
                <textarea class="required form-control" runat="server" id="aboutTextArea" name="aboutTextArea"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label for="noOfDwellersTextBox" class="col-sm-2 control-label">No. of dwellers</label>
            <div class="col-sm-10 col-md-3">
                <input type="text" runat="server" class="form-control input-sm" id="noOfDwellersTextBox" name="noOfDwellersTextBox" placeholder="No Of Dwellers"/>
            </div>
        </div>
        <div class="form-group">
            <label for="locationTextBox" class="col-sm-2 control-label">Location</label>
            <div class="col-sm-10 col-md-3">
                <input type="text" runat="server" class="form-control input-sm" id="locationTextBox" name="locationTextBox" placeholder="Location"/>
            </div>
        </div>
        <div class="form-group">
            <label for="weatherTextBox" class="col-sm-2 control-label">Weather</label>
            <div class="col-sm-10 col-md-3">
                <input type="text" runat="server" class="form-control input-sm" id="weatherTextBox" name="weatherTextBox" placeholder="Weather"/>
            </div>
        </div>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">Country</label>
            <div class="col-sm-10 col-md-9 form-inline">
                <asp:DropDownList ID="countryDropDownList" Width="232px" CssClass="form-control col-md-3 input-sm" runat="server"></asp:DropDownList>
                <a href="Index.aspx" class="btn btn-default pull-right rov" style="margin-left: 5px">Cancel</a>      
                <asp:Button ID="Button1" CssClass="btn btn-default pull-right rov2" runat="server" Text="Save" OnClick="saveButton_Click"/>                                                           
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-1 col-sm-11 col-md-10">
                <table id="cityDetails" class="table table-bordered pagination text-center compact">
                    <thead style="background-color: lightgray">
                    <tr>
                        <th>SL#</th>
                        <th>Name</th>
                        <th>No. of dwellers</th>
                        <th>Country</th>
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


<script>
    document.getElementById("nameTextBox").onkeypress = function(e) {
            var e = window.event || e;
            var keyunicode = e.charCode || e.keyCode;
            return (keyunicode >= 65 && keyunicode <= 90 || keyunicode >= 96 && keyunicode <= 122 || keyunicode == 8 || keyunicode == 32 || keyunicode == 39) ? true : false;
        },
        document.getElementById("noOfDwellersTextBox").onkeypress = function(e) {
            var e = window.event || e;
            var keyunicode = e.charCode || e.keyCode;
            return (keyunicode >= 48 && keyunicode <= 57 || keyunicode == 8) ? true : false;
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
                    maxlength: 40
                },

                aboutTextArea: {
                    required: true, function() {
                        CKEDITOR.instances.aboutTextArea.updateElement();
                    }
                },
                noOfDwellersTextBox: {
                    required: true,
                    maxlength: 15
                },
                locationTextBox: {
                    required :true,
                    maxlength : 40
                },
                weatherTextBox: {
                    required: true,
                    maxlength: 40
                }

            },
            messages: {
                nameTextBox: {
                    required: "Please enter your city name",
                    maxlength: "Check the name again, City name was not supposed to be this long"
                },
                aboutTextArea: "Please write something about your city",
                noOfDwellersTextBox: {
                    required: "Please enter the number of dwellers in your city",
                    maxlength: "Check the number of dwellers again, there seems to be an error"
                },
                locationTextBox: {
                    required: "Please enter the location of your city",
                    maxlength: "Check the location again, there seems to be an error"
                }, 
                weatherTextBox: {
                    required: "Please enter the weather type of your city",
                    maxlength: "Check the weather again, there seems to be an error"
                }
            }
        });


        var t = $('#cityDetails').DataTable({
            "iDisplayLength": 3,
            "responsive": true,
            "searching": false,
            "autoWidth": false,
            "pagingType": "simple_numbers",
            "bLengthChange": false,
            "order": [1, 'asc'],
            "bInfo": false,
            "b.LengthChange": false,
            "columnDefs": [
                { className: "dt-head-center", "targets": [0, 1, 2, 3] }
            ],
            "aoColumns": [
                { "bSortable": false, sWidth: '70px' },
                { sWidth: '400px' },
                { sWidth: '350px' },
                { sWidth: '400px' }
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