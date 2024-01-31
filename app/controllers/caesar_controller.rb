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
      save_message('encoded')
      render :encode
    end
  end

  def decode
    @caesar = Caesar.new
    @encoded_text = params[:caesar][:to_decode] if params[:caesar].present?
    if @encoded_text.present?
      @caesar.to_decode = @encoded_text
      @caesar.number = params[:caesar][:number]
      @caesar.to_encode = perform_decoding(@encoded_text, @caesar.number)
      @decoded_text = @caesar.to_encode
      save_message('decoded')
      render :decode
    end
  end

  def destroy
    @caesar = Caesar.find(params[:id])
    @caesar.destroy
    redirect_to about_path, notice: 'Message deleted successfully!'
  end

  private

  def caesar_params
    params.require(:caesar).permit(:id)
  end

  def  save_message(action)
    @caesar.user = current_user

    if @caesar.save
      flash.now[:notice] = "Message #{action} successfully!"
    else
      flash.now[:alert] = "Failed to #{action} message."
    end
  end

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

  def perform_decoding(text, number)
      alphabet = ('a'..'z').to_a
      num = number.to_i
      words = text.split(' ')
      decoded_text = ""

      words.each do |word|
        decoded_word = ""
        word.each_char do |char|
          if alphabet.include?(char)
            i = alphabet.index(char)
            j = (alphabet.length + i - num) % alphabet.length
            letter = alphabet[j]
            decoded_word << letter
          else
            decoded_word << char
          end
        end
        decoded_text << decoded_word
        decoded_text << ' '
      end
      puts "This is the decoded text: #{decoded_text}"
      @decoded_text = decoded_text.strip  # Trim trailing space
    end
end
