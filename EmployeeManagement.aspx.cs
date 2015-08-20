using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Net;

public partial class EmployeeManagement : System.Web.UI.Page
{
    MySqlConnection myDataConnection = Connection.CreateConnection();
    MySqlDataReader reader = null;
    

   

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                dropDownFoor();
                BindDropDownList2(DropDownFloor.SelectedItem.Text);
            }
        }
        catch(Exception ex){}
        
        
        CheckAdmin();
        CheckParameters();
    }


    private void CheckParameters()
    {
        try
        {
            String parameter = Request.Params["p"].ToString();
            if (parameter == "add")
            {
                VisibleAdd();
            }
            if (parameter == "edit")
            {
                VisibleEdit();
            }
            if (parameter == "delete")
            {
                VisibleDelete();
            }
        }
        catch (NullReferenceException nx)
        {
            Response.Redirect("Default.aspx");
        }
    }


    private void CheckAdmin()
    {
        string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
        try
        {

            myDataConnection.Open();

            string SelectAdmin = "SELECT Admin_ID FROM Admin where Admin_ID='"+nameID+"'";
            MySqlCommand MyCommandAdmin = new MySqlCommand(SelectAdmin, myDataConnection);
            reader = MyCommandAdmin.ExecuteReader();

            if(!reader.HasRows){
                Response.Redirect("Default.aspx");
            
            }
            myDataConnection.Close();
           /* while (reader.Read())
            {
                if (reader.GetString(0).ToLower() == Environment.UserName)
                {

                   

                }
            }*/

        }
        catch (MySqlException ex)
        {
            Console.WriteLine("Error: {0}", ex.ToString());
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }

        }
        
    }


    private int Extention_Exist(String extension)
    {

        MySqlDataReader reader = null;
        int Extention = 0;
        try
        {
            myDataConnection.Open();
            string SelectFloor = "SELECT Extension,Floor_Detail FROM Floor_Detail where Extension='" + extension + "'";
            MySqlCommand command = new MySqlCommand(SelectFloor, myDataConnection);
            reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                Extention = 1;
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
        return Extention;

    }


    protected void Register_Emplyee(object sender, EventArgs e)
    {
        int empResult = 0;
        int floorResult = 0;
        int Extention = Extention_Exist(ExtentionDropDown.SelectedItem.Text);
        empResult = checkData(TextBoxID.Text);
        floorResult = checkFloor(ExtentionDropDown.SelectedItem.Text, DropDownFloor.SelectedItem.Text);
        
        string ImgPath = "Images/IFS.png"; 

        try
        {
            string InsertEmployee = "insert into Employee (EmployeeID, EmployeeName, EmployeeExtension, Employee_Image) values('" + this.TextBoxID.Text.ToUpper() + "','" + this.TextBoxName.Text + "' ,'" + this.ExtentionDropDown.SelectedItem.Text + "','" + ImgPath + "');";
            string InsertFloor = "insert into Floor_Detail (Extension, Floor_Detail) values('" + this.ExtentionDropDown.SelectedItem.Text + "', '" + this.DropDownFloor.SelectedItem.Text + "');";


            if (empResult != 1)
            {
                if (floorResult == 1)
                {
                    MySqlCommand MyCommandEmployee = new MySqlCommand(InsertEmployee, myDataConnection);
                    myDataConnection.Open();
                    MyCommandEmployee.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Saved Sucessfully'); ", true);
                     
                    TextBoxName.Text = "";
                    TextBoxID.Text = "";
                    //ExtentionDropDown.SelectedIndex =0;
                    //DropDownFloor.SelectedIndex = 0;
                }
                else
                {
                    if (Extention != 1)
                    {
                        MySqlCommand MyCommandEmployee = new MySqlCommand(InsertEmployee, myDataConnection);
                        myDataConnection.Open();
                        MyCommandEmployee.ExecuteNonQuery();

                        myDataConnection.Close();
                        myDataConnection.Open();



                        MySqlCommand MyCommandFloor = new MySqlCommand(InsertFloor, myDataConnection);
                        MyCommandFloor.ExecuteNonQuery();




                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Saved Sucessfully'); ", true);

                        TextBoxName.Text = "";
                        TextBoxID.Text = "";
                        //TextBoxExtension.Text = "";

                        //DropDownFloor.SelectedIndex = 0;
                    }
                    else {
                        DropDownFloor.SelectedIndex = 0;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Floor Detail & Extention Mismatch! Try Again'); ", true);
                    }
                    
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Already Exists'); ", true);
                 
                TextBoxName.Text = "";
                TextBoxID.Text = "";
                //TextBoxExtension.Text = "";

                //DropDownFloor.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        {
             
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
        }
        myDataConnection.Close();
        
    }


    private int checkData(String emplyeeID)
    {
        MySqlDataReader reader = null;
        int resultData = 0;
        try
        {
            myDataConnection.Open();
            string SelectEmployee = "SELECT EmployeeID FROM Employee where EmployeeID='" + emplyeeID + "'";
            MySqlCommand command = new MySqlCommand(SelectEmployee, myDataConnection);
            reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                resultData = 1;
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
        return resultData;
    }

    private int checkFloor(String extension, string floor)
    {

        MySqlDataReader reader = null;
        int floorResult = 0;
        try
        {
            myDataConnection.Open();
            string SelectFloor = "SELECT Extension,Floor_Detail FROM Floor_Detail where Extension='" + extension + "' && Floor_Detail='" + floor + "' ";
            MySqlCommand command = new MySqlCommand(SelectFloor, myDataConnection);
            reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                floorResult = 1;
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
        return floorResult;

    }

    ////////////////
    

    //////////////////



    protected void Update(object sender, EventArgs e)
    {
        int resultFloor = checkFloor(TextBoxEditExtension.Text, DropDownEditFloor.SelectedItem.ToString());
        //int resultFloor_Ext = checkFloorUpdate(TextBoxEditExtension.Text, DropDownEditFloor.SelectedItem.ToString());
        int Extention = Extention_Exist(TextBoxEditExtension.Text);
        
        string UpdateEmployee = "";
        string InsertFloor = "";

        try
        {
            if (Edit_Radio.SelectedIndex == 0)
            {
                UpdateEmployee = "update Employee set EmployeeID='" + TextBoxEditID.Text.ToUpper() + "', EmployeeName='" + TextBoxEditName.Text + "', EmployeeExtension = '" + TextBoxEditExtension.Text + "' where EmployeeID='" + TextBoxSearchID.Text.ToUpper() + "';";
            }
            else if(Edit_Radio.SelectedIndex == 1)
            {
                UpdateEmployee = "update Employee set  EmployeeID='" + TextBoxEditID.Text.ToUpper() + "', EmployeeName='" + TextBoxEditName.Text + "',  EmployeeExtension = '" + TextBoxEditExtension.Text + "' where EmployeeName='" + TextBoxSearchID.Text + "';";
            }
            MySqlCommand MyCommandEmployee = new MySqlCommand(UpdateEmployee, myDataConnection);


           // if (resultFloor_Ext==1)
            //{
           // InsertFloor = "update Floor_Detail set Extension='" + TextBoxEditExtension.Text + "', Floor_Detail='" + DropDownEditFloor.SelectedItem.Text + "';";
           // }
            //else{
            InsertFloor = "insert into Floor_Detail (Extension, Floor_Detail) values('" + this.TextBoxEditExtension.Text + "', '" + this.DropDownEditFloor.SelectedItem.Text + "');";
            //}

            
            MySqlCommand MyCommandFloor = new MySqlCommand(InsertFloor, myDataConnection);
  
                    

                    if (resultFloor == 1)
                    {
                        myDataConnection.Open();
                        MyCommandEmployee.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Updated Sucessfully'); ", true);
                        //Response.Write("<script>alert('Data Updated Successfully')</script>");
                        TextBoxEditID.Text = "";
                        TextBoxEditName.Text = "";
                        TextBoxEditExtension.Text = "";
                        TextBoxSearchID.Text = "";
                        DropDownEditFloor.SelectedIndex = 0;
                        
                    }
                    else
                    {

                        if (Extention != 1)
                        {
                            myDataConnection.Open();
                            MyCommandEmployee.ExecuteNonQuery();
                            myDataConnection.Close();
                            myDataConnection.Open();

                            MyCommandFloor.ExecuteNonQuery();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Updated Sucessfully'); ", true);
                            TextBoxEditID.Text = "";
                            TextBoxEditName.Text = "";
                            TextBoxEditExtension.Text = "";
                            TextBoxSearchID.Text = "";
                            DropDownEditFloor.SelectedIndex = 0;
                        }

                        else {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Floor Detail & Extention Mismatch! Try Again'); ", true);
                            DropDownEditFloor.SelectedIndex = 0;
                        }

                    }

                     
              
           
          

        }
        catch (Exception ex)
        {
             
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
        }

        myDataConnection.Close();
        
    }



    protected void Delete(object sender, EventArgs e)
    {

        string DeleteEmployee = "";
        string DeleteAdmin = "";

        try
        {
            if (Delete_Radio.SelectedIndex == 0)
            {
                DeleteEmployee = "delete from Employee where EmployeeID='" + TextBoxDelete.Text + "';";
                DeleteAdmin = "delete from Admin where Admin_ID='" + TextBoxDelete.Text + "';";
            }
            else
            {
                DeleteEmployee = "delete from Employee where EmployeeName='" + TextBoxDelete.Text + "';";
                DeleteAdmin = "delete from Admin where Admin_Name='" + TextBoxDelete.Text + "';";
            }

            MySqlCommand MyCommandEmployee = new MySqlCommand(DeleteEmployee, myDataConnection);
            MySqlCommand MyCommandAdmin = new MySqlCommand(DeleteAdmin, myDataConnection);

            myDataConnection.Open();

            MyCommandEmployee.ExecuteNonQuery();
                myDataConnection.Close();

                myDataConnection.Open();
                MyCommandAdmin.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information is Deleted Successfully'); ", true);
                //Response.Write("<script>alert('Data is Deleted Successfully')</script>");
                TextBoxDelete.Text = "";

            myDataConnection.Close();
        }
        catch (Exception ex)
        {
             
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
        }
    }


    private void dropDownFoor() {
 
        if (myDataConnection != null)
        {
            myDataConnection.Close();
        }
        try
        {
            string para = Request.Params["p"].ToString();
            string SelectFloor = "SELECT DISTINCT Floor_Detail FROM Floor_Detail order by Floor_Detail ASC";
            MySqlCommand getFloor = new MySqlCommand(SelectFloor, myDataConnection);
            myDataConnection.Open();
            MySqlDataAdapter FloorAdpt = new MySqlDataAdapter(getFloor);
            DataSet ds = new DataSet();
            FloorAdpt.Fill(ds);
            myDataConnection.Close();


            if (para == "add")
            {
                DropDownFloor.DataSource = ds;
                DropDownFloor.DataTextField = "Floor_Detail";
                DropDownFloor.DataValueField = "Floor_Detail";
                DropDownFloor.DataBind();
            }
            if (para == "edit")
            {
                DropDownEditFloor.DataSource = ds;
                DropDownEditFloor.DataTextField = "Floor_Detail";
                DropDownEditFloor.DataValueField = "Floor_Detail";
                DropDownEditFloor.DataBind();

            }
        }
        catch(Exception){
        if (myDataConnection != null)
        {
            myDataConnection.Close();
        }
        
        }
        
    
    
    
    }






    

    private void VisibleAdd()
    {
        AdminRegister.Visible = true;
        EditPanel.Visible = false;
        DeletePanel.Visible = false;
    }

    private void VisibleEdit()
    {
        AdminRegister.Visible = false;
        EditPanel.Visible = true;
        DeletePanel.Visible = false;
    }

    private void VisibleDelete()
    {
        AdminRegister.Visible = false;
        EditPanel.Visible = false;
        DeletePanel.Visible = true;
    }










    public static List<String[]> SearcEmployee(String name, int id)
    {
        string connectionString = @"server=localhost; userid=root; password=root; database=EmployeeData";
        MySqlConnection connection = new MySqlConnection(connectionString);
        MySqlCommand MyCommand;
        string SelectEmployee = "";
        
        connection.Open();

        if (id == 1)
        {
            SelectEmployee = "SELECT EmployeeID,EmployeeName,EmployeeExtension from employee";
        }
        else
        {
            SelectEmployee = "SELECT EmployeeName, EmployeeID,EmployeeExtension from employee";
        }


        MyCommand = new MySqlCommand(SelectEmployee, connection);
        MySqlDataAdapter DataValue = new MySqlDataAdapter(MyCommand);
        System.Data.DataTable data = new System.Data.DataTable();
        DataValue.Fill(data);

        List<String[]> EmployeeName = new List<string[]>();


        String extension = "", Floor = "";
        
        bool BooleanResult = true;

        foreach (DataRow Name in data.Rows)
        {
            String[] SplitNameArray = Name[0].ToString().Split(' ');
            for (int i = 0; i < SplitNameArray.Length; i++)
            {
                BooleanResult = (SplitNameArray[i].ToLower()).StartsWith(name.ToLower().Trim());

                if (BooleanResult == false)
                {
                    BooleanResult = (Name[0].ToString().ToLower()).StartsWith(name.ToLower().Trim());
                }

                if (BooleanResult)
                {
                    connection.Close();
                    extension = Name[2].ToString();
                   string SelectFloor = "SELECT Floor_Detail FROM Floor_Detail Where Extension = '" + extension + "'";
                    MySqlCommand MyCommandFloor = new MySqlCommand(SelectFloor, connection);
                    connection.Open();
                    MySqlDataReader reader_ = MyCommandFloor.ExecuteReader();
                    while (reader_.Read())
                    {
                        Floor = reader_.GetString(0).ToString();
                    }
                    EmployeeName.Add(new String[] { Name[0].ToString(), Name[1].ToString(), Name[2].ToString(), Floor });
                    break;
                }
            } connection.Close();
        }
        connection.Close();
        return EmployeeName;
    }


    [System.Web.Services.WebMethod]
    public static String[][] GetEmployee(string name, int id)
    {
        List<String[]> nameSearch = SearcEmployee(name,id);
        String[][] arry = nameSearch.ToArray();
        return arry;
    }


    public static List<String[]> SearchFloor(String name)
    {
        string connectionString = @"server=localhost; userid=root; password=root; database=EmployeeData";

        MySqlConnection connection = new MySqlConnection(connectionString);

        List<String[]> Employext = new List<string[]>();

        String Floor = "";

        string SelectFloor = "SELECT Floor_Detail FROM Floor_Detail Where Extension = '" + name + "'";

        MySqlCommand MyCommandFloor = new MySqlCommand(SelectFloor, connection);

        connection.Open();

        MySqlDataReader reader_ = MyCommandFloor.ExecuteReader();

        while (reader_.Read())
        {

            Floor = reader_.GetString(0).ToString();

        }

        Employext.Add(new String[] { Floor });

        connection.Close();

        return Employext;

    }


    [System.Web.Services.WebMethod]

    public static String[][] GetFloor(string name)
    {

        List<String[]> FloorSearch = SearchFloor(name);

        String[][] FloorArry = FloorSearch.ToArray();

        return FloorArry;

    }


    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
    //    string dropDownItem = DropDownFloor.SelectedItem.Text;


    //    //SELECT DISTINCT Floor_Detail FROM Floor_Detail order by Floor_Detail ASC"
    //    string getExtention = "SELECT Extension FROM Floor_Detail Where Floor_Detail = '" + dropDownItem + "' order by Extension ASC";
    //    myDataConnection.Open();
    //    MySqlCommand getExt = new MySqlCommand(getExtention, myDataConnection);
    //    MySqlDataAdapter ExtAdpt = new MySqlDataAdapter(getExt);
    //    DataSet ds = new DataSet();
    //    ExtAdpt.Fill(ds);
    //    myDataConnection.Close();
    //    ExtentionDropDown.DataSource = ds;
    //    ExtentionDropDown.DataTextField = "Extension";
    //    ExtentionDropDown.DataValueField = "Extension";
    //    ExtentionDropDown.DataBind();

       
    //}
        BindDropDownList2(DropDownFloor.SelectedItem.Text);

    }

    private void BindDropDownList2(string field)
    {
        DataTable dt = new DataTable();
        //SqlConnection connection = new SqlConnection(GetConnectionString());
        try
        {
            myDataConnection.Open();
            string sqlStatement = "SELECT Extension FROM Floor_Detail WHERE Floor_Detail = @Value1";
            MySqlCommand sqlCmd = new MySqlCommand(sqlStatement, myDataConnection);
            sqlCmd.Parameters.AddWithValue("@Value1", field);
            MySqlDataAdapter sqlDa = new MySqlDataAdapter(sqlCmd);
            sqlDa.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ExtentionDropDown.DataSource = dt;
                ExtentionDropDown.DataTextField = "Extension"; // the items to be displayed in the list items
                ExtentionDropDown.DataValueField = "Extension"; // the id of the items displayed
                ExtentionDropDown.DataBind();
            }
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            string msg = "Fetch Error:";
            msg += ex.Message;
            throw new Exception(msg);
        }
        finally
        {
            myDataConnection.Close();
        }
    }
}