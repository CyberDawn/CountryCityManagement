<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCountriesUI.aspx.cs" Inherits="CountryCityInformationManagementSystem.UI.ViewCountries" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Country Entry</title>

    <link href="../Content/bootstrap.css" rel="stylesheet"/>
    <%--<link href="../Content/DataTables/css/jquery.dataTables.css" rel="stylesheet"/>--%>
    <link href="../Content/DataTables/css/dataTables.bootstrap4.css" rel="stylesheet" />

    <style>
        label.error {
            color: red;
            font-style: italic
        }

        fieldset {
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
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

        .auto-style1 { width: 192px; }
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
                <li> <a href="CityEntryUI.aspx">City Entry </a> </li>
                <li> <a href="ViewCitiesUI.aspx"> View Cities </a> </li>
                <li class="active"> <a href="ViewCountriesUI.aspx"> View Countries </a> </li>
            </ul>
        </div>
      </nav>
    </div>
    <div class="container" style="width: auto; margin: 0 105px 20px 105px; padding: 20px 0 0 0; background-color: #F2F3ED">
        <form class="form-horizontal" id="countryForm" runat="server">
            <fieldset style="padding: 4px 4px 10px 6px" class="scheduler-border col-sm-offset-3 col-sm-13 col-md-12">
                <legend class="scheduler-border"><h5>Search Criteria</h5></legend>
                <div class="form-group">
                    <div class="form-inline">
                        <label for="countryNameTextBox" style="margin-left: 30px; margin-right: 40px" class="col-sm-1 control-label">Name</label>
                        <input type="text" runat="server" style="margin-left: 30px; margin-right: 40px" class="form-control col-sm-7 col-md-10 input-sm" id="countryNameTextBox" name="nameTextBox" placeholder="Country Name"/>
                        <asp:Button runat="server" ID="searchButton" style="margin-left: 30px; margin-right: 40px" CssClass="btn btn-default" Text="Search" OnClick="searchButton_Click"></asp:Button>
                    </div>
                
                </div>
            </fieldset>
 
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-11 col-md-10">
                    <table id="countryDetails" class="table table-bordered pagination text-center compact">
                        <thead style="background-color: lightgray">
                        <tr>
                            <th>SL#</th>
                            <th>Name</th>
                            <th>About</th>
                            <th>No. of cities</th>
                            <th>No. of dwellers</th>
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

<%-- Managing DataTables --%>
<script>
    $(document).ready(function() {

        $("#countryForm").validate({
            ignore: [],
            rules: {
                countryNameTextBox: {
                    maxlength: 40
                }

            },
            messages: {
                nameTextBox: "Please enter country's name",

            }
        });

        var t = $('#countryDetails').DataTable({
            "iDisplayLength": 3,
            "searching": false,
            "pagingType": "simple_numbers",
            "bLengthChange": false,
            "order": [1, 'asc'],
            "bInfo": false,
            "b.LengthChange": false,
            "columnDefs": [
                { className: "dt-head-center", "targets": [0, 1, 2, 3, 4] }
            ],
            "aoColumns": [
                { "bSortable": false, sWidth: '70px' },
                { sWidth: '165px' },
                { sWidth: '500px' },
                { sWidth: '145px' },
                { sWidth: '165px' }
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