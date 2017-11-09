<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<title>result</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<%--<script src="js/jquery-1.11.3.min.js"></script>--%>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>

<style>
    .col-center-block {
        float: none;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
    
</style>

<body>
<br>
<br>
<div class="container">
    <div class="row">
        <div class="col-md-5 column" >
        	<div class="row">
        		<a href="http://52.26.82.166:8080/InsDetector/" class="btn btn-default btn-lg" role="button">Back</a>
        		<br>
        		<br>
        		
        	</div>
	        <div class="row">
	        	<div class="col-md-4 column" >
	            	<img id="image" src="<% out.println(request.getAttribute("image"));%>"/>
	            </div>
	        </div>
	        <div class="row">
	        	<div class="col-md-4 column" >
	        	<br>
    				<i id="userId">UserId:<% out.println(request.getAttribute("Id"));%></i>
    			</div>
	        </div>
	        <div class="row">
	        	<div class="col-md-12 column col-center-block" >
		            <table class="table table-striped" border="1">
		            	<caption>Result</caption>
		                <thead>
			                <tr>
			                    <th class="text-center">Category</th>
			                    <th class="text-center">correlation coefficient</th>
			                </tr>
		                </thead>
		                <tbody>
			                <c:forEach var="ResultLists" items="${ResultList}">
			                    <tr>
			                        <td class="text-center">${ResultLists.result1}</td>
			                        <td class="text-center">${ResultLists.result2}</td>
			                    </tr>
			                </c:forEach>
		                </tbody>
		            </table>
		        </div>
        	</div>
    	</div>
    	
    	<i id="feature" hidden><% out.println(request.getAttribute("feature1"));%></i>
    	
    <div id="chart" class="col-md-7 column" ></div>
    </div>
</div>
<script>
				$(function() {  
					var urlName=$("#feature").html();
			        urlName=urlName.substring(1,urlName.length-2);
			        urlName=urlName.split(",");
					/* var keyList = eval('${test}');
					var rs = [];
					for(var i=0;i<keyList.length;i++){ 
						 
						rs.push([keyList[i][0].toString(),keyList[i][1]]); 
					
					}	 */
					/* var keyList1 = eval('${feature1}'); */  
					var keyList2 = eval('${feature2}');
					/* var lla = eval('${feature1}'); */    
					var rs = [];
					for(var i=0;i<keyList2.length;i++){ 
						 
							rs.push([urlName[i],keyList2[i]]); 
						
					}  
				   var chart = {
				       plotBackgroundColor: null,
				       plotBorderWidth: null,
				       plotShadow: false
				       
				   };
				   var title = {
				      text: 'Pie Chart of Result'   
				   };      
				   var tooltip = {
				      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
				   };
				   
				   var plotOptions = {
				      pie: {
				         allowPointSelect: true,
				         cursor: 'pointer',
				         dataLabels: {
				            enabled: true,
				            format: '{point.percentage:.1f} %',
				            style: {
				               color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
				            }
				         }
				      }
				   
				   };
				   var credits = {
				   		 enabled: false
				   };
				   
				   var series= [{
				      type: 'pie',
				      name: 'Percentage',
				      data: rs   
				   }];     
				      
				   var json = {};   
				   json.chart = chart;
				   json.credits = credits;
				   json.title = title;     
				   json.tooltip = tooltip;  
				   json.series = series;
				   json.plotOptions = plotOptions;
				   $('#chart').highcharts(json);  
				});
			</script>
</body>


