using System;
using System.Collections.Generic;
using System.Threading;

class RiceCooker
{
    private double maxCapacity;
    private double currentCapacity = 0;
    private bool isWorking = true;

    public RiceCooker(double maxCapacity)
    {
        this.maxCapacity = maxCapacity;
    }

    public void AddItems(List<Tuple<string, double, string>> items)
    {
        double totalQuantity = 0;
        foreach (var item in items)
        {
            var quantity = item.Item2;
            var unit = item.Item3;
            var convertedQuantity = ConvertToLiters(quantity, unit);

            if (currentCapacity + convertedQuantity > maxCapacity)
            {
                throw new ArgumentException("Capacité maximale dépassée");
            }

            currentCapacity += convertedQuantity;
            totalQuantity += convertedQuantity;
            Console.WriteLine($"Ajout de {quantity} {unit} de {item.Item1}");
        }

        Console.WriteLine($"Total ajouté : {totalQuantity} litres");
    }

    public void Cook(double cookingTime)
    {
        if (!isWorking)
        {
            throw new InvalidOperationException("Le rice cooker doit être réparé");
        }

        Console.WriteLine($"La cuisson démarre pour {cookingTime} minutes...");
        Thread.Sleep((int)(cookingTime * 60 * 1000)); // Temps de cuisson en millisecondes (simulé)

        Console.WriteLine("La cuisson est terminée");
    }

    public void CheckStatus()
    {
        isWorking = true; // Simulation : le rice cooker est toujours fonctionnel
    }

    private double ConvertToLiters(double quantity, string unit)
    {
        switch (unit.ToLower())
        {
            case "l":
                return quantity;
            case "kg":
                return quantity * 1.2;
            default:
                throw new ArgumentException("Unité non prise en charge");
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        RunRiceCooker();
    }

    static void RunRiceCooker()
    {
        var riceCooker = new RiceCooker(10);

        var itemsToCook = GatherItemsToCook();
        riceCooker.AddItems(itemsToCook);

        var cookingTime = GetCookingTime();
        riceCooker.Cook(cookingTime);

        if (true)
        {
            riceCooker.CheckStatus(); // Ajoutez la méthode CheckStatus si nécessaire
            Console.WriteLine("La cuisson est terminée.");
        }
    }

    static List<Tuple<string, double, string>> GatherItemsToCook()
    {
        Console.WriteLine("Combien d'aliments voulez-vous cuire ? ");
        var numItems = int.Parse(Console.ReadLine());
        var itemsToCook = new List<Tuple<string, double, string>>();

        for (int i = 1; i <= numItems; i++)
        {
            Console.Write($"Aliment {i} : ");
            var item = Console.ReadLine();

            Console.Write($"Quantité de {item} : ");
            var quantity = double.Parse(Console.ReadLine());

            Console.Write($"Unité de {item} (L pour litres / kg pour kilogrammes) : ");
            var unit = Console.ReadLine();

            itemsToCook.Add(Tuple.Create(item, quantity, unit));
        }

        return itemsToCook;
    }

    static double GetCookingTime()
    {
        Console.Write("Combien de temps de cuisson en minutes ? ");
        return double.Parse(Console.ReadLine());
    }
}
