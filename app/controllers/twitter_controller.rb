class TwitterController < ApplicationController

  # Redirige al usuario a la página de Propuesta con Twitter
  def twitter_proposal
    @proposal = Proposal.new
  end

  # Accede al cliente para buscar usuarios de Twitter
  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word)
  end

  # Añade el usuario de Twitter a nuestras propuestas
  def add_proposal
    @proposal = Proposal.create(proposal_params)
    # Este es el comando que se comunica con CodeaTag para guardar tus propuestas.
    @proposal.send_to_codea
    flash[:success] = "Propuesta Agregada"
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar, :twitter_handle)
  end

end