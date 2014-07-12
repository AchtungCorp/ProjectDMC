module main;

import std.stdio, std.socket,
	core.thread;

enum VERSION = "1.0.0.0";

void main(string[] args)
{
	Socket server = new TcpSocket();
		server.setOption(SocketOptionLevel.SOCKET,
	                 SocketOption.REUSEADDR,
	                 true);
	server.bind(new InternetAddress(8080));
	server.listen(1);

	writefln("Server version is %s", VERSION);

	while( true ) // client-authorization loop handler
	{
		Socket attempt = server.accept();
		
		char[1024] buffer;
		auto recieved = attempt.receive(buffer);

		writefln("client data\n%s ", buffer[0..recieved]);

		attempt.send("bitch");

		attempt.shutdown(SocketShutdown.BOTH);

		attempt.close();
	}	
}
