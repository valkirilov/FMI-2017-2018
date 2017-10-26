
import java.io.*;
import java.net.*;
import java.util.*;

public class TCPEmailClient
{
	private static InetAddress host;
	private static final int PORT = 1234;
	private static String name;
	private static Scanner networkInput, userEntry;
	private static PrintWriter networkOutput;

	public static void main(String[] args) throws IOException
	{
		try
		{
			host = InetAddress.getLocalHost();
		}
		catch(UnknownHostException uhEx)
		{
			System.out.println("Host ID not found!");
			System.exit(1);
		}

		userEntry = new Scanner(System.in);

		do
		{
			System.out.print("\nEnter name ('Dave' or 'Karen'): ");
			name = userEntry.nextLine();
		}while (!name.equals("Dave") && !name.equals("Karen"));

		talkToServer();
		
	}


	private static void talkToServer() throws IOException
	{
        /********************************************/
        /* Here should go your code for the request */
        /********************************************/
	    
	    do
		{
	    	System.out.println("\nWrite: (w); Read: (r); Quit: (q)");
	    	System.out.print("\nChoose an action (w/r/q): ");
			String action = userEntry.nextLine();
	    	
			if (action.equals("w")) {
				doSend();
			}
			else if (action.equals("r")) {
				doRead();
			}
			else if (action.equals("q")) {
				return;
			}
			else {
				System.out.println("\nError: Action not available!");
			}
			
		} while (true);
	}


	private static void doSend() throws IOException
	{
		Socket clientSocket = new Socket(host, PORT);
	    networkInput = new Scanner(clientSocket.getInputStream());
	    networkOutput = new PrintWriter(clientSocket.getOutputStream(), true);
		
		System.out.println("\nEnter 1-line message: ");
		String message = userEntry.nextLine();
		networkOutput.println(name);
		networkOutput.println("send");
		networkOutput.println(message);
		
		clientSocket.close();
	}


	private static void doRead() throws IOException
	{
        /*********************************************/
        /* Here should go your code for the response */
        /*********************************************/
		
		Socket clientSocket = new Socket(host, PORT);
	    networkInput = new Scanner(clientSocket.getInputStream());
	    networkOutput = new PrintWriter(clientSocket.getOutputStream(), true);
	
		System.out.print("Reading ");
		
		networkOutput.println(name);
		networkOutput.println("read");
		
		String messagesCount = networkInput.nextLine();
		System.out.println(messagesCount + " messages");
		
		for (int i=0; i<Integer.parseInt(messagesCount); i++) {
			String message = networkInput.nextLine();
			System.out.println(message);
		}
		
		clientSocket.close();
	}
}