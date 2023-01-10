a. My Full Name:  Jiangnan Cai
b. My Student ID: 2546890770
c. What I have done in the assignment:
	1. Built the TCP and UDP code, and the connections between the client and the Main server as well as between the Main server and the Backend servers.  
	2. Using filestream functions to extract the information from the txt file.
	3. Programming the ID authentication process and the Query process, and the encrypt string function.
	4. Applying the multiple threads to keep the TCP consistent while the Main server communicates with the Backend servers at the same time over UDP.
 	5. Using C++2011 version so that I can use head file "pthread".
	6. Create the Makefile to build the cpp files at the same time.
d. My code files are: 
	client.cpp \  serverM.cpp \ serverC.cpp \ serverCS.cpp \ serverEE.cpp \ Makefile
	
	client.cpp:
		1. Send TCP connect request to the Main server.
		2. Enter the username and corresponding passwords and make sure all the characters in the username  are all lower case.
		3. Check if the username and the passwords fit the condition that length should be 5 - 50 characters
		4. Counting wrong entering of the username and the passwords, if counted to 3 then the client program will turn off.
		5. Send the username and the passwords to the Main server.
		6. Received the feedback from the Main server.
		7. Inform the client to enter query, includes coursecode, and its category, and send them to the Main server.
		8. Using the getsockname function to get the dynamical port number which is assigned by operating system for the client.
	serverM.cpp:
		1. Accept TCP connect request from the client, and receive the information sent from the client.
		2. Encrypt the username and the passwords received from the client then send them to the serverC.
		3. Send the query received from the client then send them to the serverEE or serverCS.
		4. Receive the results of the ID authentication and query from the serverC and the serverEE or serverCS.
		5. Communicates with the Backend servers over UDP.
	serverC.cpp:
		1. Extract the ID information from the cred.txt.
		2. Split the string read from the cred.txt and store them into a table with the strcture like "username -> passwords".
		3. Compare the ID received from the Main server with the data in cred.txt, and then send the comparison results to the Main server.
	serverEE.cpp:
		1. Extract the EE department course information from the ee.txt.
		2. Split the string read from the ee.txt and store them into a table in with the strcture like "coursecode -> {Credit, Professor, Days, CourseName}".
		3. Deal with the query received from the Main server and send the query results to the Main server.
	serverCS.cpp:
		1. Extract the CS department course information from the cs.txt.
		2. Split the string read from the cs.txt and store them into a table in with the strcture like "coursecode -> {Credit, Professor, Days, CourseName}".
		3. Deal with the query received from the Main server and send the query results to the Main server.
	Makefile:
		1. Complies all the files and creates executables.
e. The format of all the message exchanged:
	The ID Authentication Phase:
		the client send ID to the Main server : "<username>,<password>".
		the Main server send ID to the serverC: "<encrpyt_username>,<encrpyt_password>".
		the serverC send the ID Authentication results to the Main server: 
				"ID Pass" - if authenticated successfully, 
				"Username Does Not Exist" - if username doesn't exist, 
				"Password Does Not Match" - if password doesn't match
		the Main server send the ID Authentication results to the client:
				"ID Pass" - if authenticated successfully.
				"Username Does Not Exist" - if username doesn't exist.
				"Password Does Not Match" - if password doesn't match.
	The Query Phase:
		the client send query to the Main server: "<coursecode>,<category>".
		the Main server send query to the serverEE or serverCS: "<coursecode>,<category>".
		the serverEE send query results to the Main server: 
				"Didn't find the course: <coursecode>" - if coursecode cann't found.
				"Didn't find the category: <category>" - if category cann't found.
				"The <category> of <coursecode> is <information>E" 
					- if coursecode and category are both found, and the last "E" is for the Main server to recognize that the results came from serverEE.
		the serverCS send query results to the Main server:
				"Didn't find the course: <coursecode>" - if coursecode cann't found.
				"Didn't find the category: <category>" - if category cann't found.
				"The <category> of <coursecode> is <information>C" 
					- if coursecode and category are both found, and the last "E" is for the Main server to recognize that the results came from serverCS.
		the Main server send query results to the client:
				"Didn't find the course: <coursecode>" - if coursecode cann't found.
				"Didn't find the category: <category>" - if category cann't found.
				"The <category> of <coursecode> is <information>" - if coursecode and category are both found.	

f. Code cite:
	1. "readTxt" function in serverC.cpp, serverEE.cpp, serverCS.cpp
		The function for reading the information from txt files.
		cite from the internet: "https://blog.csdn.net/qq_44894692/article/details/103618356?ops_request_misc=%257B%2522request%255Fid%2522%253
				A%2522166927486216800184125061%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=166927486216800184125061&biz_id=
				0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-103618356-null-null.142^v66^control,201^v3^control,213^v2^t3_esquery_v
				1&utm_term=c%2B%2B%20%E6%96%87%E4%BB%B6%E8%AF%BB%E5%8F%96&spm=1018.2226.3001.4187"
		source code:
				int main（）
				{
					ifstream infile;
					infile.open("qqzl.txt", ios::in);
					if (!infile.is_open())
					{
						cout << "读取文件失败" << endl;
						return;
					}
					string buf;
					while (getline(infile,buf))
					{
						cout << buf << endl;
					}
				}
	