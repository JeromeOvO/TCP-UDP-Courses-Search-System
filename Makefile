make all:
	g++ -std=c++11 client.cpp -o client -lpthread
	g++ -std=c++11 serverM.cpp -o serverM -lpthread
	g++ -std=c++11 serverC.cpp -o serverC -lpthread
	g++ -std=c++11 serverEE.cpp -o serverEE -lpthread
	g++ -std=c++11 serverCS.cpp -o serverCS -lpthread