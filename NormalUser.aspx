<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NormalUser.aspx.cs" Inherits="Normal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=10" /> 
     
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js" type = "text/javascript"></script>
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"  type = "text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type = "text/javascript"></script>

    <link href="jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />

     <script type="text/javascript">
         

        function Edit_Extension_onblur() {
            var inputName = document.getElementById("TextBoxEditExtension").value;
            $.ajax({
                url: "EmployeeManagement.aspx/GetFloor",
                data: "{ 'name': '" + inputName + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $('#<%=DropDownEditFloor.ClientID %>').val(data.d[0][0].toString());
                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }


        window.onload = function image() {
            var name = document.getElementById("TextBoxEditID").value;
            $.ajax({
                url: "NormalUser.aspx/GetImage",
                data: "{ 'name': '" + name + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var urls = (data.d[0][0].toString());
                    $('.profile-pic').one("load", function () {
                    }).attr("src", urls);
                },
                error: function (data) {
                    alert(data.responseText);
                },
                failure: function (response) {
                    alert(data.responseText);
                }
            });


        }
        
       













    </script>

    <style type="text/css">

         .upload-button {
    padding: 14px;
    border: 1px solid black;
    border-radius: 5px;
    display: block;
    float: left;
             z-index: 1;
             left: 921px;
             top: 399px;
             position: absolute;
             height: 18px;
             width: 103px;
         }

.profile-pic {
    max-width: 100px;
    max-height: 100px;
    display: block;
    height: 123px;
    width: 123px;
             z-index: 1;
             left: 891px;
             top: 422px;
             position: absolute;
         }

.file-upload {
    display: none;
}
</style>





</head>

<body>
    <form id="form1" runat="server">
    <div >
        
         <asp:Panel runat="server" class = "divOne" style="position:absolute">

     
        <table class = "table1">

            <tr>
                <td>
                    <asp:Image ID="Image1" runat="server" ImageUrl = "a.png"/>
                </td>

                <td>
                     <h1 class = "text1">IFS EXTENSION FINDER</h1>
                </td>
            </tr>

        </table>

        
    </asp:Panel>

      <div class = "divThreeMain">
                <div class = "divThree" id = "divThree" runat = "server" 
                        style="position:absolute; top: 180px; left: 110px;">
                   <ul>
		             <li><a href="Default.aspx">Home</a></li>
                      <li><a href="#">Profile</a>
			            <ul>
				            <li><a href='NormalUser.aspx?p=add' id="add" runat="server">Add Me</a></li>
				            <li><a href='NormalUser.aspx?p=edit' id="edit" runat="server">Edit Profile</a></li>
			            </ul>
		             </li>

		        </ul>

              </div>  
        </div>
        
                    <asp:Panel ID="AdminRegister" runat="server" Font-Bold="True" BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px"
                    Font-Names="Calibri" Font-Size="12pt" style="top: 332px; left: 108px; position: relative; width: 1023px; height: 317px;">

<asp:Label ID="IDLabel" runat="server"
style="height: 19px; top: 82px; left: 228px; position: absolute; width: 72px"
Text="Employee_ID" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"></asp:Label>

<asp:Label ID="NameLabel" runat="server" ForeColor="#873E8D"
style="height: 19px; top: 121px; left: 228px; position: absolute; width: 119px"
Text="Employee_Name"></asp:Label>

<asp:TextBox ID="TextBoxID" runat="server" ForeColor="Black"
style="height: 23px; top: 81px; left: 387px; position: absolute; width: 185px"
Width="200px" ></asp:TextBox>

<asp:TextBox ID="TextBoxName" runat="server" ForeColor="Black"
style="height: 23px; top: 119px; left: 387px; position: absolute; width: 185px"
Width="200px"></asp:TextBox>

<asp:RequiredFieldValidator ID="IDRequired" runat="server"
ControlToValidate="TextBoxID" ErrorMessage="ID is Required"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#E53527"

                            style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 82px; left: 598px; position: absolute; width: 157px"></asp:RequiredFieldValidator>

<asp:RequiredFieldValidator ID="NameRequired" runat="server"
ControlToValidate="TextBoxName" ErrorMessage="Name is Required"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#E53527"

                            style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 120px; left: 599px; position: absolute; width: 157px; bottom: 178px;"></asp:RequiredFieldValidator>

<asp:Label ID="ExtensionLabel" runat="server" ForeColor="#873E8D"
style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 195px; left: 228px; position: absolute; width: 131px"
Text="Employee_Extension"></asp:Label>

 

<asp:Button ID="ButtonRegister" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" ForeColor="White" onclick="Register_Me"
style="height: 26px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 236px; left: 406px; position: absolute; width: 84px"
Text="Register" />

<asp:Label ID="LabelFloor" runat="server" ForeColor="#873E8D"
style="font-family: Calibri; font-size: 12pt; font-weight: bold; top: 160px; left: 228px; position: absolute; width: 133px; height: 19px"
Text="Floor_Detail"></asp:Label>

<asp:DropDownList ID="DropDownFloor" runat="server" ForeColor="Black" onselectedindexchanged="DropDownList1_SelectedIndexChanged"

                            style="font-family: Calibri; font-size: 12pt; font-weight: bold; top: 156px; left: 387px; position: absolute; width: 185px; height: 23px" 
                            AutoPostBack="True">
 
</asp:DropDownList>

                        <asp:DropDownList ID="DropDownList1" runat="server" 
                             
                            
                            style="z-index: 1; left: 388px; top: 187px; position: absolute; height: 22px; width: 183px;">
                        </asp:DropDownList>

</asp:Panel>

<asp:Panel ID="EditPanel" runat="server"
BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px"
style="top: 332px; left: 108px; position: relative; width: 1023px; height: 317px;">
<asp:Label ID="IDLabelEdit" runat="server"
style="height: 19px; top: 91px; left: 250px; position: absolute; width: 72px"
Text="Employee_ID" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>
<asp:Label ID="NameLabelEdit" runat="server"
style="height: 19px; top: 129px; left: 250px; position: absolute; width: 72px"
Text="Employee_Name" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>
<asp:TextBox ID="TextBoxEditName" runat="server" ForeColor="Black"
style="height: 22px; top: 128px; left: 393px; width: 185px; position: absolute;"
Width="200px"></asp:TextBox>
<asp:TextBox ID="TextBoxEditID" runat="server" ForeColor="Black"
style="height: 22px; top: 90px; left: 393px; width: 185px; position: absolute;"
Width="200px" ></asp:TextBox>
<asp:Button ID="ButtonUpdate" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" Font-Bold="True" ForeColor="White" onclick="Update"
style="top: 244px; left: 393px; position: absolute; width: 67px; height: 26px"
Text="Update" />
<asp:Label ID="LabelEditExtension" runat="server"
style="top: 205px; left: 250px; position: absolute; width: 34px; height: 19px"
Text="Extension" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>
<asp:Label ID="LabelEditFloor" runat="server"
style="top: 167px; left: 250px; position: absolute; width: 34px; height: 19px"
Text="Floor_Detail" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>
<asp:TextBox ID="TextBoxEditExtension" runat="server" ForeColor="Black" onblur = "Edit_Extension_onblur()"
style="top: 204px; left: 393px; position: absolute; width: 185px; height: 22px"
Width="200px"></asp:TextBox>
<asp:DropDownList ID="DropDownEditFloor" runat="server" ForeColor="Black"

        style="top: 166px; left: 393px;  position: absolute; font-weight:bold; width: 185px; height: 22px" 
        AutoPostBack="True">
 
</asp:DropDownList>
</asp:Panel>






             <img class="profile-pic" src="" />
<asp:FileUpload ID="FileUpload1" runat="server"
style="z-index: 1; left: 891px; top: 561px; position: absolute; height: 23px;"
ForeColor="Black" />
<asp:Button ID="Button1" runat="server" Text="Upload" onclick="Button1_Click"


             style="z-index: 1; left: 891px; top: 593px; position: absolute; width: 113px; height: 30px" />
    </div>

    

    </form>
</body>
</html>
