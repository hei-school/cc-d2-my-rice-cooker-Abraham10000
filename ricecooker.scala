import scala.io.StdIn.readLine
import scala.concurrent.duration._

class RiceCooker(private var maxCapacity: Double) {
  private var currentCapacity: Double = 0
  private var isWorking: Boolean = true

  def addItems(items: List[(String, Double, String)]): Unit = {
    var totalQuantity: Double = 0
    items.foreach { case (item, quantity, unit) =>
      val convertedQuantity = convertToLiters(quantity, unit)
      if (currentCapacity + convertedQuantity > maxCapacity) {
        throw new IllegalArgumentException("Capacité maximale dépassée")
      }
      currentCapacity += convertedQuantity
      totalQuantity += convertedQuantity
      println(s"Ajout de $quantity $unit de $item")
    }
    println(s"Total ajouté : $totalQuantity litres")
  }

  def cook(cookingTime: Double): Unit = {
    if (!isWorking) {
      throw new IllegalStateException("Le rice cooker doit être réparé")
    }
    println(s"La cuisson démarre pour $cookingTime minutes...")
    Thread.sleep((cookingTime * 60 * 1000).toLong) // Temps de cuisson en millisecondes (simulé)
    println("La cuisson est terminée")
  }

  def checkStatus(): Unit = {
    isWorking = true // Simulation : le rice cooker est toujours fonctionnel
  }

  private def convertToLiters(quantity: Double, unit: String): Double = unit.toLowerCase match {
    case "l" => quantity
    case "kg" => quantity * 1.2
    case _ => throw new IllegalArgumentException("Unité non prise en charge")
  }
}

object Main extends App {
  def runRiceCooker(): Unit = {
    val riceCooker = new RiceCooker(10)

    val itemsToCook = gatherItemsToCook()
    riceCooker.addItems(itemsToCook)

    val cookingTime = getCookingTime()
    riceCooker.cook(cookingTime)

    if (true) {
      riceCooker.checkStatus() // Ajoutez la méthode checkStatus si nécessaire
      println("La cuisson est terminée.")
    }
  }

  def gatherItemsToCook(): List[(String, Double, String)] = {
    println("Combien d'aliments voulez-vous cuire ? ")
    val numItems = readLine().toInt
    (1 to numItems).map { i =>
      print(s"Aliment $i : ")
      val item = readLine()

      print(s"Quantité de $item : ")
      val quantity = readLine().toDouble

      print(s"Unité de $item (L pour litres / kg pour kilogrammes) : ")
      val unit = readLine()
      (item, quantity, unit)
    }.toList
  }

  def getCookingTime(): Double = {
    print("Combien de temps de cuisson en minutes ? ")
    readLine().toDouble
  }

  runRiceCooker()
}
