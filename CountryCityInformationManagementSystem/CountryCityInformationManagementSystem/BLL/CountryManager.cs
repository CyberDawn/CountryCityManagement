using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Web;
using CountryCityInformationManagementSystem.DAL;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.BLL
{
    public class CountryManager
    {
        CountryGateway countryGateway = new CountryGateway();
        public string Save(Country aCountry)
        {
            bool isExists = countryGateway.IsCountryNameExists(aCountry.Name);
            string message = "";
            if (isExists)
            {
                message = "Country already exists!";
            }
            else
            {
                int rowsAffected = countryGateway.Save(aCountry);
                bool isSaved = rowsAffected > 0;
                //message = isSaved ? "Saved Successfully!" : "Insertion Failed!";
            }
            return message;
        }

        public List<Country> GetAllCountryNames()
        {
            return countryGateway.GetAllCountryNames();
        }

        public StringBuilder BindDataForCountryEntryPageTable()
        {
            return countryGateway.BindDataForCountryEntryPageTable();
        }

        // ViewCountries Page Methods
        public StringBuilder BindDataForViewCountriesPageTable()
        {
            return countryGateway.BindDataForViewCountriesPageTable();
        }

        public StringBuilder SearchForCountriesByName(string countryName)
        {
            return countryGateway.SearchForCountriesByName(countryName);
        }
        //End of ViewCountries Page Methods
    }
}