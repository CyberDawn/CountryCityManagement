using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CountryCityInformationManagementSystem.BLL;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.UI
{
    public partial class ViewCities : System.Web.UI.Page
    {
        CountryManager countryManager = new CountryManager();
        CityManager cityManager = new CityManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dbPlaceHolder.Controls.Add(new Literal { Text = cityManager.BindDataforViewCitiesPageTable().ToString() });
                LoadCountryDropDown();
            }
            if (countryRadioButton.Checked)
            {
                countryDropDownList.Enabled = true;
                searchCityTextBox.Disabled = true;
            }else if (cityRadioButton.Checked)
            {
                searchCityTextBox.Disabled = false;
                countryDropDownList.Enabled = false;
            }
        }

        private void LoadCountryDropDown()
        {
            List<Country> departments = countryManager.GetAllCountryNames();
            countryDropDownList.DataSource = departments;
            countryDropDownList.DataTextField = "Name";
            countryDropDownList.DataValueField = "Id";
            countryDropDownList.DataBind();
        }
        protected void citySearchButton_Click(object sender, EventArgs e)
        {
            if (cityRadioButton.Checked)
            {
                string cityName = searchCityTextBox.Value;
                    dbPlaceHolder.Controls.Add(new Literal { Text = cityManager.SearchForCitiesByCityName(cityName).ToString() }); 

            }
            else if (countryRadioButton.Checked)
            {
                string countryId = countryDropDownList.SelectedItem.Text;
                dbPlaceHolder.Controls.Add(new Literal { Text = cityManager.SearchForCitiesByCountryName(countryId).ToString() }); 
            } 
        }
    }
}