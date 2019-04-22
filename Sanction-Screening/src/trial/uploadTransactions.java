package trial;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class uploadTransactions {
	
		  FileReader fr=null;
		  BufferedReader br=null;
		 FileReader fr1=null;
		  BufferedReader br1=null;
		  String query;
		  PreparedStatement pstmt;
		
		public  void openFile(String fileName) throws Exception // opening file, performing validations and screening , and adding to database
		{
		
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				//Class.forName("com.mysql.cj.jdbc.Driver");  
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vedika","root","root@123");  
				String transaction,name;
				//fr=new FileReader("E:/Trail project/src/trial/FileTTS1.txt");//transactions file
				fr=new FileReader(fileName);
				br=new BufferedReader(fr);
				
				fr1=new FileReader("E:/Trail project/src/trial/Defaulters.txt");//list of keywords
				br1=new BufferedReader(fr1);
				List<String> keywords=new ArrayList<String>();
				int validatePass=0,screenPass=0;
				
				while((name=br1.readLine())!=null) //getting all defaulter's names in a list
				{
					keywords.add(name);
				}
				
				while((transaction=br.readLine())!=null) //reading transaction line, splitting and saving values in attr
				{
					String[] attr;
					attr=transaction.split(" ");
					System.out.println(transaction);
					int dt=Integer.parseInt((attr[1].substring(0,2)));//getting date
					int mon=Integer.parseInt(attr[1].substring(2,4));//getting month
					int year=Integer.parseInt(attr[1].substring(4, 8));//getting year 
					LocalDate localDate = LocalDate.of(year, mon, dt);//converting input date to LocalDate format
					Date date=Date.valueOf(localDate);
					if(validate(attr)==0)//if validations are false
					{
						validatePass=0;
						screenPass=0;
					}
					else if(validate(attr)==1)//if validation is true, check for sanctioning 
					{
						validatePass=1;
						screenPass=sanction(attr,keywords);
					}
			        
					query="insert into transactions values(?,?,?,?,?,?,?,?,?);";//insert query
					pstmt=con.prepareStatement(query);
					pstmt.setString(1, attr[0]);
					pstmt.setDate(2, date);
					pstmt.setString(3, attr[2]);
					pstmt.setString(4, attr[3]);
					pstmt.setString(5, attr[4]);
					pstmt.setString(6, attr[5]);
					pstmt.setDouble(7, Double.parseDouble(attr[6]));//converting amount to double before storing
					if(validatePass==0)
						pstmt.setString(8, "Fail");
					if(validatePass==1)
						pstmt.setString(8, "Pass");
					if(screenPass==0)
						pstmt.setString(9, "Fail");
					if(screenPass==1)
						pstmt.setString(9, "Pass");
					pstmt.executeUpdate();
					
				}
				System.out.println("Transactions added in database ");
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		
		public  int validate(String attr[]) throws Exception//checking for validations
		{
			int flag=-1;// set to 1 if validate and 0 if not validate
			if(attr.length!=7) //checking for number of fields in record
			{
				System.out.println(" Validate Fail");
				flag=0;
			}
			else
			{
				if(attr[0].length()==12 && validateDate(attr[1])==1 && attr[2].length()<=35 && attr[3].length()==12 && attr[4].length()<=35 && attr[5].length()==12 && validateAmount(attr[6])==2)// if all validations are true, then validationPass is true
				{
					System.out.println(" Validate Pass");
					flag=1;
				}
				else//validation is false
				{
					System.out.println(" Validate Fail");
					flag=0;
				}
					
			}
			return flag;
		}
		
		
		public int validateDate(String date) throws Exception//validating if input date is equal to system date
		{
			int flag=0;
			int dt=Integer.parseInt((date.substring(0,2)));//getting date
			int mon=Integer.parseInt(date.substring(2,4));//getting month
			int year=Integer.parseInt(date.substring(4, 8));//getting year
			LocalDate localDate = LocalDate.of(year, mon, dt);//converting to localDate format
			LocalDate localDate1=LocalDate.now();//getting system date
			if(localDate.isEqual(localDate1))//checking if input and system date is equal
				flag=1;
			else flag=0;
			return flag;
		}
		
		
		public  int validateAmount(String amt)//validating amount
		{
			int flag=0;
			int index=amt.indexOf('.');
			int len=amt.substring(index,amt.length()).length()-1;//getting digits after decimal point
			return len;
		}
		
		
		public  int sanction(String attr[],List<String> keywords)
		{
			int flag=0;
			if(keywords.contains(attr[2])==true || keywords.contains(attr[4])==true) // if name present in defaulters, then fail
			{
				System.out.println("Screen Fail");
				flag=0;
			}
			else 
			{
				System.out.println("Screen Pass");
				flag=1;
			}
			return flag;
		}
		

	
}
