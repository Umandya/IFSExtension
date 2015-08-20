using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using MySql.Data.MySqlClient;

/// <summary>
/// Summary description for MySQLConnection
/// </summary>
public class Connection
{

    static MySqlConnection MySQLDataConnection;

	public Connection()
	{

	}

    public static MySqlConnection CreateConnection()
    {
        string EmployeeDataConnection = ConfigurationManager.ConnectionStrings["EmployeeDataConnection"].ConnectionString;

        if (MySQLDataConnection == null)
        {

            MySQLDataConnection = new MySqlConnection(EmployeeDataConnection);

        }

        return MySQLDataConnection;
    }

    
}