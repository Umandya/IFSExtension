<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
        <link rel="stylesheet" href="style.css" type="text/css" />
        <link rel="stylesheet" href="StyleSheet.css" type="text/css" />
        <script src="jquery-1.3.2.min.js" type="text/javascript"></script>

        <script type = "text/javascript">
            function searchNameChanged() {
                document.getElementById('search_name').addEventListener('input', function () {
                    document.getElementById("errorMessage").innerHTML = "";
                    getExt();
                });
            }

            function extMouseOver(eId) {
                if (document.getElementById("ext" + eId).style.textDecoration == "underline") {
                     document.getElementById("ext" + eId).style.textDecoration = "none"
                } else {
                    document.getElementById("ext" + eId).style.textDecoration = "underline";
                }
                
            }

            function viewData(id) {
                if (id == "important") {
                    if (document.getElementById("divImportant").style.visibility == "visible") {

                        //Change Arrow Direction
                        document.getElementById("imextImg").src = "downArrow.png";
                        document.getElementById("divImportant").style.visibility = "hidden";
                        document.getElementById("div6").style.height = "auto";
                        document.getElementById("divConRooms").style.height = "600px";
                    }else {
                        document.getElementById("imextImg").src = "upArrow.png";
                        document.getElementById("divImportant").style.visibility = "visible";
                        document.getElementById("div6").style.height = "200px";
                        document.getElementById("divConRooms").style.height = "400px";
                    }
                }

                if (id == "conference") {
                    if (document.getElementById("divConRooms").style.visibility == "visible") {

                        document.getElementById("coextImg").src = "downArrow.png";
                        document.getElementById("divConRooms").style.visibility = "hidden";
                    } else {
                        document.getElementById("coextImg").src = "upArrow.png";
                        document.getElementById("divConRooms").style.visibility = "visible";
                    }
                }
            }

             // Get extension by name
            function getExt() {
                document.getElementById("div3").style.maxHeight = "550px";
                document.getElementById("other_names").style.visibility = "hidden";
                document.getElementById("errorMessage").innerHTML = "";

                var inputName = document.getElementById("search_name").value;

                if ("" + inputName != "") {
                    $.ajax({
                        type: "POST",
                        url: "Default.aspx/GetExtention",
                        data: "{'name': '" + inputName + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",

                        success: function (response) {
                            document.getElementById("div2").style.visibility = "visible"
                            var table = "";
                            if (!response.d.toString() == "") {
                                table = "<table>"

                                for (var i = 0; i < response.d.length; i++) {
                                    if (!response.d[i][1].toString().match(/[\\\/]/ig)) {
                                        table = table.concat("<tr><td><label>" + response.d[i][0].toString().replace(new RegExp("♣", 'g'), "<span class='highlight'>").replace(new RegExp("♠", 'g'), "</span>") + "</label></td><td><label class = 'extClass' id='ext" + i + "' onmouseover='extMouseOver(" + i.toString() + ")' onmouseout = 'extMouseOver(" + i.toString() + ")' onclick = 'getNamesbyExt(" + response.d[i][1].toString() + ")'>" + response.d[i][1].toString() + "</label></td></tr>");
                                    } 
                                    else {
                                        table = table.concat("<tr><td><label>" + response.d[i][0].toString().replace(new RegExp("♣", 'g'), "<span class='highlight'>").replace(new RegExp("♠", 'g'), "</span>") + "</label></td><td><label class = 'extClass' id='ext' style = 'text-decoration: none;color:black;'>" + response.d[i][1].toString() + "</label></td></tr>");
                                    }

                                }
                                table = table.concat("</table")
                                document.getElementById("div3").innerHTML = table;
                            }
                            else {
                                document.getElementById("errorMessage").innerHTML = "Invalid Employee Name";
                                document.getElementById("div3").innerHTML = "";
                            }
                        },
                        failure: function (response) {
                            alert(response.d);
                        }
                    });
                }
                else {
                    document.getElementById("div2").style.visibility = "hidden";
                }
            }


            function getNamesbyExt(ext) {
                document.getElementById("div3").style.maxHeight = "250px";

                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetNamesbyExt",
                    data: "{'name': ' ' , 'ext': '" + ext + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function(response) {
                        var sa = "";
                        for (var i = 0; i < response.d.length; i++) {
                            sa = sa.concat(response.d[i].toString() + "<br><br>");
                        }
                        document.getElementById("other_names").style.visibility = "visible";
                        document.getElementById("names").innerHTML = sa;
                        document.getElementById("extValue").innerHTML = ext;
                    },

                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }

            function highlight(id) {

                if (id == "important") {
                    document.getElementById("importantdiv").style.border = "1px solid purple";
                }
                if (id == "conference") {
                    document.getElementById("conferencediv").style.border = "1px solid purple";
                }
            }
            function removehighlight(id) {

                if (id == "important") {
                    document.getElementById("importantdiv").style.border = "1px solid #ACBECF";
                }
                if (id == "conference") {
                    document.getElementById("conferencediv").style.border = "1px solid #ACBECF";
               }
            }
        </script>
        <title>Extensions Finder</title>
    </head>
    <body onload= "searchNameChanged()">
        <div id='heading'>
            <div id='headerLoc'>
                <div id='logoIfs'>
                </div>
                <header style = "margin-left:10px">
			        <h1>Extension Finder</h1>
		        </header>
            </div>
        </div>
	    <div id="container">
		    <!--search-->
            <section>
                <div id='extDetailsDiv' >
                    <div id = "divSearch" >
                        <form id="form1" runat="server" onsubmit="return false;">
                            <p>
                                <input id ="search_name"  placeholder="Employee Name.." runat="server"  onkeypress = "if (event.keyCode == 13) document.getElementById('search').click()" style = "width:270px;height:20px;">&nbsp;
                                <input type="image" onclick  = "getExt()" src="search.jpg" style = "width:25px;height:27px;position: absolute"/>
                            </p>
			                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="errorMessage"  style = "color:Red ; font-size:smaller">&nbsp;&nbsp;&nbsp; </label>
                               
                            </p>
                        </form>
	                </div>
	                <div id='div1'>
                        <div id='div2' style = "visibility:hidden">
			                <h3>Extension Details</h3>
                            <div id='div3' >
                            </div>
			            </div>
            	    <div id  = "other_names">
                        <h3>Employees having <a id = "extValue"></a> Extension</h3>
                        <div id='div4'>
                            <label id = "names"></label>
                        </div>
                    </div>
                    </div>
                </div>
                <div id='div5' >
                    <div id='div6'>
                        <div  id="importantdiv" class="divBtn" onclick = "viewData('important')"  onmouseover="highlight('important')" onmouseout="removehighlight('important')"  style = "cursor: pointer">
                            <label id='importantExt' title="Free Web tutorials"><b>Important Extensions</b></label>
                            <img id="imextImg" src="downArrow.png" alt="" height=10px width=10px  />
                            <div id = "divImportant" runat="server"></div>
                        </div>
                    </div>
                    <div id='div7' >
                        <div id='conferencediv' class="divBtn" onclick = "viewData('conference')" onmouseover="highlight('conference')" onmouseout="removehighlight('conference')"  style = "cursor: pointer">
                            <label id='conference'><b>Conference Rooms</b></label>
                            <img id="coextImg" src="downArrow.png" alt="" height=10px width=10px onclick=""/>
                            <div id = "divConRooms" runat="server" ></div>
                        </div>
                    </div>
                </div>
            </section>
        </div><!--container end-->
    	<div style="clear:both"></div>
	    <footer></footer>
    </body>
</html>
