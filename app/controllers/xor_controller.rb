class XorController < ApplicationController

  def index
  end

  def encode
    @xor = Xor.new
    @original_text = params[:xor][:to_encode] if params[:xor].present?

    if @original_text.present?
      @xor.to_encode = @original_text
      @xor.key = params[:xor][:key]
      @xor.to_decode = perform_encoding(@original_text, @xor.key)
      @encoded_text = @xor.to_decode
      puts @encoded_text
      render :encode
    end
    puts "Original Text: #{@original_text}"
    puts "Key: #{@xor.key}"
    puts "Encoded Text: #{@encoded_text}"

    @encoded_text
  end

  def decode

  end

  private

  def perform_encoding(original_text, key)
    key = key * (original_text.length / key.length) + key[0, original_text.length % key.length]
    encoded_text = ""

    original_text.each_char do |char|
      char_binary = char.ord.to_s(2).rjust(8,'0')
      puts "char_binary: #{char_binary}"

      key_char = key[0]
      key = key[1..-1] + key_char
      key_binary = key_char.ord.to_s(2).rjust(8,'0')
      puts "key_binary: #{key_binary}"

      encoded_char_binary = char_binary.chars.zip(key_binary.chars).map { |a, b| (a.to_i ^ b.to_i).to_s }.join
      puts "encoded_char_binary: #{encoded_char_binary}"

      encoded_char = encoded_char_binary.to_i(2).chr
      encoded_text += encoded_char
    end

    encoded_text
  end


  def perform_decoding()

  end

end
