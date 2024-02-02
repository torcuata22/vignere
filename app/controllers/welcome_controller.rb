class WelcomeController < ApplicationController
  before_action :set_breadcrumbs, only: [:index, :about]

  def index
    add_breadcrumb "Home", :root_path
  end

  def about
    add_breadcrumb "Home", :root_path
    add_breadcrumb "My Messages", :about_path
    @user = current_user
    @bacons = @user.bacons
    @caesars = @user.caesars
    @vigns = @user.vigns
    @xors = @user.xors
  end

  private

  def set_breadcrumbs
    @breadcrumbs = [
      { name: 'Home', path: root_path },
      { name: 'My Messages', path: about_path },
    ]

    # Add dynamic breadcrumb entries for ciphers
    @breadcrumbs << { name: 'Ciphers', path: nil } if controller_name == 'bacon' || controller_name == 'caesar' || controller_name == 'vignere' || controller_name == 'xor'

    # Add specific ciphers entries
    @breadcrumbs << { name: 'Bacon Cipher', path: bacon_index_path } if controller_name == 'bacon'
    @breadcrumbs << { name: 'Caesar Cipher', path: caesar_index_path } if controller_name == 'caesar'
    @breadcrumbs << { name: 'Vignere Cipher', path: vignere_index_path } if controller_name == 'vignere'
    @breadcrumbs << { name: 'XOR Cipher', path: xor_index_path } if controller_name == 'xor'
  end

end
