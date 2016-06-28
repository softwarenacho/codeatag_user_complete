class ProposalsController < ApplicationController

  def index
    @proposals = Proposal.all.order(:name)
    # render 'proposals/index.html.erb'
  end

  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.save
    flash[:success] = "Propuesta Agregada"
    redirect_to proposals_path
  end

  def show
    @proposal = Proposal.find(params[:id])
    @counter = @proposal.counter_codea.body
    # render 'proposals/show.html.erb'
  end

  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    flash[:success] = "Propuesta actualizada"
    redirect_to proposal_path
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    flash[:danger] = "Propuesta borrada"
    redirect_to proposals_path
  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar)
    end
end