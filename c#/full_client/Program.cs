// See https://aka.ms/new-console-template for more information
using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using Microsoft.VisualBasic;

namespace full_client
{
    class full_client
    {
        static List<Socket> clients = new List<Socket>();

        public static void Main()
        {
            int port = 13000;
            string ip_adress = "127.0.0.1";
            Socket server_listener = new Socket(
                AddressFamily.InterNetwork,
                SocketType.Stream,
                ProtocolType.Tcp
            );
            IPEndPoint ep = new IPEndPoint(IPAddress.Parse(ip_adress), port);

            server_listener.Bind(ep);
            server_listener.Listen(100);
            Console.WriteLine("server is listening");
            Socket ClientSocket = default(Socket);
            int counter = 0;
            full_client fc = new full_client();
            while (true)
            {
                counter++;
                ClientSocket = server_listener.Accept();
                clients.Add(ClientSocket);
                Console.WriteLine(counter + "Clients connected");
                Thread UserThread = new Thread(new ThreadStart(() => fc.User(ClientSocket)));
            }
        }

        public void User(Socket client)
        {
            while (true)
            {
                byte[] msg = new byte[2 * 1024];
                int size = client.Receive(msg);
                foreach (Socket c in clients)
                    c.Send(msg, 0, size, SocketFlags.None);
            }
        }
    }
}
