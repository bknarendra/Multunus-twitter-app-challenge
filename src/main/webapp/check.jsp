<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="org.json.*,java.util.*,java.io.*;" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Twitter Puzzle</title>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Oleo+Script' rel='stylesheet' type='text/css'>
<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
<link href="screen.css" rel="stylesheet" type="text/css" />
<script src="jquery.tagcloud.min.js" type="text/javascript"></script>
<script src="jquery-1.2.6.min.js" type="text/javascript"></script>
<script src="jquery.tinysort.min.js" type="text/javascript"></script>
<script src="bootstrap.min.js"></script>
<script src="a.js"></script>
</head>
<body style="background-image:url(img/clouds.jpg)">
<div class="container-fluid">
<table width="100%" height="100%" >
<tr><td align="right"><img src="img/twitter-bird-1.png"></td></tr>
  <tr><td align="right"><a href="/" class="btn btn-primary btn-large"">Try another twitter handle</a></td></tr>
	<tr><td>
	<div class="row-fluid tag-cloud">
    <div class="span12">
      <div class="cloud">
	<ul id = "xpower" class="xmpl" >
	<%!public static Map sortByComparator(Map unsortMap) {
        List list=new LinkedList(unsortMap.entrySet());
        Collections.sort(list, new Comparator() {
        	public int compare(Object o1, Object o2) {
        		return (-1)*((Comparable)((Map.Entry)(o1)).getValue()).compareTo(((Map.Entry)(o2)).getValue());
            }
        });
        Map sortedMap=new LinkedHashMap();
		for (Iterator it = list.iterator(); it.hasNext();) {
	     	Map.Entry entry = (Map.Entry)it.next();
	     	sortedMap.put(entry.getKey(), entry.getValue());
		}
		return sortedMap;
	}
	%>
<%
if(request.getParameter("user_timeline").charAt(0)=='{')
{JSONObject k=new JSONObject(request.getParameter("user_timeline"));
if(k.has("error")) out.println(k.getString("error"));}
else {
		JSONArray j=new JSONArray(request.getParameter("user_timeline"));
		HashMap<Integer,Integer>map=new HashMap<Integer,Integer>();
		StringTokenizer st;
		String a;
		int cnt; 
		for(int i=0;i<j.length();i++){
			/*We have already filtered out replies in query itself but still in case.If this field is not null it means it is a reply and must not be considered*/
			if(!j.getJSONObject(i).getString("in_reply_to_screen_name").equals("null")) continue; 
			a=j.getJSONObject(i).getString("text");
			st=new StringTokenizer(a);
			cnt=st.countTokens();
			if(map.containsKey(cnt)) map.put(cnt,map.get(cnt).intValue()+1);
			else map.put(cnt, 1);
		}
		map=(HashMap)sortByComparator(map);
		for(Integer z:map.keySet()){
			out.println("<li  value="+map.get(z)+">"+z+"</li>");
		}
	}
%>
 	</ul>
      </div>
    </div>
  </div>
	</td></tr>
	<script type="text/javascript">
  $(function(){
    bindTagCloud()
  });
</script>
</table>
</body>
</html>