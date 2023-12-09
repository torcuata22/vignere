class Playfair < ApplicationRecord
  belongs_to :user

  def generate_playfair_table(key)
    alphabet = ('A'..'Z').to_a
    key = key.upcase.gsub('J', 'I').delete(' ')
    key = key.chars.uniq + (alphabet - key.chars).uniq
    key.each_slice(5).to_a
  end


end
