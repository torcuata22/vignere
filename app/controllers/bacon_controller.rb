class BaconController < ApplicationController
  def index
  end

  def encode
    @bacon = Bacon.new
    @original_text = params[:bacon][:to_encode].upcase if params[:bacon].present?

    if @original_text.present?
      @bacon.to_encode = @original_text
      @bacon.to_decode = perform_encoding(@original_text)
      @encoded_text = @bacon.to_decode
      puts @encoded_text
      save_message('encoded')
      render :encode
    end

  end

  def decode
    @bacon = Bacon.new
    @encoded_text = params[:bacon][:to_decode] if params[:bacon].present?

    puts "Params received: #{params.inspect}"
    puts "Encoded text: #{@encoded_text}"

    if @encoded_text.present?
      @bacon.to_decode = @encoded_text
      puts "encoded text: #{@bacon.to_decode}"
      @decoded_text = perform_decoding(@encoded_text)
      puts "Decoded text: #{@decoded_text}"  # Print to console
    end
    save_message('decoded') if @decoded_text.present?
    render :decode
  end


  private

  def save_message(action)
      @bacon.user = current_user

      if action == 'encoded' && @bacon.save
        flash.now[:notice] = "Message #{action} successfully!"
      elsif action == 'decoded' && @decoded_text.present?
        @bacon.to_decode = @decoded_text
        if @bacon.save
          flash.now[:notice] = "Message #{action} successfully!"
        else
          flash.now[:alert] = "Failed to #{action} message."
        end
      end
  end



  def perform_encoding(original_text)
    bacon_map = {
      'A' => '00000', 'B' => '00001', 'C' => '00010', 'D' => '00011',
      'E' => '00100', 'F' => '00101', 'G' => '00110', 'H' => '00111',
      'I' => '01000', 'J' => '01001', 'K' => '01010', 'L' => '01011',
      'M' => '01100', 'N' => '01101', 'O' => '01110', 'P' => '01111',
      'Q' => '10000', 'R' => '10001', 'S' => '10010', 'T' => '10011',
      'U' => '10100', 'V' => '10101', 'W' => '10110', 'X' => '10111',
      'Y' => '11000', 'Z' => '11001'
    }

    encoded_text = original_text.chars.map { |char| bacon_map[char] || char }.join
    encoded_text
  end


  def perform_decoding(encoded_text)
    puts "performing decoding on this text: #{encoded_text}"

    bacon_map = {
      '00000' => 'A', '00001' => 'B', '00010' => 'C', '00011' => 'D',
      '00100' => 'E', '00101' => 'F', '00110' => 'G', '00111' => 'H',
      '01000' => 'I', '01001' => 'J', '01010' => 'K', '01011' => 'L',
      '01100' => 'M', '01101' => 'N', '01110' => 'O', '01111' => 'P',
      '10000' => 'Q', '10001' => 'R', '10010' => 'S', '10011' => 'T',
      '10100' => 'U', '10101' => 'V', '10110' => 'W', '10111' => 'X',
      '11000' => 'Y', '11001' => 'Z'
    }

    encoded_text_without_spaces = encoded_text.gsub(/\s+/, '')
    decoded_segments = encoded_text_without_spaces.scan(/.{5}/)
    puts "Decoded segments: #{decoded_segments}"

  decoded_text = decoded_segments.map { |segment| bacon_map[segment] || segment }.join
  puts "Decoded text: #{decoded_text}"
  decoded_text
  end


end
