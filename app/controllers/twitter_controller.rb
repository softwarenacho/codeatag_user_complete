class TwitterController < ApplicationController
  
  def twitter_proposal
    @proposal = Proposal.new
  end
  
  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word) 
  end
  
  def add_proposal
    @proposal = Proposal.create(proposal_params)
    @proposal.send_to_codea
    flash[:success] = "Propuesta Agregada"
    redirect_to proposals_path
  end
  
  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar, :twitter_handle)
  end
  
end
