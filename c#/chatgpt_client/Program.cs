using System;
using System.IO;
using System.Net.Sockets;
using System.Threading;

class ChatClient
{
    static void Main(string[] args)
    {
        Console.Write("Server IP: ");
        string serverIp = Console.ReadLine()!;

        Console.Write("Jouw naam: ");
        string name = Console.ReadLine()!;

        TcpClient client = new TcpClient(serverIp, 5000);
        Console.WriteLine("Verbonden met server.");

        using StreamWriter writer = new(client.GetStream()) { AutoFlush = true };
        writer.WriteLine(name); // eerst de naam doorgeven

        Thread receiveThread = new Thread(ReceiveMessages);
        receiveThread.Start(client);

        while (true)
        {
            string? msg = Console.ReadLine();
            if (msg == null || msg.ToLower() == "/quit")
                break;

            writer.WriteLine(msg);
        }

        client.Close();
    }

    static void ReceiveMessages(object? obj)
    {
        TcpClient client = (TcpClient)obj!;
        using StreamReader reader = new(client.GetStream());

        try
        {
            string? msg;
            while ((msg = reader.ReadLine()) != null)
            {
                Console.WriteLine(msg);
            }
        }
        catch
        {
            Console.WriteLine("Verbinding met server verbroken.");
        }
    }
}
