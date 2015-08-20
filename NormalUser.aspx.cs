using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Net;
using System.Web.Services;
using System.IO;
using System.Data;

    public partial class Normal : System.Web.UI.Page
    {

    MySqlConnection myDataConnection = Connection.CreateConnection();

    MySqlDataReader reader = null;
    MySqlDataReader reader_ = null;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        CheckParameter();
        if (!Page.IsPostBack)
        {
            try
            {
                dropDownFoor();
                BindDropDownList(DropDownFloor.SelectedItem.Text);
            }catch(Exception ex){}
           SearchToEdit();

        }
       
    }

    private void CheckParameter()
    {
        int result = 0;
        try
        {
            string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
            
            result=checkData(nameID);
           

            String parameter = Request.Params["p"].ToString();

            if (result == 1)
            {
                add.Visible = false;
            }
            else
            {
                edit.Visible = false;
            }

            if (parameter == "add")
            {
                VisibleAdd();
            }


            if (parameter == "edit")
            {
                VisibleEdit();
            }
        }
        catch (NullReferenceException nr)
        {
            Response.Redirect("Default.aspx");
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

    
    protected void Register_Me(object sender, EventArgs e)
    {
         string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
         int checkedFloor = checkFloor(DropDownList1.SelectedItem.Text, DropDownFloor.SelectedItem.Text);
        string ImgPath = "Images/IFS.png"; 
        try
        {
            string InsertEmployee = "insert into Employee (EmployeeID, EmployeeName, EmployeeExtension, Employee_Image) values('" + nameID + "','" + this.TextBoxName.Text + "' ,'" + this.DropDownList1.SelectedItem.Text + "','" + ImgPath + "');";
            string InsertFloorDetail = "insert into Floor_Detail (Extension, Floor_Detail) values('" + this.DropDownList1.SelectedItem.Text + "', '" + this.DropDownFloor.SelectedItem.Text + "');";

            if (checkedFloor == 1)
                {
                    MySqlCommand MyCommandEmployee = new MySqlCommand(InsertEmployee, myDataConnection);
                    myDataConnection.Open();
                    
                    MyCommandEmployee.ExecuteNonQuery();
                    myDataConnection.Close();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Saved Sucessfully') ;", true);
                    Response.Redirect("NormalUser.aspx?p=edit");
            
            }
          /*  else if (checkedFloor == 0)
                {
                    MySqlCommand MyCommandEmployee = new MySqlCommand(InsertEmployee, myDataConnection);
                    MySqlCommand MyCommandFloor = new MySqlCommand(InsertFloorDetail, myDataConnection);
                    myDataConnection.Open();
                    MyCommandEmployee.ExecuteNonQuery();
                    MyCommandFloor.ExecuteNonQuery();
                    myDataConnection.Close();
                }*/
            else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Floor Detail & Extention Mismatch! Try Again') ;", true);
                     
                    DropDownFloor.SelectedIndex = 0;
                }

            

             
            }
           
        
        catch (Exception ex)
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
            
        }
        finally
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }

        }


    }



    private int checkData(String emplyeeID)
    {
        MySqlDataReader reader = null;
        int resultData=0;
        try
        {
          
            myDataConnection.Open();

            string SelectEmployee = "SELECT EmployeeID FROM Employee where EmployeeID='"+emplyeeID+"'";
            MySqlCommand command =  new MySqlCommand(SelectEmployee, myDataConnection);
            reader = command.ExecuteReader();


            if(reader.HasRows){

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
            string SelectFloor = "SELECT Extension,Floor_Detail FROM Floor_Detail where Extension='" + extension + "' && Floor_Detail='"+floor+"' ";
            MySqlCommand command = new MySqlCommand(SelectFloor, myDataConnection);
            reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                floorResult = 1;
            }
            
           /* while (reader.Read())
            {
                if (reader.GetString(0) == extension)
                {
                    if (reader.GetString(1) == floor)
                    {
                        result1 = 1;
                    }
                    else
                    {
                        result1 = 2;
                    }
                }
                else
                {
                    result = 0;
                }

               
            }/*
            */
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

    protected void SearchToEdit()
    {
        string id = "", extension = "", name = "";
        string floor = "";
        try
        {
            string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
            string SelectEmployee = "SELECT * FROM Employee WHERE EmployeeID = '" + nameID + "'";


            MySqlCommand MyCommandEmployee = new MySqlCommand(SelectEmployee, myDataConnection);
            myDataConnection.Open();
            reader = MyCommandEmployee.ExecuteReader();

            while (reader.Read())
            {
                id = reader.GetString(0).ToString();
                name = reader.GetString(1).ToString();
                extension = reader.GetString(2).ToString();
            }

            myDataConnection.Close();

            string SelectFloor = "SELECT Floor_Detail FROM Floor_Detail Where Extension = '" + extension + "'";

          
            MySqlCommand MyCommandFloor = new MySqlCommand(SelectFloor, myDataConnection);
            myDataConnection.Open();
            reader_ = MyCommandFloor.ExecuteReader();


            while (reader_.Read())
            {
                floor = reader_.GetString(0).ToString();

            }

                TextBoxEditID.Text = id;
                TextBoxEditName.Text = name;
                TextBoxEditExtension.Text = extension;
                DropDownEditFloor.SelectedIndex = DropDownEditFloor.Items.IndexOf(DropDownEditFloor.Items.FindByText(floor));
       
            

        }
        catch (Exception ex)
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
        }
        finally
        {
            if (myDataConnection != null)
            {
                myDataConnection.Close();
            }
        }
    }


    protected void Update(object sender, EventArgs e)
    {
        string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
        int resultFloor = checkFloor(TextBoxEditExtension.Text, DropDownEditFloor.SelectedItem.ToString());
        try
        {
            string UpdateEmployee = "update Employee set EmployeeID='" + TextBoxEditID.Text.ToUpper() + "', EmployeeName='" + TextBoxEditName.Text + "', EmployeeExtension='" + TextBoxEditExtension.Text + "' where EmployeeID = '" + nameID + "';";
            MySqlCommand MyCommandEmployee = new MySqlCommand(UpdateEmployee, myDataConnection);

            
            if (resultFloor == 1)
            {
                myDataConnection.Open();
                MyCommandEmployee.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Information Updated Sucessfully'); ", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Floor & Extention Missmatch! Try Again'); ", true);
            }
            
            
        }
        catch (Exception ex)
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

    private void VisibleAdd()
    {
        AdminRegister.Visible = true;
        EditPanel.Visible = false;
    }

    private void VisibleEdit()
    {
        AdminRegister.Visible = false;
        EditPanel.Visible = true;
    }

    public static  List<String[]> SearchImage(string name)
    {

        List<String[]> Employext = new List<string[]>();
        try
        {
            string connectionString = @"server=localhost; userid=root; password=root; database=EmployeeData";

            MySqlConnection connection = new MySqlConnection(connectionString);
            
            String Img_path = "";
            string SelectFloor = "SELECT Employee_Image FROM Employee where EmployeeID='" + name + "'";
            MySqlCommand MyCommandFloor = new MySqlCommand(SelectFloor, connection);
            connection.Open();
            MySqlDataReader reader_ = MyCommandFloor.ExecuteReader();
            while (reader_.Read())
            {
                Img_path = reader_.GetString(0).ToString();
            }
            Employext.Add(new String[] { Img_path });

            connection.Close();
        }
        catch(Exception ex){}
        return Employext;

    }


    //[WebMethod(EnableSession = true)]
   [System.Web.Services.WebMethod]
    public static String[][] GetImage(string name)
    {

        List<String[]> FloorSearch = SearchImage(name);

        String[][] image_Arry = FloorSearch.ToArray();

        return image_Arry;

    }
   protected void Button1_Click(object sender, EventArgs e)
   {
       string nameID = Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName.Substring(0, 6).ToUpper();
       string UserName = "SELECT EmployeeID FROM Employee where EmployeeID='" + nameID + "'";
       //string SelectAdmin = "SELECT Admin_ID FROM Admin where Admin_Name='" +Admin+"'";
       MySqlCommand command = new MySqlCommand(UserName, myDataConnection);
       myDataConnection.Open();
       //command.ExecuteNonQuery();
       reader = command.ExecuteReader();
       myDataConnection.Close();

       if (reader != null)
       { 
           if (FileUpload1.HasFile)
           {
               string Extension =  Path.GetExtension(FileUpload1.FileName);
               if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".png" && Extension.ToLower() != ".jpg" && Extension.ToLower() != ".jpge")
               {
                   ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid Image Type');", true);
               }
               else
               {
                   int FileSize = FileUpload1.PostedFile.ContentLength;
                  
                   
                   if (FileSize > 1048576)
                   {
                       ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum Size is 1Mb');", true);
                   }
                   else
                   {
                       string pathName = "Images/" +nameID+Extension; 
                       string pathset = "update Employee set Employee_Image='" + pathName + "' where EmployeeID = '" + nameID + "';";
                       MySqlCommand set_path = new MySqlCommand(pathset, myDataConnection);
                       myDataConnection.Open();
                       set_path.ExecuteNonQuery();
                       myDataConnection.Close();
                        
                       if (File.Exists(Server.MapPath(pathName))) {
                           File.Delete(Server.MapPath(pathName));
                       
                       }
                       FileUpload1.SaveAs(Server.MapPath(pathName));
                      
                   }
               }
           }
           else
           {
               ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Select a file to Upload');", true);
           }


       }
       else
       {

           ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Register First');", true);

       }

   }
   protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
   {
       BindDropDownList(DropDownFloor.SelectedItem.Text);
   }

   private void BindDropDownList(string field)
   {
       DataTable dt = new DataTable();
       
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
               DropDownList1.DataSource = dt;
               DropDownList1.DataTextField = "Extension"; // the items to be displayed in the list items
               DropDownList1.DataValueField = "Extension"; // the id of the items displayed
               DropDownList1.DataBind();
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
           if (myDataConnection != null)
           {
               myDataConnection.Close();
           }
       }
   }


}