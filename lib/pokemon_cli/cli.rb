# frozen_string_literal: true

class Cli
  def run
    print_welcome
    Api.get_pokemon
    main
  end

  def main
    loading
    print_all
    print_selection_prompt
    id = valid_id?(prompt_selection)
    updated_pokemon = get_pokemon_details(id)
    print_details(updated_pokemon)
    print_continue
    continue?(prompt_selection)
  end

  def print_all
    Pokemon.all.each { |p| puts "#{p.id}.) #{p.name}" }
  end

  def print_selection_prompt
    puts 'Please select a Pokemon by number for more information!'
  end

  def print_error
    puts 'Invalid Selection, please try again.'
  end

  def print_details(pokemon)
    puts "Name: #{pokemon.name}"
    puts "Attk: #{pokemon.attack}"
    puts "hp: #{pokemon.hp}"
    puts "def: #{pokemon.defense}"
  end

  def print_continue
    puts 'Would you like to continue? (y/n)'
  end

  def print_welcome
    puts Rainbow('Welcome to Poke CLI!').red.italic.blink
  end

  def print_goodbye
    puts 'BYE!!!!!!!!'
  end

  def prompt_selection
    gets.chomp
  end

  def valid_id?(id)
    id = id.to_i
    if id < 1 || id > Pokemon.all.size
      print_error
      sleep 1
      main
    end
    id
  end

  def continue?(choice)
    if choice == 'y'
      main
    else
      print_goodbye
      exit
    end
  end

  def get_pokemon_details(id)
    selected_pokemon = Pokemon.find_by_id(id)
    Api.get_details_by_id(id) unless selected_pokemon.has_details?
    selected_pokemon
  end

  def loading
    spinner = Enumerator.new do |e|
      loop do
        e.yield '|'
        e.yield '/'
        e.yield '-'
        e.yield '\\'
      end
    end

    1.upto(25) do |_i|
      printf("\rFetching them all... %s", spinner.next)
      sleep(0.1)
    end
  end
end
