# frozen_string_literal: true

class Api
  BASE_URL = 'https://swapi.dev/api/'

  def self.get_pokemon
    res = RestClient.get(BASE_URL + 'films')
    data = JSON.parse(res.body)
    binding.pry

    data['results'].each do |pokemon|
      poke_data = {
        name: pokemon['name'],
        id: pokemon['url'].split('/')[-1]
      }
      Pokemon.new(poke_data)
    end
  end

  def self.get_details(poke)
    puts 'getting details!!'
    res = RestClient.get("#{BASE_URL}#{poke.id}")
    data = JSON.parse(res.body)
    hp = data['stats'][-1]['base_stat']
    attack = data['stats'][-2]['base_stat']
    defense = data['stats'][-3]['base_stat']
    poke.update(hp, attack, defense)
    poke
  end
end
