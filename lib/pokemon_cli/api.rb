# frozen_string_literal: true

class Api
  BASE_URL = 'https://pokeapi.co/api/v2/pokemon/'

  def self.get_pokemon
    res = RestClient.get(BASE_URL)
    data = JSON.parse(res.body)

    data['results'].each do |pokemon|
      name = pokemon['name']
      id = pokemon['url'].split('/')[-1]

      Pokemon.new(name, id)
    end
  end

  def self.get_details_by_id(id)
    puts 'getting details!!'
    selected_pokemon = Pokemon.find_by_id(id)
    res = RestClient.get("#{BASE_URL}#{id}")
    data = JSON.parse(res.body)

    hp = data['stats'][-1]['base_stat']
    attack = data['stats'][-2]['base_stat']
    defense = data['stats'][-3]['base_stat']
    selected_pokemon.update(hp, attack, defense)
    selected_pokemon
  end

  MOVIE_URL = 'https://api.themoviedb.org/3/discover/movie?api_key='
  KEY = ENV['API_KEY']

  def self.get_movies(year)
    res = RestClient.get("#{MOVIE_URL}#{KEY}&year=#{year}&vote_average.gte=9")
    data = JSON.parse(res.body)

    data['results'].each do |movie|
      Movie.new(movie['title'])
    end
  end
end
