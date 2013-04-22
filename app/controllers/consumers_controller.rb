class ConsumersController < ApplicationController

  def show
    @consumer = Consumer.find(params[:id])
  end

  def new
    @consumer = Consumer.new
  end

  def edit
    @consumer = Consumer.find(params[:id])
  end

    def create
    @consumer = Consumer.new(params[:consumer])
    if @consumer.save
      session[:consumer_id] = @consumer.id
      redirect_to consumer_path(session[:consumer_id]), notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

    def update
    @consumer = Consumer.find(params[:id])
    if @consumer.update_attributes(params[:consumer])
      flash[:notice] = "Profile updated!"
      redirect_to @consumer
    else
      render :edit
    end
  end

end
