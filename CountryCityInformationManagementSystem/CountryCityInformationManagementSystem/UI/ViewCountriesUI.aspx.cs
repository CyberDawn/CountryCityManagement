using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CountryCityInformationManagementSystem.BLL;

namespace CountryCityInformationManagementSystem.UI
{
    public partial class ViewCountries : System.Web.UI.Page
    {
        CountryManager countryManager = new CountryManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dbPlaceHolder.Controls.Add(new Literal { Text = countryManager.BindDataForViewCountriesPageTable().ToString() });
            }
        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            string countryName = countryNameTextBox.Value;
            dbPlaceHolder.Controls.Add(new Literal { Text = countryManager.SearchForCountriesByName(countryName).ToString() });
        }
    }
}