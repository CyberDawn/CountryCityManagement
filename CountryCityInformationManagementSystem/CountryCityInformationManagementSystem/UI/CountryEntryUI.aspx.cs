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
    public partial class CountryEntryUI : System.Web.UI.Page
    {
        CountryManager countryManager = new CountryManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dbPlaceHolder.Controls.Add(new Literal { Text = countryManager.BindDataForCountryEntryPageTable().ToString() });
            }
            
        }

        protected void saveNameButton_Click(object sender, EventArgs e)
        {
            Country aCountry = new Country();
            aCountry.Name = nameTextBox.Value;
            aCountry.About = aboutTextArea.Value;

            messageLabel.Text = countryManager.Save(aCountry);
            dbPlaceHolder.Controls.Add(new Literal { Text = countryManager.BindDataForCountryEntryPageTable().ToString() });

            ClearText();
        }

        private void ClearText()
        {
            nameTextBox.Value = "";
            aboutTextArea.Value = "";
        }
    }
}