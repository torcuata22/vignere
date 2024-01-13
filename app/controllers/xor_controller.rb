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
    @xor = Xor.new
    @encoded_text = params.dig(:xor, :to_decode)
    key = params.dig(:xor, :key)

    if @encoded_text.present?
      @xor.to_decode = perform_decoding(@encoded_text, key)
      @decoded_text = @xor.to_decode
      flash[:success] = 'Text decoded successfully!'
      puts "Received encoded text: #{@encoded_text}"
      puts "Received key: #{key}"
      puts "Decoded text: #{@decoded_text}" # Add this line
      render :decode
    else
      render :decode
    end
  end

  private

  def perform_encoding(original_text, key)
    key = key * (original_text.length / key.length) + key[0, original_text.length % key.length]
    encoded_text = ""

    original_text.each_char.with_index do |char, index|
      char_binary = char.ord.to_s(2).rjust(8,'0')
      key_char = key[index]
      key_binary = key_char.ord.to_s(2).rjust(8,'0')

      encoded_char_binary = char_binary.chars.zip(key_binary.chars).map { |a, b| (a.to_i ^ b.to_i).to_s }.join
      encoded_char = encoded_char_binary.to_i(2).chr
      encoded_text += encoded_char
    end

    encoded_text
  end


  def perform_decoding(encoded_text, key)
    # key = key * (encoded_text.length / key.length) + key[0, encoded_text.length % key.length]
    key = key * (encoded_text.length / key.length + 1)
    puts "Received encoded text: #{encoded_text}"
    puts "Received key: #{key}"

    decoded_text = ""

    encoded_text.each_char.with_index do |char, index|
      next if char == ' '
      char_binary = char.ord.to_s(2).rjust(8,'0')
      key_char = key[index]
      key_binary = key_char.ord.to_s(2).rjust(8, '0')

      puts "char: #{char}"
      puts "char_binary: #{char_binary}"
      puts "key_char: #{key_char}"
      puts "key_binary: #{key_binary}"

      decoded_char_binary = char_binary.chars.zip(key_binary.chars).map { |a, b| (a.to_i ^ b.to_i).to_s }.join
      puts "decoded_char_binary: #{decoded_char_binary}"

      decoded_char = decoded_char_binary.to_i(2).chr
      puts "decoded_char: #{decoded_char}"

      decoded_text += decoded_char
    end

    puts "Decoded text: #{decoded_text}"
    decoded_text
  end




end
