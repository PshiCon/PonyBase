using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace DataBase
{
    internal class SqlQuest
    {
        static public string SqlCategory(int i)
        {
            Helper.Reader.Close();

            string a="";
            string sqlCategory = $"SELECT * FROM Category where CategoryID='{i}'";
            SqlCommand sqlCommand = new SqlCommand(sqlCategory, Helper.connection);

            Helper.Reader = sqlCommand.ExecuteReader();

            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    a = (string)Helper.Reader["CategoryName"];

                }            
            }
           
            return a;
        }
        static public string SqlProvider(int i)
        {
            Helper.Reader.Close();

            string a = "";
            string sqlProvider = "SELECT * FROM Provider";
            SqlCommand sqlCommand = new SqlCommand(sqlProvider, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    a=((string)Helper.Reader["ProviderName"]);

                }
            }
           
            return a;
        }
        static public string SqlManufacturer(int i)
        {
            Helper.Reader.Close();

            string a = "";
            string sqlManifucter = "SELECT * FROM Manufacturer";
            SqlCommand sqlCommand = new SqlCommand(sqlManifucter, Helper.connection);
            Helper.Reader = sqlCommand.ExecuteReader();
            if (Helper.Reader.HasRows)
            {
                while (Helper.Reader.Read())
                {
                    a=((string)Helper.Reader["ManufacturerName"]);

                }
            }

            Helper.Reader.Close();

            return a;
        }
    }
}
