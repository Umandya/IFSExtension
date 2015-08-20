using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class ExtensionManagement : System.Web.UI.Page
{

    MySqlConnection myDataConnection = Connection.CreateConnection();

    MySqlDataReader reader = null;

    int dataExist;

    protected void Page_Load(object sender, EventArgs e)
    {
     
    }


    protected void ExtensionSubmit_Click(object sender, EventArgs e)
    {
        checkExistence();
        string AddExtension = "";
        try
        {
            if (dataExist != 1)
            {
                if (DropDownCategory.SelectedIndex == 0)
                {
                    AddExtension = "insert into Floor_Detail (Extension, Floor_Detail) values('" + TextBoxExtension.Text + "', '" + TextBoxName.Text + "');";
                }
                else if (DropDownCategory.SelectedIndex == 1)
                {
                    AddExtension = "insert into important (Extension, Name) values('" + TextBoxExtension.Text + "', '" + TextBoxName.Text + "');";
                }
                else if (DropDownCategory.SelectedIndex == 2)
                {
                    AddExtension = "insert into conference_hall (Conference_Hall_Extension, Name) values('" + TextBoxExtension.Text + "', '" + TextBoxName.Text + "');";
                }

                MySqlCommand MyCommandAddExtension = new MySqlCommand(AddExtension, myDataConnection);


                myDataConnection.Open();
                MyCommandAddExtension.ExecuteNonQuery();
                TextBoxName.Text = "";
                TextBoxExtension.Text = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Saved Successfully') ;", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Already Exists') ;", true);
                TextBoxExtension.Text = "";
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

    public int checkExistence()
    {
        //int dataExist = 0;
        string checkData = "";
        try
        {
            if (DropDownCategory.SelectedIndex == 0)
            {
                checkData = "SELECT * FROM Floor_Detail where Extension='" + TextBoxExtension.Text + "'";
            }
            else if (DropDownCategory.SelectedIndex == 1)
            {
                checkData = "SELECT * FROM Important where Extension='" + TextBoxExtension.Text + "'";
            }
            else if (DropDownCategory.SelectedIndex == 2)
            {
                checkData = "SELECT * FROM Conference_Hall where Conference_Hall_Extension='" + TextBoxExtension.Text + "'";
            }

            MySqlCommand MyCommandCheckExtension = new MySqlCommand(checkData, myDataConnection);
            myDataConnection.Open();

            reader = MyCommandCheckExtension.ExecuteReader();

            if (reader.HasRows)
            {
                dataExist = 1;

            }
            
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Existing') ;", true);
            //TextBoxName.Text = "";
            //TextBoxExtension.Text = "";


        }
        catch (Exception ex)
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
        }
        myDataConnection.Close();
        return dataExist;
    }
}