# frozen_string_literal: true

class Pokemon
  attr_reader :name, :id
  attr_accessor :attack, :hp, :defense
  @@all = []
  def initialize(hash)
    @name = hash[:name]
    @id = hash[:id].to_i
    @@all << self
  end

  def self.find_by_id(id)
    all.find do |poke|
      poke.id == id
    end
  end

  def self.all
    @@all
  end

  def update(hp, attack, defense)
    self.hp = hp
    self.attack = attack
    self.defense = defense
  end

  def has_details?
    hp && attack && defense
  end
end
