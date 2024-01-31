class XorController < ApplicationController

  def index
  end

  def encode
    @xor = Xor.new
    @original_text = params[:xor][:to_encode] if params[:xor].present?

    if @original_text.present?
      @xor.to_encode = @original_text
      @xor.key = params[:xor][:key]

      if valid_key?(@xor.key, @original_text)
        @xor.to_decode = encode_decode(@original_text, @xor.key)
        @encoded_text = @xor.to_decode
        puts @encoded_text
        save_message('encoded')
        render :encode
      else
        flash.now[:alert] = "Invalid key. Please choose a letter not in the text you want to encode, and make sure there are no spaces before or after the letter"
      end
    end
    @encoded_text
  end


  def decode
    @xor = Xor.new
    @encoded_text = params.dig(:xor, :to_decode)
    @xor.key = params[:xor][:key] if params[:xor].present?

    if @encoded_text.present?
      @xor.to_decode = encode_decode(@encoded_text, @xor.key)
      @decoded_text = @xor.to_decode
      flash[:success] = 'Text decoded successfully!'
      puts "Received encoded text: #{@encoded_text}"
      puts "Received key: #{@xor.key}"
      puts "Decoded text: #{@decoded_text}" # Add this line
      render :decode
    else
      save_message('decoded') if @decoded_text.present?
      render :decode
    end
  end

  def destroy
    @xor = Xor.find(params[:id])
    @xor.destroy
    redirect_to about_path, notice: 'Message deleted successfully!'
  end


  private

  def xor_params
    params(:xor).permit(:id)
  end

  def save_message(action)
    @xor.user = current_user
    if @xor.save
      flash.now[:notice] = "Message #{action} successfully!"
    else
      flash.now[:alert] = "Failed to #{action} message."
    end
  end

  def valid_key?(key, text)
    key.length == 1 && !text.include?(key)
  end

  def encode_decode(text, key, encoding = true)
    key = key.downcase
    text = text.downcase if encoding

    key = key * (text.length / key.length) + key[0, text.length % key.length]
    puts "Received text: #{text}"
    puts "Received key: #{key}"

    result_text = ""

    text.each_char.with_index do |char, index|
      key_char = key[index]

      # Handle spaces consistently
      if char == ' '
        result_text += ' '
        next
      end

      char_binary = char.ord.to_s(2).rjust(8, '0')
      key_binary = key_char.ord.to_s(2).rjust(8, '0')

      puts "char: #{char}, key_char: #{key_char}"
      puts "char_binary: #{char_binary}, key_binary: #{key_binary}"

      result_char_binary = (char_binary.to_i(2) ^ key_binary.to_i(2)).to_s(2).rjust(8, '0')
      result_char = [result_char_binary].pack('B*')

      puts "result_char_binary: #{result_char_binary}, result_char: #{result_char}"

      result_text += result_char
    end

    puts "Result text: #{result_text}"
    result_text
  end
end
