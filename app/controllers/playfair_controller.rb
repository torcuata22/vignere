class PlayfairController < ApplicationController

  def index

  end

  def encode
    @playfair = Playfair.new
    @playfair.to_encode = params[:playfair][:to_encode] if params[:playfair].present?

    if @playfair.to_encode.present?
      @original_text = @playfair.to_encode
      puts "Original text: #{@original_text}"
      @playfair.key = params[:playfair][:key]
      puts "Key: #{@playfair.key}"
      table = @playfair.generate_playfair_table(@playfair.key)
      puts "Table: #{table}"

      @encrypted_text = encrypt(@playfair.to_encode, @playfair.key, table)
    end

    render :encode
  end







  def decode

  end

  private

  def encrypt(message, key, table)
    message_chars = message.upcase.gsub('J', 'I').delete(' ')
    message_chars << 'X' if message_chars.length.odd?
    message_chars = message_chars.chars

    encrypted_pairs = []

    message_chars.each_slice(2) do |pair|
      pos1 = table.flatten.index(pair[0])
      pos2 = table.flatten.index(pair[1])

      puts "Pair: #{pair}, Pos1: #{pos1.inspect}, Pos2: #{pos2.inspect}"
      puts "Table: #{table.inspect}"

      # Ensure pos1 and pos2 are not nil before performing calculations
      if pos1 && pos2
        encrypted_pair = if pos1 / 5 == pos2 / 5
                           "#{table[(pos1 / 5) * 5 + (pos1 + 1) % 5]}#{table[(pos2 / 5) * 5 + (pos2 + 1) % 5]}"
                         elsif pos1 % 5 == pos2 % 5
                           "#{table[((pos1 + 5) % 25)]}#{table[((pos2 + 5) % 25)]}"
                         else
                           "#{table[pos1 / 5 * 5 + pos2 % 5]}#{table[pos2 / 5 * 5 + pos1 % 5]}"
                         end

        encrypted_pairs << encrypted_pair
        puts "Encrypted pair: #{encrypted_pair}"
      elsif pair[1] == 'X'
        # If the second character in the pair is 'X', handle it separately
        encrypted_pairs << "#{table[(pos1 / 5) * 5 + (pos1 + 1) % 5]}X"
      else
        # Handle the case where pos2 is nil (e.g., if pair[1] is not found in the table)
        puts "Error: pos1 or pos2 is nil for pair #{pair}"
      end
    end

    encrypted_pairs.join
  end









end
