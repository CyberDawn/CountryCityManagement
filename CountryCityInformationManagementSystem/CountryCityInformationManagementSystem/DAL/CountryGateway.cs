using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.DAL
{
    public class CountryGateway
    {
        SqlConnection connection = null;
        private StringBuilder htmlTable = new StringBuilder();

        private string connectionString =
            WebConfigurationManager.ConnectionStrings["CountryCityManagementConnString"].ConnectionString;        

        public CountryGateway()
        {
            connection = new SqlConnection(connectionString);
        }

        public int Save(Country aCountry)
        {
            string query = "INSERT INTO Countries VALUES(@name, @about)";

            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Clear();
            command.Parameters.Add("name", SqlDbType.VarChar);
            command.Parameters["name"].Value = aCountry.Name;
            command.Parameters.Add("about", SqlDbType.NVarChar);
            command.Parameters["about"].Value = aCountry.About;

            connection.Open();
            int rowsAffected = command.ExecuteNonQuery();
            connection.Close();
            return rowsAffected;
        }

        public List<Country> GetAllCountryNames()
        {
            List<Country> countries = new List<Country>();
            string query = "SELECT * FROM Countries";
            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            Country aCountry = null;

            while (reader.Read())
            {
                int id = Convert.ToInt32(reader["Id"].ToString());
                string name = reader["Name"].ToString();
                aCountry = new Country(id, name);
                countries.Add(aCountry);
            }
            reader.Close();
            connection.Close();
            return countries;
        }

        public bool IsCountryNameExists(string name)
        {
            string query = "SELECT * FROM Countries WHERE Name = @name";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Clear();
            command.Parameters.Add("name", SqlDbType.VarChar);
            command.Parameters["name"].Value = name;
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            bool isExists = reader.HasRows;
            connection.Close();
            return isExists;
        }

        public StringBuilder BindDataForCountryEntryPageTable()
        {
            string query = "SELECT * From Countries";
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["About"] + "</td>");
                    htmlTable.Append("</tr>");
                }
            }            
            reader.Close();
            connection.Close();
            return htmlTable;
        }

        // View Countries

        public StringBuilder BindDataForViewCountriesPageTable()
        {
            string query = "SELECT * From CountriesView";
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["About"] + "</td>");
                    htmlTable.Append("<td>" + reader["NoOfCities"] + "</td>");
                    if (reader["NoOfDwellers"].ToString().Equals(""))
                    {
                        htmlTable.Append("<td>" + "0" + "</td>");
                    }
                    else
                    {
                        htmlTable.Append("<td>" + reader["NoOfDwellers"] + "</td>");
                    }                    
                    htmlTable.Append("</tr>");
                }
            }
            reader.Close();
            connection.Close();
            return htmlTable;
        }

        public StringBuilder SearchForCountriesByName(string countryName)
        {
            string query = "SELECT * From CountriesView WHERE Name LIKE '%'+@countryName+'%'";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Clear();
            command.Parameters.Add("countryName", SqlDbType.VarChar);
            command.Parameters["countryName"].Value = countryName;

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    htmlTable.Append("<tr>");
                    htmlTable.Append("<td>" + reader["Id"] + "</td>");
                    htmlTable.Append("<td>" + reader["Name"] + "</td>");
                    htmlTable.Append("<td>" + reader["About"] + "</td>");
                    htmlTable.Append("<td>" + reader["NoOfCities"] + "</td>");
                    if (reader["NoOfDwellers"].ToString().Equals(""))
                    {
                        htmlTable.Append("<td>" + "0" + "</td>");
                    }
                    else
                    {
                        htmlTable.Append("<td>" + reader["NoOfDwellers"] + "</td>");
                    }
                    htmlTable.Append("</tr>");
                }
            }
            reader.Close();
            connection.Close();
            return htmlTable;
        }
    }
}