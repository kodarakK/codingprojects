using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Threading;

class ChatServer
{
    private static TcpListener? listener;
    private static readonly Dictionary<TcpClient, string> clients = new();

    static void Main(string[] args)
    {
        listener = new TcpListener(IPAddress.Any, 5000);
        listener.Start();
        Console.WriteLine("Server gestart op poort 5000...");

        while (true)
        {
            TcpClient client = listener.AcceptTcpClient();
            Thread t = new Thread(HandleClient);
            t.Start(client);
        }
    }

    private static void HandleClient(object? obj)
    {
        TcpClient client = (TcpClient)obj!;
        string? clientName = null;

        try
        {
            using StreamReader reader = new(client.GetStream());
            using StreamWriter writer = new(client.GetStream()) { AutoFlush = true };

            // Eerste regel = naam
            clientName = reader.ReadLine();
            if (string.IsNullOrWhiteSpace(clientName))
            {
                client.Close();
                return;
            }

            lock (clients)
            {
                clients[client] = clientName;
            }

            Console.WriteLine($"{clientName} verbonden.");
            Broadcast($"➡️ {clientName} heeft de chat betreden.", client);

            string? msg;
            while ((msg = reader.ReadLine()) != null)
            {
                Console.WriteLine($"{clientName}: {msg}");
                Broadcast($"{clientName}: {msg}", client);
            }
        }
        catch
        {
            Console.WriteLine($"{clientName} disconnected.");
        }
        finally
        {
            if (clientName != null)
            {
                lock (clients)
                {
                    clients.Remove(client);
                }
                Broadcast($"⬅️ {clientName} heeft de chat verlaten.", client);
            }
            client.Close();
        }
    }

    private static void Broadcast(string message, TcpClient exclude)
    {
        lock (clients)
        {
            foreach (var kv in clients)
            {
                var c = kv.Key;
                if (c != exclude)
                {
                    try
                    {
                        StreamWriter writer = new(c.GetStream()) { AutoFlush = true };
                        writer.WriteLine(message);
                    }
                    catch { }
                }
            }
        }
    }
}
