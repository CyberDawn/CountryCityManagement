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
    public partial class CityEntryUI : System.Web.UI.Page
    {
        private CityManager manager = new CityManager();
        private CountryManager countryManager = new CountryManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dbPlaceHolder.Controls.Add(new Literal {Text = manager.BindDataForCityEntryPageTable().ToString()});
                LoadCountryDropDown();
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


        protected void saveButton_Click(object sender, EventArgs e)
        {
            City aCity = new City();
            aCity.Name = nameTextBox.Value;
            aCity.About = aboutTextArea.Value;
            aCity.NoOfDwellers = Convert.ToInt64(noOfDwellersTextBox.Value);
            aCity.Location = locationTextBox.Value;
            aCity.Weather = weatherTextBox.Value;
            aCity.CountryId = Convert.ToInt32(countryDropDownList.SelectedValue);

            messageLabel.Text = manager.Save(aCity);

            dbPlaceHolder.Controls.Add(new Literal {Text = manager.BindDataForCityEntryPageTable().ToString()});

            ClearTextBoxes();
        }


        private void ClearTextBoxes()
        {
            nameTextBox.Value = "";
            aboutTextArea.Value = "";
            noOfDwellersTextBox.Value = "";
            locationTextBox.Value = "";
            weatherTextBox.Value = "";
        }
    }
}