# frozen_string_literal: true

class Pokemon
  attr_reader :name, :id
  attr_accessor :attack, :hp, :defense
  @@all = []
  def initialize(name, id)
    @name = name
    @id = id
    @@all << self
  end

  def self.find_by_id(id)
    index = id.to_i - 1
    all[index]
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
