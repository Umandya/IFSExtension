<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExtensionManagement.aspx.cs" Inherits="ExtensionManagement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=10" />
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">


        function ValChange(val) {

            var labelValue = document.getElementById('NameLabel');

            if (val.value == 1) {
                labelValue.innerHTML = "Floor Number";
            }
            else if (val.value == 2) {
                labelValue.innerHTML = "Name";
            }
            else if (val.value == 3) {
                labelValue.innerHTML = "Conference Room";
            }
        
        }
    
    </script>


</head>
<body>
    <form id="form1" runat="server">
    <div >
    
            <asp:Panel ID="Panel1" runat="server" class = "divOne" style="position:absolute">

     
        <table class = "table1">

            <tr>
                <td>
                    <asp:Image ID="Image1" runat="server" ImageUrl = "a.png" BorderWidth="2px" BorderColor="White" BorderStyle="Solid"/>
                </td>

                <td>
                     <h1 class = "text1">IFS EXTENSION FINDER</h1>
                </td>
            </tr>

        </table>

        
    </asp:Panel>

        <div class = "navMain">
                <div class = "nav" id = "nav" runat = "server">
                
                    
                   <ul>
		             <li><a href="Default.aspx">Home</a></li>

                      <li><a href="#">Administrator Management</a>
			            <ul>
				            <li><a href='AdminUserManagement.aspx?p=add'>Add Admin User</a></li>
				            <li><a href='AdminUserManagement.aspx?p=edit'>Edit Admin User</a></li>
				            <li><a href='AdminUserManagement.aspx?p=delete'>Delete Admin User</a></li>
			            </ul>
		             </li>

                      <li><a href="#">Employee Management</a>
			            <ul>
				            <li><a href='EmployeeManagement.aspx?p=add'>Add Employee</a></li>
				            <li><a href='EmployeeManagement.aspx?p=edit'>Edit Employee</a></li>
                            <li><a href='EmployeeManagement.aspx?p=delete'>Delete Employee</a></li>
				        </ul>
		            </li>
                    <li><a href="#">Extension Management</a>
			            <ul>
				            <li><a href='ExtensionManagement.aspx'>Add Extension</a></li>
				        </ul>
		            </li>
		        </ul>

                </div>
                </div>

    </div>

                <asp:Panel ID="AdminRegister" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" 
                    BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px"                      
                    style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;">
                    <asp:Label ID="NameLabel" runat="server" 
    style="z-index: 1; left: 325px; top: 140px; position: absolute; height: 22px; width: 130px;" 
                        Text="Floor Number" Font-Bold="True" Font-Names="Calibri" Font-Size="13pt" 
                        ForeColor="#873E8D"></asp:Label>

                         <asp:Label ID="CategoryLabel" runat="server" 
    style="z-index: 1; left: 277px; top: 69px; position: absolute; height: 22px; width: 130px;" 
                        Text="Category" Font-Bold="True" Font-Names="Calibri" Font-Size="13pt" 
                        ForeColor="#873E8D"></asp:Label>

                         <asp:Label ID="ExtensionLabel" runat="server" 
    style="z-index: 1; left: 325px; top: 180px; position: absolute; height: 22px; width: 130px;" 
                        Text="Extension" Font-Bold="True" Font-Names="Calibri" Font-Size="13pt" 
                        ForeColor="#873E8D"></asp:Label>



                    <asp:DropDownList ID="DropDownCategory" runat="server" onchange="ValChange(this);"
                        style="z-index: 1; left: 414px; top: 69px; position: absolute; width: 224px; height: 22px" 
                        Font-Names="Calibri" Font-Size="12pt" >
                        <asp:ListItem Value="1">Floor Extension</asp:ListItem>
                        <asp:ListItem Value="2">Important Extension</asp:ListItem>
                        <asp:ListItem Value="3">Conference Room Extension</asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox ID="TextBoxName" runat="server" 
                        
                        style="z-index: 1; left: 470px; top: 140px; height:22px; width:200px; position: absolute" 
                        Font-Names="Calibri" Font-Size="12pt"></asp:TextBox>

                    <asp:TextBox ID="TextBoxExtension" runat="server" 
                        
                        style="z-index: 1; left: 470px; top: 180px; height:22px; width:200px; position: absolute" 
                        Font-Names="Calibri" Font-Size="12pt"></asp:TextBox>

                    <asp:Button ID="ExtensionSubmit" runat="server" 
                        style="z-index: 1; left: 470px; top: 220px; position: absolute; height: 26px; width: 100px" 
                        Text="Submit" BackColor="#A878AE" BorderColor="#873E8D" Font-Bold="True" 
                        Font-Names="Calibri" Font-Size="13pt" ForeColor="White" 
                        onclick="ExtensionSubmit_Click" />


                        <asp:RequiredFieldValidator ID="NameValidator" runat="server" 
                        ControlToValidate="TextBoxName" ErrorMessage="Value is Required" 
                        Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#FF3300" 
                        style="z-index: 1; left: 680px; top: 142px; position: absolute"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="ExtensionValidator" runat="server" 
                        ControlToValidate="TextBoxExtension" ErrorMessage="RequiredFieldValidator" 
                        Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#FF3300" 
                        style="z-index: 1; left: 680px; top: 181px; position: absolute">Extension is Required</asp:RequiredFieldValidator>

                </asp:Panel>

    </form>
</body>
</html>
