class CaesarController < ApplicationController
  def index

  end

  def encode
    @caesar = Caesar.new
    @original_text = params[:caesar][:to_encode] if params[:caesar].present?

    if @original_text.present?
      @caesar.to_encode = @original_text
      @caesar.number = params[:caesar][:number]
      @caesar.to_decode = perform_encoding(@original_text, @caesar.number)
      @encoded_text = @caesar.to_decode
      puts @encoded_text
      render :encode
    end

  end

  def decode

  end

  private

  def perform_encoding(text, number)
    alphabet = ('a'..'z').to_a

    words = text.split(' ')
    encoded_text = ""

    words.each_with_index do |word, index|
        encoded_word = ""
        word.each_char do |char|
          if alphabet.include?(char)
              i = alphabet.index(char)
              j = (alphabet.length + i + number) % alphabet.length
              letter = alphabet[j]
              encoded_word << letter
          else
              encoded_word << char
          end
        end
        encoded_text << encoded_word
        encoded_text << ' '
    end

   @encoded_text = encoded_text
  end

end
