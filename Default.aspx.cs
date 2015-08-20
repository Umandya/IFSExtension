using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Net;

public partial class _Default : System.Web.UI.Page
{
    MySqlConnection myDataConnection = Connection.CreateConnection();
    MySqlDataReader reader = null;

    int result = 0;
    int result_ = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        CheckParameter();
    }

    private void CheckParameter()
    {
        string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
        CheckAdmin(nameID);
        checkData(nameID);


        //admin
        if (result == 1)
        {
            divThree.Visible = false;
        }

        //not admin
        else
        {
            nav.Visible = false;
            checkData(nameID);

            //reg_emp
            if (result_ == 1)
            {
                add.Visible = false;
            }
            //non reg_emp
            else
            {
                edit.Visible = false;
            }
        }

        
    }

    private void CheckAdmin(string AdminID) 
    {
        try
        {
            
            myDataConnection.Open();

            string SelectAdmin = "SELECT Admin_ID FROM Admin where Admin_ID='"+AdminID+"'";
            MySqlCommand MyCommandAdmin = new MySqlCommand(SelectAdmin, myDataConnection);
            reader = MyCommandAdmin.ExecuteReader();

            if(reader.HasRows){

                result = 1;
            
            }
           
            
        }
        catch (MySqlException ex)
        {
            Console.WriteLine("Error: {0}", ex.ToString());

        }
        finally
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
             

        }
    }

    private void checkData(String EmplyeeID)
    {
       // MySqlDataReader reader_ = null;

        try
        {
            //conn1 = new MySqlConnection(connectionString);
            myDataConnection.Open();

            string SelectEmployee = "SELECT EmployeeID FROM Employee where EmployeeID='" + EmplyeeID + "'";
            MySqlCommand MyCommandSelectEmployee = new MySqlCommand(SelectEmployee, myDataConnection);
            reader = MyCommandSelectEmployee.ExecuteReader();

            if(reader.HasRows){

                result_ = 1;
            }
             
        }
        catch (MySqlException ex)
        {
          

        }
        finally
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }

        }
         

    }


    public static List<String[]> SearchExt(String name)
    {

        string connectionString = @"server=localhost; userid=root; password=root; database=EmployeeData";
        MySqlConnection connection = new MySqlConnection(connectionString);
        connection.Open();

        string SelectEmployee = "SELECT EmployeeName,EmployeeExtension, Employee_Image from employee";
        MySqlCommand MyCommandEmployee = new MySqlCommand(SelectEmployee, connection);
        //cmd.ExecuteNonQuery();

        MySqlDataAdapter DataValue = new MySqlDataAdapter(MyCommandEmployee);
        System.Data.DataTable Data = new System.Data.DataTable();
        DataValue.Fill(Data);

        // return dt;
        List<String[]> NameReturn = new List<string[]>();
        //List<String> result = new List<string>();
        // List<EmployeeData> eDList = ReadXLS();

        bool boolResult = true;
        foreach (DataRow nameData in Data.Rows)
        {

            String[] SplitNameArray = nameData[0].ToString().Split(' ');
            for (int i = 0; i < SplitNameArray.Length; i++)
            {
                boolResult = (SplitNameArray[i].ToLower()).StartsWith(name.ToLower().Trim());

                if (boolResult == false) {
                    
                    boolResult = (nameData[0].ToString().ToLower()).StartsWith(name.ToLower().Trim());
                     
                    
                }
                //(!drNameArray[j + k].ToLower().StartsWith(inNameArray[k].ToLower()))
                if (boolResult)
                {
                    NameReturn.Add(new String[] { nameData[0].ToString(), nameData[1].ToString(), nameData[2].ToString() });
                    break;
                }

            }
        }

        //myDataConnection.Close();
        return NameReturn;
    }



    [System.Web.Services.WebMethod]
    public static String[][] GetExtention(string name)
    {
        List<String[]> nameSearch = SearchExt(name);
        String[][] NameArray = nameSearch.ToArray();
        return NameArray;
    }

    public static List<String[]> SameExt(String name)
    {

        string connectionString = @"server=localhost; userid=root; password=root; database=EmployeeData";
        MySqlConnection connection = new MySqlConnection(connectionString);
        connection.Open();

        string SelectEmployee = "SELECT EmployeeName,EmployeeExtension from employee";
        MySqlCommand MyCommandEmployee = new MySqlCommand(SelectEmployee, connection);
        //cmd.ExecuteNonQuery();

        MySqlDataAdapter DataValue = new MySqlDataAdapter(MyCommandEmployee);
        System.Data.DataTable Data = new System.Data.DataTable();
        DataValue.Fill(Data);

        // return dt;
        List<String[]> NameReturn = new List<string[]>();
        
        foreach (DataRow nameData in Data.Rows)
        {
            NameReturn.Add(new String[] { nameData[0].ToString(), nameData[1].ToString() });
               
        }

        //myDataConnection.Close();
        return NameReturn;
    }

    [System.Web.Services.WebMethod]
    public static String[][] GetSameExtention(string name)
    {
        List<String[]> nameSearch = SameExt(name);
        String[][] NameArray = nameSearch.ToArray();
        return NameArray;
    }
    

}