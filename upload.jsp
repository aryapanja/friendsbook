

<%@ page import="java.io.*,javax.servlet.http.*,javax.servlet.*" %>  
<%@ page import="java.io.FileWriter,java.io.IOException,java.sql.*" %>
 <%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% 
			String id1=(String)session.getAttribute("temp_id");
    out.print(id1);
     String fname1="";
	String savePath = "Y:/", filepath = "", filename = "";  
	String contentType = "", fileData = "", strLocalFileName = "";  
	int startPos = 0, endPos = 0;  
	int BOF = 0, EOF = 0;  
%>
<%!  
	  
	void copyByte(byte[] fromBytes, byte[] toBytes, int start, int len)  
	{  
		for(int i=start;i<(start+len);i++)  
		{  
			toBytes[i - start] = fromBytes[i];

		}  
	}  
%>  
<%	  
	contentType = request.getContentType();  
	out.println("<br>Content type is :: " +contentType);  
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))   
	{  
		DataInputStream in = new DataInputStream(request.getInputStream());  
		DataInputStream in1 = in;  
		int formDataLength = request.getContentLength();  
		byte dataBytes[] = new byte[formDataLength];  
		int byteRead = 0;  
		int totalBytesRead = 0;  
		while (totalBytesRead < formDataLength)  
		{	  
			byteRead = in1.read(dataBytes, totalBytesRead, formDataLength);  
			totalBytesRead += byteRead;  
		}  
		out.println("<br>totalBytesRead : " + totalBytesRead + "    :   formDataLength = " + formDataLength);  
		byte[] line = new byte[128];  
		if (totalBytesRead < 3)	  
		{  
		  return;	//exit if file length is not sufficiently large  
		}  
  
		String boundary = "";  
		String s = "";  
		int count = 0;		  
		int pos = 0;    
		do  
		{  
			copyByte(dataBytes, line, count ,1);	  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf("Content-Disposition: form-data; name=\"");  
			if(pos != -1)  
				endPos = pos;  
		}while(pos == -1);  
		boundary = fileData.substring(startPos, endPos);   
		startPos = endPos;  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	 
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf("filename=\"", startPos); 
			if(pos != -1)  
				startPos = pos;  
		}while(pos == -1);					  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	  
			count+=1;
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf("Content-Type: ", startPos);  
			if(pos != -1)  
				endPos = pos;						  
		}while(pos == -1);  
		filename = fileData.substring(startPos + 10, endPos - 3);	
		strLocalFileName = filename;  
		int index = filename.lastIndexOf("\\");  
		if(index != -1)  
			filename = filename.substring(index + 1);  
		else  
			filename = filename;    
		fname1=filename;
		boolean blnNewlnFlag = false;  
		startPos = endPos;	//added length of "Content-Type: "  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	 
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;			  
			pos = fileData.indexOf("\n", startPos);  
			if(pos != -1)  
			{  
				if(blnNewlnFlag == true)  
					endPos = pos;					  
				else  
				{  
					blnNewlnFlag = true;  
					pos = -1;  
				}  
			}  
		}while(pos == -1);  
		contentType = fileData.substring(startPos + 14, endPos);   
		BOF = count + 1;  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	//read 1 byte at a time  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf(boundary, startPos);	//check for end of file data i.e boundry value			  
		}while(pos == -1);  
		EOF = count - boundary.length();  
		out.println("<br><br>0. Local File Name = " + strLocalFileName);  
		out.println("<br><br>1. filename = " + filename);  
		out.println("<br>2. contentType = " + contentType);  
		out.println("<br>3. startPos = " + BOF);  
		out.println("<br>4. endPos = " + EOF);  
		out.println("<br>5. boundary = " + boundary);   
		String appPath = application.getRealPath("/");  
		out.println("<br>appPath : " + appPath);  
		String destFolder = appPath + "image/";	//change this as required  
		filename= destFolder + id1+".jpg";  
		FileOutputStream fileOut = new FileOutputStream(filename);  
		fileOut.write(dataBytes, BOF, (EOF - BOF));  
		fileOut.flush();  
		fileOut.close();  
		out.println("<br>File saved as >> " + filename);		  
	}  
	else  
	{  
		out.println("Error in uploading ");  
	}  
 response.sendRedirect("yolo.jsp");    

	
     
%>  

