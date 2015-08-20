using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Data;
using System.Net;

public partial class Admin : System.Web.UI.Page
{

    MySqlConnection myDataConnection = Connection.CreateConnection();

    MySqlDataReader reader = null;
    int result;

    protected void Page_Load(object sender, EventArgs e)
    {
        CheckParameter();        
    }

    private void Check_Access()
    {
        if (result != 1)
        {
            Response.Redirect("Default.aspx");
        }
    }

    private void CheckParameter()
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

        catch (NullReferenceException nullException)
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

            string SelectAdmin = "SELECT Admin_ID FROM Admin where Admin_ID='" + nameID + "'";
            MySqlCommand MyCommandAdmin = new MySqlCommand(SelectAdmin, myDataConnection);
            reader = MyCommandAdmin.ExecuteReader();

            if (!reader.HasRows)
            {
                Response.Redirect("HomePage.aspx");

            }
            myDataConnection.Close();
            

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


    protected void Register_Admin(object sender, EventArgs e)
    {

        int chechResult = 0;
        chechResult= checkData(TextBoxID.Text);
        try
        { 
            string InsertAdmin = "insert into Admin (Admin_ID, Admin_Name) values('" + this.TextBoxID.Text.ToUpper() + "','" + this.TextBoxName.Text + "');";

            if (chechResult == 0)
            {
                MySqlCommand MyCommandAdmin = new MySqlCommand(InsertAdmin, myDataConnection);
                myDataConnection.Open();
                MyCommandAdmin.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Saved Sucessfully'); ", true);
                
                TextBoxName.Text = "";
                TextBoxID.Text = "";

               
            }
            else 
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Already Exists'); ", true);
                
                TextBoxName.Text = "";
                TextBoxID.Text = "";
            }
        }
        catch (Exception ex)
        {
            
        }
        myDataConnection.Close();
    }



    private int checkData(String AdminID)
    {
        MySqlDataReader reader = null;
        int resultData = 0;
        try
        {
            myDataConnection.Open();
            string SelectAdmin = "SELECT Admin_ID FROM Admin where Admin_ID='" + AdminID + "'";
            MySqlCommand command = new MySqlCommand(SelectAdmin, myDataConnection);
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
    
    

    protected void Update(object sender, EventArgs e)
    {
        string UpdateAdmin = "";
        try
        {
            if (SelectBy.SelectedIndex == 0)
            {
                UpdateAdmin = "update Admin set Admin_ID='" + TextBoxEditID.Text.ToUpper() + "', Admin_Name='" + TextBoxEditName.Text + "' where Admin_ID='" + TextBoxSearchID.Text.ToUpper() + "';";
            }
            else if (SelectBy.SelectedIndex == 1)
            {
                UpdateAdmin = "update Admin set Admin_ID='" + TextBoxEditID.Text.ToUpper() + "', Admin_Name='" + TextBoxEditName.Text + "' where Admin_Name='" + TextBoxSearchID.Text + "';";
            }

            MySqlCommand MyCommandUpdateAdmin = new MySqlCommand(UpdateAdmin, myDataConnection);

            
                myDataConnection.Open();
                MyCommandUpdateAdmin.ExecuteNonQuery();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Updated Successfully'); ", true);
                 
                TextBoxEditID.Text = "";
                TextBoxEditName.Text = "";
                TextBoxSearchID.Text = "";
            
            
             
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
        string DeleteAdmin = "";
        try
        {

            int deleteID = checkData(TextBoxDelete.Text);

            if (Delete_Radio.SelectedIndex == 0)
            {
                DeleteAdmin = "delete from Admin where Admin_ID='" + TextBoxDelete.Text + "';";

            }
            else
            {
                DeleteAdmin = "delete from Admin where Admin_Name='" + TextBoxDelete.Text + "';";
            }


            MySqlCommand MyCommandDelete = new MySqlCommand(DeleteAdmin, myDataConnection);

            myDataConnection.Open();

            MyCommandDelete.ExecuteNonQuery();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Is Deleted Successfully'); ", true);
                 
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




    //////////////////////////////////////////////////////////////////////////////


    public static List<String[]> SearcAdmin(String name, int id)
    {

        string connectionString = @"server=localhost; userid=root; password=root; database=EmployeeData";
        MySqlConnection connection = new MySqlConnection(connectionString);

        MySqlCommand MyCommandSelect;
        string SelectAdmin = "";

        connection.Open();

        if (id == 1)
        {
            SelectAdmin = "SELECT Admin_ID,Admin_Name from admin";
        }
        else
        {
            SelectAdmin = "SELECT Admin_Name, Admin_ID from admin";
        }
            
        MyCommandSelect = new MySqlCommand(SelectAdmin, connection);
        MySqlDataAdapter DataValue = new MySqlDataAdapter(MyCommandSelect);
        System.Data.DataTable data = new System.Data.DataTable();
        DataValue.Fill(data);

        List<String[]> NameResult = new List<string[]>();

        bool BooleanResult = true;
        foreach (DataRow AdminName in data.Rows)
        {

            String[] SplitNameArray = AdminName[0].ToString().Split(' ');
            for (int i = 0; i < SplitNameArray.Length; i++)
            {
                BooleanResult = (SplitNameArray[i].ToLower()).StartsWith(name.ToLower().Trim());
                if (BooleanResult == false)
                {
                    BooleanResult = (AdminName[0].ToString().ToLower()).StartsWith(name.ToLower().Trim());
                }
                //(!drNameArray[j + k].ToLower().StartsWith(inNameArray[k].ToLower()))
                if (BooleanResult)
                {
                    NameResult.Add(new String[] { AdminName[0].ToString(), AdminName[1].ToString() });
                    break;
                }
            }
           
        }

        return NameResult;
    }



    [System.Web.Services.WebMethod]
    public static String[][] GetAdmin(string name, int id)
    {
        List<String[]> nameSearch = SearcAdmin(name, id);
        String[][] NameArray = nameSearch.ToArray();
        return NameArray;
    }





}