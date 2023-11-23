class VignereController < ApplicationController
    
    before_action :authenticate_user!, only: [:index, :encode, :decode]
    
    def index
        
    end

    def encode
        puts "Params: #{params.inspect}"
        @vign = Vign.new
        @original_text = params[:vign][:to_encode] if params[:vign].present? 

        if @original_text.present?
            @vign.to_encode = @original_text
            @vign.key = params[:vign][:key]
            @vign.to_decode = perform_encoding(@original_text, @vign.key)
            @encoded_text = @vign.to_decode
            puts "Encoded Text: #{@encoded_text}"
            render :encode
           
        end
        puts "Params: #{params.inspect}, Original Text: #{@original_text}, Key: #{@vign.key}, Encoded Text: #{@vign.to_decode}"
        
    end

    def decode

    end

    private

    def perform_encoding(text, key)
        text_length = text.length
        rep_factor = text_length/key.length
        remainder = text_length%key.length

        final_enc_key = key * rep_factor + key[0...remainder]
        enc_key_arr = key.upcase.chars
        puts "Text: #{text}, Enc key: #{final_enc_key}"

        upper_alphabet = ('A'..'Z').to_a
        alphabet = upper_alphabet

        encoded_text = ""

        text.each_char.with_index do |char, index|
        if alphabet.include?(char.upcase)    
            
            key_char = enc_key_arr[index % enc_key_arr.length].upcase 
            key_position = alphabet.index(key_char.upcase)
            input_char = char.upcase            
            input_position = alphabet.index(input_char)
            encrypted_char = alphabet[(input_position + key_position) % 26]
            encoded_text << encrypted_char

        else  
            encoded_text << char
        end
        puts "Char: #{char}, Key Char: #{key_char}, Key Position: #{key_position}, Input Position: #{input_position}, Encrypted Char: #{encrypted_char}"
        end

        puts "Encoded text: #{encoded_text}"
        encoded_text
    end


end
