# frozen_string_literal: true

# Documentation de la classe RiceCooker
class RiceCooker
  def initialize(max_capacity)
    @max_capacity = max_capacity
    @current_capacity = 0
    @is_working = true
  end

  def add_items(items)
    total_quantity = 0
    items.each do |item, quantity, unit|
      converted_quantity = convert_to_liters(quantity, unit)
      raise 'Capacité maximale dépassée' if capacity_exceeded?(converted_quantity)

      update_capacities(converted_quantity)
      total_quantity += converted_quantity
      puts "Ajout de #{quantity} #{unit} de #{item}"
    end

    puts "Total ajouté : #{total_quantity} litres"
  end

  def cook(cooking_time)
    raise 'Le rice cooker doit être réparé' unless @is_working

    puts "La cuisson démarre pour #{cooking_time} minutes..."
    simulate_cooking(cooking_time)

    puts 'La cuisson est terminée'
    true
  rescue StandardError => e
    puts "Erreur pendant la cuisson : #{e}"
    # Log d'erreur pour la maintenance
  end

  def check_status
    @is_working = true # Simulation : le rice cooker est toujours fonctionnel
  end

  private

  def convert_to_liters(quantity, unit)
    case unit.downcase
    when 'l' then quantity
    when 'kg' then quantity * 1.2
    else raise 'Unité non prise en charge'
    end
  end

  def capacity_exceeded?(converted_quantity)
    @current_capacity + converted_quantity > @max_capacity
  end

  def update_capacities(converted_quantity)
    @current_capacity += converted_quantity
  end

  def simulate_cooking(cooking_time)
    sleep(cooking_time * 60) # Temps de cuisson en secondes (simulé)
  end
end

def run_rice_cooker
  rice_cooker = RiceCooker.new(10)

  items_to_cook = gather_items_to_cook
  rice_cooker.add_items(items_to_cook)

  cooking_time = get_cooking_time
  is_done = rice_cooker.cook(cooking_time)

  rice_cooker.check_status if is_done
  puts 'La cuisson est terminée.'
end

def gather_items_to_cook
  items_to_cook = []
  print 'Combien d\'aliments voulez-vous cuire ? '
  num_items = gets.chomp.to_i

  num_items.times do |i|
    print "Aliment #{i + 1} : "
    item = gets.chomp

    print "Quantité de #{item} : "
    quantity = gets.chomp.to_f

    print "Unité de #{item} (L pour litres / kg pour kilogrammes) : "
    unit = gets.chomp

    items_to_cook << [item, quantity, unit]
  end

  items_to_cook
end

def get_cooking_time
  print 'Combien de temps de cuisson en minutes ? '
  gets.chomp.to_f
end

run_rice_cooker
