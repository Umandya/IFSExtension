using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.OleDb;
using System.Data;
using System.Xml;
using System.IO;
using System.Web.Services;
using System.Web.Hosting;
using System.Net;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    public static DataSet xmlData;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            String connStr = "provider=Microsoft.Jet.OLEDB.4.0;Data Source='" + Server.MapPath(ConfigurationManager.AppSettings["xlsFile"].ToString()) + "';Extended Properties='Excel 8.0;IMEX=1;HDR=NO;TypeGuessRows=0;ImportMixedTypes=Text'";
            OleDbConnection myConnection = new OleDbConnection(connStr);
            DataSet dsExtensions;
            DataSet dsResearch;
            DataSet dsImportant;
            OleDbDataAdapter myCommand;

            //Generate XML File
            if (IsXlSModify(GetLastUpdatedTime()))
            {
                downloadExcelFileFromServer();

                myCommand = new OleDbDataAdapter("select * from [Extensions$]", myConnection);
                dsExtensions = new System.Data.DataSet();
                myCommand.Fill(dsExtensions);
                myCommand = new OleDbDataAdapter("select * from [IFS Research & Development$]", myConnection);
                dsResearch = new System.Data.DataSet();
                myCommand.Fill(dsResearch);
                myCommand = new OleDbDataAdapter("select * from [Important Extensions$]", myConnection);
                dsImportant = new System.Data.DataSet();
                myCommand.Fill(dsImportant);
                myConnection.Close();

                GenerateXML(dsExtensions, dsResearch, dsImportant);
                SetLastUpdatedTime();
            }

            // Get Details From XML File to Dataset
            xmlData = ReadXML();
            // Generate html file 
            // GenerateNameList();
            GetImprotantExtentions();
        }
        // when exception is caught the program will directly read from the xml file since excel file donwload has failed 
        catch (Exception ex)
        {
            Logger(DateTime.Now + " : " + ex.ToString());

            // Get Details From XML File to Dataset
            xmlData = ReadXML();
            // Generate html file 
            // GenerateNameList();
            GetImprotantExtentions();
        }
    }


    public void GenerateXML(DataSet dsExt, DataSet dsRs, DataSet dsImp)
    {
        DataTable dt = dsExt.Tables[0];
        StreamWriter file = new System.IO.StreamWriter(Server.MapPath(ConfigurationManager.AppSettings["xmlFile"].ToString()));

        file.WriteLine("<?xml version=\"1.0\" standalone=\"yes\"?>");
        file.WriteLine("<EmployeeList>");

        // Extensions sheet  

        for (int j = 1; j < dt.Rows.Count; j++)
        {
            DataRow dr = dt.Rows[j];
            for (int i = 0; i < dt.Columns.Count; i = i + 2)
            {
                if (dr[i].ToString() != "")
                {
                    //Check if letters are there in the String
                    int noOfletter = Regex.Matches(dr[i].ToString(), @"[a-zA-Z]").Count;

                    if (noOfletter > 0)
                    {
                        file.WriteLine("<Employee>");
                        file.Write("<Name>");
                        file.Write(dr[i].ToString());
                        file.WriteLine("</Name>");

                        file.Write("<Ext>");
                        file.Write(dr[i + 1].ToString());
                        file.WriteLine("</Ext>");
                        file.WriteLine("</Employee>");
                    }
                }
            }
        }

        // IFS Research & Development
        dt = dsRs.Tables[0];
        foreach (DataRow dr in dt.Rows)
        {
            for (int i = 0; i < dt.Columns.Count; i = i + 2)
            {
                if (dr[i].ToString() != "")
                {
                    //Check if letters are there in the String
                    int noOfletter = Regex.Matches(dr[i + 1].ToString(), @"[a-zA-Z]").Count;

                    if (noOfletter > 0)
                    {
                        file.WriteLine("<Employee>");
                        file.Write("<Name>");
                        file.Write(dr[i + 1].ToString());
                        file.WriteLine("</Name>");

                        file.Write("<Ext>");
                        file.Write(dr[i].ToString());
                        file.WriteLine("</Ext>");
                        file.WriteLine("</Employee>");
                    }
                }
            }
        }

        // Important Extensions
        dt = dsImp.Tables[0];
        for (int j = 1; j < dt.Rows.Count; j++)
        {
            DataRow dr = dt.Rows[j];
            for (int i = 0; i < dt.Columns.Count; i = i + 2)
            {
                if (dr[i].ToString() != "")
                {
                    file.WriteLine("<Important>");
                    file.Write("<IName>");
                    file.Write(dr[i + 1].ToString());
                    file.WriteLine("</IName>");

                    file.Write("<IExt>");
                    file.Write(dr[i].ToString());
                    file.WriteLine("</IExt>");
                    file.WriteLine("</Important>");
                }
            }
        }
        file.WriteLine("</EmployeeList>");
        file.Close();
    }

    // Generate html file
    public void GenerateNameList()
    {
        IEnumerable<DataRow> orderedRows = xmlData.Tables[0].AsEnumerable().OrderBy(r => r.Field<String>("Name"));
        foreach (DataRow row in orderedRows)
        {
            //employ_name.InnerHtml = employ_name.InnerHtml + System.Environment.NewLine + String.Format("<option value='{0}'>", row[0].ToString());
        }
    }

    // Generate html file
    public void GetImprotantExtentions()
    {
        DataTable dt = xmlData.Tables[1];
        List<String> importantExtentions = new List<string>();

        divImportant.InnerHtml = divImportant.InnerHtml + System.Environment.NewLine + String.Format("<table style='width:100%'>");
        divConRooms.InnerHtml = divConRooms.InnerHtml + System.Environment.NewLine + String.Format("<table style='width:100%'>");

        foreach (DataRow dr in dt.Rows)
        {
            if (dr[0].ToString().Contains("Conference"))
            {
                divConRooms.InnerHtml = divConRooms.InnerHtml + System.Environment.NewLine + String.Format("<tr>");
                divConRooms.InnerHtml = divConRooms.InnerHtml + System.Environment.NewLine + String.Format("<td style='width:80%'>" + (dr[0].ToString().Replace("Conference", "")) + "</td><td>" + (dr[1].ToString()) + "</td>");
                divConRooms.InnerHtml = divConRooms.InnerHtml + System.Environment.NewLine + String.Format("</tr>");
            }
            else
            {
                divImportant.InnerHtml = divImportant.InnerHtml + System.Environment.NewLine + String.Format("<tr>");
                divImportant.InnerHtml = divImportant.InnerHtml + System.Environment.NewLine + String.Format("<td style='width:80%'>" + (dr[0].ToString()) + "</td><td>" + (dr[1].ToString()) + "<br></td>");
                divImportant.InnerHtml = divImportant.InnerHtml + System.Environment.NewLine + String.Format("</tr>");
            }

        }
        divConRooms.InnerHtml = divConRooms.InnerHtml + System.Environment.NewLine + String.Format("</table>");
        divImportant.InnerHtml = divImportant.InnerHtml + System.Environment.NewLine + String.Format("</table>");
    }


    // Compare XML last updated date and the XLS file's last modfied date 
    public Boolean IsXlSModify(DateTime lastModifiedDate)
    {
        double result = (DateTime.Now - lastModifiedDate).TotalDays;
        // if updated
        if (result >= 1)
            return true;
        else
            return false;
    }

    // generates the xml file with the last updated date
    public void SetLastUpdatedTime()
    {
        System.IO.StreamWriter file = new System.IO.StreamWriter(Server.MapPath(ConfigurationManager.AppSettings["xmlDateModifiedFile"].ToString()));
        file.WriteLine(DateTime.Now);
        file.Close();
    }

    // Get the last updated date stored in the XML file
    public DateTime GetLastUpdatedTime()
    {
        string text = System.IO.File.ReadAllText(Server.MapPath(ConfigurationManager.AppSettings["xmlDateModifiedFile"].ToString()));
        return DateTime.Parse(text);
    }

    // Read data.xml 
    public DataSet ReadXML()
    {
        string myXMLfile = Server.MapPath(ConfigurationManager.AppSettings["xmlFile"].ToString());
        DataSet ds = new DataSet();
        try
        {
            ds.ReadXml(myXMLfile);
        }
        catch (Exception ex)
        {
        }
        return ds;
    }

    // search extension
    public static List<String[]> SearchExt(String name)
    {
        bool result;
        int startIndx;
        String sName = "";
        DataTable dt = xmlData.Tables[0];
        List<String[]> ext = new List<string[]>();

        String[] inNameArray = name.Trim().Replace('.', ' ').Split(' ');
        inNameArray = inNameArray.Where(x => !string.IsNullOrEmpty(x)).ToArray();

        if (inNameArray.Length > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                for (int i = 0; i < dt.Columns.Count; i = i + 2)
                {
                    String[] drNameArray = dr[i].ToString().Split(' ');

                    for (int j = 0; j < drNameArray.Length; j++)
                    {
                        if (drNameArray[j].ToLower().StartsWith(inNameArray[0].ToLower()))
                        {
                            result = true;
                            startIndx = j;
                            for (int k = 0; k < inNameArray.Length; k++)
                            {
                                if (j + k < drNameArray.Length)
                                {
                                    if (!drNameArray[j + k].ToLower().StartsWith(inNameArray[k].ToLower()))
                                    {
                                        result = false;
                                        break;
                                    }
                                }
                                else
                                {
                                    result = false;
                                }
                            }
                            if (result)
                            {
                                int tmp = 0;
                                for (int m = 0; m < drNameArray.Length; m++)
                                {
                                    if (m >= startIndx && tmp < inNameArray.Length)
                                    {
                                        sName = sName + drNameArray[m].Remove(0, inNameArray[tmp].Length).Insert(0, "♣" + char.ToUpper(inNameArray[tmp][0]) + inNameArray[tmp++].Substring(1) + "♠") + " ";
                                    }
                                    else
                                    {
                                        sName = sName + drNameArray[m] + " ";
                                    }
                                }
                                ext.Add(new String[] { sName, dr[i + 1].ToString() });
                                sName = "";
                            }
                        }
                    }
                }
            }
        }
        return ext;
    }

    public static List<String> SearchOtherName(String ext, String name)
    {
        DataTable dt = xmlData.Tables[0];
        List<String> othrNames = new List<string>();

        foreach (DataRow dr in dt.Rows)
        {
            for (int i = 0; i < dt.Columns.Count; i = i + 2)
            {
                if (dr[i + 1].ToString().Equals(ext))
                {
                    othrNames.Add((dr[i].ToString()));
                }
            }
        }
        return othrNames;
    }

    public void downloadExcelFileFromServer()
    {

        try
        {
            String url = ConfigurationManager.AppSettings["xlsAbsolutePath"].ToString();
            String excelFileName = System.Web.Hosting.HostingEnvironment.MapPath(ConfigurationManager.AppSettings["xlsFile"].ToString());
            WebClient webClient = new WebClient();
            webClient.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["username"].ToString(),
                ConfigurationManager.AppSettings["password"].ToString(), ConfigurationManager.AppSettings["domain"].ToString());




            webClient.DownloadFile(url, excelFileName);

        }

        catch (WebException ex)
        {
            Logger("Excel File Download Failure  " + DateTime.Now + " : " + ex.ToString());

        }
    }

    public void Logger(String lines)
    {

        // Write the string to a file.append mode is enabled so that the log
        // lines get appended to file than wiping content and writing the log
        String filename = Server.MapPath(ConfigurationManager.AppSettings["exceptionLogger"].ToString());
        System.IO.StreamWriter file = new System.IO.StreamWriter(filename, true);
        file.WriteLine(lines);
        file.WriteLine();

        file.Close();

    }


    [System.Web.Services.WebMethod]
    public static String[][] GetExtention(string name)
    {
        List<String[]> nameSearch = SearchExt(name);
        String[][] arry = nameSearch.ToArray();
        return arry;
    }

    [System.Web.Services.WebMethod]
    public static String[] GetNamesbyExt(string name, string ext)
    {
        String[] namesArray = SearchOtherName(ext, name).ToArray();
        return namesArray;
    }
}

