class VignereController < ApplicationController
    
    before_action :authenticate_user!, only: [:index, :encode, :decode]
    
    def index
        
    end

    def encode

    end

    def decode

    end


end
